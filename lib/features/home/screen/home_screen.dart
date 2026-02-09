import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../core/widgets/gradient_background.dart';
import '../../blocker/screen/blocker_screen.dart';
import '../../schedule/screen/schedule_list_screen.dart';
import '../../settings/screen/settings_screen.dart';
import '../../usage/data/usage_repository.dart';
import '../widgets/focus_score_indicator.dart';
import '../widgets/metric_card.dart';

class HomeDashboardData {
  final int todayUsageSeconds;
  final int yesterdayUsageSeconds;
  final int deepWorkSlots;

  HomeDashboardData({
    required this.todayUsageSeconds,
    required this.yesterdayUsageSeconds,
    required this.deepWorkSlots,
  });
}

final homeDashboardDataProvider =
    FutureProvider<HomeDashboardData>((ref) async {
  final repository = ref.watch(usageRepositoryProvider);
  final today = await repository.getTodayUsageSeconds();
  final yesterday = await repository.getYesterdayUsageSeconds();
  final deepWork = await repository.getDeepWorkSlotsToday();

  return HomeDashboardData(
    todayUsageSeconds: today,
    yesterdayUsageSeconds: yesterday,
    deepWorkSlots: deepWork,
  );
});

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(homeDashboardDataProvider);

    return GradientBackground(
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // refresh data
            return ref.refresh(homeDashboardDataProvider.future);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Locked In',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.5),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(IconsaxPlusLinear.chart_2),
                          tooltip: 'Statistics',
                          onPressed: () {
                            // ...
                          },
                        ),
                        IconButton(
                          icon: const Icon(IconsaxPlusLinear.setting_2),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                dashboardDataAsync.when(
                  data: (data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good evening,',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black54,
                            ),
                      ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                      Text(
                        'Ready to focus?',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 600.ms)
                          .slideX(begin: -0.2),
                      const SizedBox(height: 40),
                      Center(
                        child: FocusScoreIndicator(
                          score: _calculateFocusScore(data),
                          label: _getFocusLabel(_calculateFocusScore(data)),
                        ),
                      ).animate().scale(
                          delay: 400.ms,
                          duration: 600.ms,
                          curve: Curves.easeOutBack),
                      const SizedBox(height: 48),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                        children: [
                          MetricCard(
                            title: 'Saved Time',
                            value: _formatDuration(data.todayUsageSeconds),
                            subtitle: _calculateTrend(data.todayUsageSeconds,
                                data.yesterdayUsageSeconds),
                            icon: IconsaxPlusLinear.timer_1,
                            color: Colors.black,
                          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                          MetricCard(
                            title: 'Deep Work',
                            value: '${data.deepWorkSlots}',
                            subtitle: 'Sessions completed',
                            icon: IconsaxPlusLinear.activity,
                            color: Colors.black,
                          ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
                        ],
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BlockerScreen(),
                            ),
                          );
                        },
                        child: const Text('START FOCUS SESSION'),
                      ).animate().fadeIn(delay: 800.ms).scale(),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RECENT SESSIONS',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.black45,
                                  letterSpacing: 1.2,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Navigate to session history
                            },
                            child: const Text(
                              'See all',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 900.ms),
                      const SizedBox(height: 8),
                      _buildRecentSession(
                        context,
                        'Social Media Block',
                        '2h 00m',
                        'Focused',
                        IconsaxPlusLinear.close_circle,
                      ).animate().fadeIn(delay: 1000.ms).slideX(begin: 0.2),
                      _buildRecentSession(
                        context,
                        'Deep Work Alpha',
                        '1h 30m',
                        'Highly Effective',
                        IconsaxPlusLinear.monitor,
                      ).animate().fadeIn(delay: 1100.ms).slideX(begin: 0.2),
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(IconsaxPlusLinear.security_safe),
                              label: const Text('MANAGE APP BLOCKING'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const BlockerScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              icon: const Icon(IconsaxPlusLinear.calendar_1),
                              label: const Text('MANAGE SCHEDULES'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                side: const BorderSide(
                                    color: Colors.black, width: 2),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScheduleListScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.2),
                      const SizedBox(height: 40),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSession(
    BuildContext context,
    String title,
    String duration,
    String status,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 24, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              duration,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateFocusScore(HomeDashboardData data) {
    // Simple logic:
    // - 10 points per hour saved
    // - 15 points per deep work slot
    // Cap at 100
    final hours = data.todayUsageSeconds / 3600;
    final score = (hours * 10) + (data.deepWorkSlots * 15);
    return score.clamp(0.0, 100.0);
  }

  String _getFocusLabel(double score) {
    if (score >= 70) return 'Highly focused';
    if (score >= 30) return 'Focused';
    return 'Distracted';
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String _calculateTrend(int today, int yesterday) {
    if (yesterday == 0) {
      return '+100% from yesterday';
    } // Handle division by zero
    final difference = today - yesterday;
    final percentage = (difference / yesterday * 100).round();
    final sign = percentage >= 0 ? '+' : '';
    return '$sign$percentage% from yesterday';
  }
}
