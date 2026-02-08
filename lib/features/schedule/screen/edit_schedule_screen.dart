import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../blocker/service/screen_blocker_service.dart';
import '../data/schedule_repository.dart';
import '../model/schedule_model.dart';

class EditScheduleScreen extends HookConsumerWidget {
  final ScheduleModel? schedule;

  const EditScheduleScreen({super.key, this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: schedule?.name);
    final startTime = useState<TimeOfDay>(
        schedule?.startTime ?? const TimeOfDay(hour: 9, minute: 0));
    final endTime = useState<TimeOfDay>(
        schedule?.endTime ?? const TimeOfDay(hour: 17, minute: 0));
    final selectedWeekdays =
        useState<List<int>>(schedule?.weekdays ?? [1, 2, 3, 4, 5]);

    // Generate a temporary ID for new schedules so we can select apps for it immediately
    final scheduleId = useMemoized(() => schedule?.id ?? const Uuid().v4());

    final formKey = useMemoized(() => GlobalKey<FormState>());

    Future<void> saveSchedule() async {
      if (formKey.currentState!.validate()) {
        final newSchedule = ScheduleModel(
          id: scheduleId,
          name: nameController.text,
          startTime: startTime.value,
          endTime: endTime.value,
          weekdays: selectedWeekdays.value,
          isEnabled: true,
        );

        try {
          final repository = ref.read(scheduleRepositoryProvider);
          final blockerService = ref.read(screenBlockerServiceProvider);

          if (schedule != null) {
            // Update schedule
            await repository.updateSchedule(newSchedule);
            // Re-schedule blocking (cancel old first implicitly by overwriting or explicitly)
            await blockerService.cancelSchedule(schedule!);
          } else {
            await repository.addSchedule(newSchedule);
          }

          await blockerService.scheduleBlocking(newSchedule);

          if (context.mounted) Navigator.of(context).pop();
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error saving schedule: $e')));
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(schedule == null ? 'New Schedule' : 'Edit Schedule'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Schedule Name',
                    hintText: 'e.g., Deep Work, Sleep',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildSectionHeader(context, 'Blocking Configuration'),
                const SizedBox(height: 16),
                _buildAppSelectionCard(context, ref, scheduleId),
                const SizedBox(height: 24),
                _buildTimeSection(context, startTime, endTime),
                const SizedBox(height: 24),
                const Text(
                  'Repeat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final dayIndex = index + 1;
                    final isSelected =
                        selectedWeekdays.value.contains(dayIndex);
                    final dayLabel = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index];

                    return FilterChip(
                      label: Text(dayLabel),
                      selected: isSelected,
                      onSelected: (selected) {
                        final current = List<int>.from(selectedWeekdays.value);
                        if (selected) {
                          current.add(dayIndex);
                          current.sort();
                        } else {
                          current.remove(dayIndex);
                        }
                        selectedWeekdays.value = current;
                      },
                      showCheckmark: false,
                      selectedColor: Colors.black,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: saveSchedule,
                    child: const Text(
                      'SAVE SCHEDULE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppSelectionCard(
      BuildContext context, WidgetRef ref, String scheduleId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.apps, size: 28, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Blocked Apps',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Select apps to block for this schedule',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(screenBlockerServiceProvider)
                  .selectAppsForSchedule(scheduleId);
            },
            child: const Text('SELECT'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            letterSpacing: 1.0,
          ),
    );
  }

  Widget _buildTimeSection(BuildContext context,
      ValueNotifier<TimeOfDay> startTime, ValueNotifier<TimeOfDay> endTime) {
    return Row(
      children: [
        Expanded(
          child: _buildTimePicker(
            context,
            'Start Time',
            startTime.value,
            (t) => startTime.value = t,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimePicker(
            context,
            'End Time',
            endTime.value,
            (t) => endTime.value = t,
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(BuildContext context, String label, TimeOfDay time,
      Function(TimeOfDay) onTimeChanged) {
    return InkWell(
      onTap: () async {
        final picked =
            await showTimePicker(context: context, initialTime: time);
        if (picked != null) onTimeChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(time.format(context)),
      ),
    );
  }
}
