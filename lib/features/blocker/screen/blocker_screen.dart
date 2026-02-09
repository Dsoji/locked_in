import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_time_blocker/screen_time_blocker.dart';

import '../service/screen_blocker_service.dart';

@RoutePage()
class BlockerScreen extends HookConsumerWidget {
  const BlockerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockerService = ref.watch(screenBlockerServiceProvider);
    final selectionSummary = useState<SelectionSummary?>(null);
    final isAuthorized = useState<bool>(false);

    useEffect(() {
      Future<void> checkStatus() async {
        final status = await blockerService.getAuthorizationStatus();
        isAuthorized.value = status == AuthorizationStatus.approved;
        if (status == AuthorizationStatus.approved) {
          final summary = await blockerService.getSelectionSummary();
          selectionSummary.value = summary;
        }
      }

      checkStatus();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Blocker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isAuthorized.value)
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Permission Required',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'To block apps, you need to grant permission to access Screen Time settings.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final granted =
                              await blockerService.requestAuthorization();
                          isAuthorized.value = granted;
                        },
                        child: const Text('Grant Permission'),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (isAuthorized.value) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Blocked Apps',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (selectionSummary.value != null)
                        Text(
                          '${selectionSummary.value?.apps ?? 0} Apps, ${selectionSummary.value?.categories ?? 0} Categories selected',
                          style: const TextStyle(fontSize: 16),
                        )
                      else
                        const Text('No apps selected'),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.apps),
                        label: const Text('Select Apps to Block'),
                        onPressed: () async {
                          final summary =
                              await blockerService.selectAppsToBlock();
                          selectionSummary.value = summary;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                await blockerService.blockNow();
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Blocking started!')),
                                );
                              },
                              child: const Text('Block Now'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                await blockerService.stopAllSchedules();
                                await blockerService.unblockUntilNextSchedule();
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Blocking stopped.')),
                                );
                              },
                              child: const Text('Stop Blocking'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
