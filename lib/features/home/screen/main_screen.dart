import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: [
        const HomeRoute(),
        StatisticsRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) {
              tabsRouter.setActiveIndex(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.home),
                selectedIcon: Icon(IconsaxPlusBold.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.chart_2),
                selectedIcon: Icon(IconsaxPlusBold.chart_2),
                label: 'Stats',
              ),
              NavigationDestination(
                icon: Icon(IconsaxPlusLinear.setting_2),
                selectedIcon: Icon(IconsaxPlusBold.setting_2),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
