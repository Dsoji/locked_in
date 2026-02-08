import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../settings/screen/settings_screen.dart';
import '../../usage/screen/statistics_screen.dart';
import 'home_screen.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    final screens = [
      const HomeScreen(),
      const StatisticsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (index) {
          selectedIndex.value = index;
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
  }
}
