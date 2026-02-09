import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'app_router.dart';

@RoutePage()
class MainShellScreen extends HookConsumerWidget {
  const MainShellScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        BlockRoute(),
        LeaderboardRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: const Color(0xFFE0E0E0),
            indicatorColor: Colors.black12,
            surfaceTintColor: Colors.transparent,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const IconThemeData(color: Colors.black);
              }
              return const IconThemeData(color: Colors.black54);
            }),
          ),
          child: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            // Ensure the NavigationBar itself uses the transparent/background colors
            backgroundColor: const Color(0xFFE0E0E0),
            surfaceTintColor: const Color(0xFFE0E0E0),
            destinations: const [
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.home, size: 24),
                selectedIcon: Icon(IconsaxPlusBold.home, size: 24),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.shapes, size: 24),
                selectedIcon: Icon(IconsaxPlusBold.shapes, size: 24),
                label: 'Block',
              ),
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.ranking, size: 24),
                selectedIcon: Icon(IconsaxPlusBold.ranking, size: 24),
                label: 'Leaderboard',
              ),
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.user, size: 24),
                selectedIcon: Icon(IconsaxPlusBold.user, size: 24),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
