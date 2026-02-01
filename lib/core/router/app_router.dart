import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:locked_in/core/router/shell_screen.dart'
    hide ProfileScreen, BlockScreen;
import 'package:locked_in/features/onboarding/screen/onboarding_screen.dart';

import '../../features/auth/screen/auth_screen.dart';
import '../../features/block/screen/block_screen.dart';
import '../../features/home/screen/home_screen.dart';
import '../../features/leaderboard/screen/leaderboard_screen.dart';
import '../../features/profile/screen/profile_screen.dart';
import 'main_shell.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // Onboarding & Auth
        AutoRoute(
          page: OnboardingRoute.page,
          initial: true,
        ),
        AutoRoute(page: AuthRoute.page),

        // Main Dashboard Shell
        AutoRoute(
          page: MainShellRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: LeaderboardRoute.page),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: BlockRoute.page),
          ],
        ),
      ];
}
