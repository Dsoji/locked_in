import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../blocker/service/screen_blocker_service.dart';
import '../data/schedule_repository.dart';
import '../model/schedule_model.dart';
import 'edit_schedule_screen.dart';

final schedulesStreamProvider = StreamProvider<List<ScheduleModel>>((ref) {
  final repository = ref.watch(scheduleRepositoryProvider);
  return repository.watchSchedules();
});

class ScheduleListScreen extends HookConsumerWidget {
  const ScheduleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsyncValue = ref.watch(schedulesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditScheduleScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: schedulesAsyncValue.when(
        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(
              child: Text(
                'No schedules yet.\nTap + to create one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: schedules.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return _ScheduleCard(schedule: schedule);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _ScheduleCard extends HookConsumerWidget {
  final ScheduleModel schedule;

  const _ScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          schedule.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${schedule.startTime.format(context)} - ${schedule.endTime.format(context)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatWeekdays(schedule.weekdays),
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
        trailing: Switch(
          value: schedule.isEnabled,
          activeColor: Colors.black,
          onChanged: (value) async {
            final repository = ref.read(scheduleRepositoryProvider);
            await repository.toggleSchedule(schedule.id, value);

            final blockerService = ref.read(screenBlockerServiceProvider);
            if (value) {
              await blockerService.scheduleBlocking(schedule);
            } else {
              await blockerService.cancelSchedule(schedule);
            }
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditScheduleScreen(schedule: schedule),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Schedule'),
              content:
                  Text('Are you sure you want to delete "${schedule.name}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final repository = ref.read(scheduleRepositoryProvider);
                    final blockerService =
                        ref.read(screenBlockerServiceProvider);

                    await blockerService.cancelSchedule(schedule);
                    await repository.deleteSchedule(schedule.id);

                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatWeekdays(List<int> weekdays) {
    if (weekdays.length == 7) return 'Every day';
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays.map((d) => days[d - 1]).join(', ');
  }
}
