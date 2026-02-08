import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_time_blocker/screen_time_blocker.dart';

import 'core/theme/app_theme.dart';
import 'features/blocker/service/screen_blocker_service.dart';
import 'features/home/screen/main_screen.dart';
import 'features/onboarding/screen/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final onboardingStateProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(screenBlockerServiceProvider);
  final isSupported = await service.isSupported();

  if (!isSupported) {
    // If not supported (e.g. Android < 5.0 or iOS < 15), we might just show Home
    // or handle gracefully. For now, let's treat as authorized to bypass onboarding loop
    // if we can't do anything about it, or Unauthorized if we want to block them.
    // Let's assume on iOS it is supported.
    return true;
  }

  final status = await service.getAuthorizationStatus();
  return status == AuthorizationStatus.approved;
});

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Locked In',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: onboardingState.when(
        data: (isAuthorized) =>
            isAuthorized ? const MainScreen() : const OnboardingScreen(),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (err, stack) => Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
