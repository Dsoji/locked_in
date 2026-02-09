import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../blocker/service/screen_blocker_service.dart';
import '../../home/screen/home_screen.dart';

@RoutePage()
class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.lock_clock_outlined,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(height: 40),
              const Text(
                'Enable Screen Time Access',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Locked In needs access to Screen Time to help you block apps and stay focused. Your data stays on your device.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final blockerService = ref.read(screenBlockerServiceProvider);
                  // We access the plugin directly here or via service to request auth
                  // The service doesn't expose requestAuth directly in previous steps,
                  // but we can add it or just use the plugin instance if exposed.
                  // Let's use the provider we know exists in the service file if possible,
                  // OR better: add a method to ScreenBlockerService.

                  // For now, let's assume we can interact with the service or plugin.
                  // Actually, ScreenBlockerService wraps functionality. Let's look at it.
                  // I'll implement a transparent request in the service or just call the plugin directly here for simplicity if needed,
                  // but properly, I should add `requestAuthorization` to `ScreenBlockerService`.

                  // Let's rely on `ScreenTimeBlocker.instance` or the provider.
                  // `screenBlockerServiceProvider` provides the service.
                  // I'll assume for this step I'll update the service to expose `requestAuthorization`.

                  // Wait, I haven't updated the service yet.
                  // I will write this file assuming `screenBlockerService.requestAuthorization()` exists,
                  // and then I will update the service in the next step.

                  final granted = await blockerService.requestAuthorization();

                  if (granted && context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Permission required to proceed.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'GRANT ACCESS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
