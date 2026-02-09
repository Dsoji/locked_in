import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../usage/data/usage_repository.dart';

final weeklyUsageProvider = FutureProvider<Map<DateTime, int>>((ref) async {
  final repository = ref.watch(usageRepositoryProvider);
  return repository.getWeeklyUsage();
});

@RoutePage()
class StatisticsScreen extends HookConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyUsageAsync = ref.watch(weeklyUsageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usage Statistics'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Focus Time (Last 7 Days)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                child: weeklyUsageAsync.when(
                  data: (usageMap) => _buildBarChart(context, usageMap),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
              const SizedBox(height: 32),
              _buildSummaryCard(weeklyUsageAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, Map<DateTime, int> usageMap) {
    // Sort keys to ensure chronological order
    final sortedKeys = usageMap.keys.toList()..sort((a, b) => a.compareTo(b));

    // Find max value for Y-axis scaling (add buffer)
    final maxSeconds = usageMap.values.isEmpty
        ? 0
        : usageMap.values.reduce((a, b) => a > b ? a : b);
    final maxY = (maxSeconds / 60).ceil().toDouble() + 10; // in minutes

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()} mins',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < sortedKeys.length) {
                  final date = sortedKeys[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('E').format(date), // Mon, Tue...
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // Show grid lines every 30 mins or so depending on scale
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}m',
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(sortedKeys.length, (index) {
          final date = sortedKeys[index];
          final seconds = usageMap[date] ?? 0;
          final minutes = seconds / 60;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: minutes,
                color: Colors.black,
                width: 16,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSummaryCard(AsyncValue<Map<DateTime, int>> usageAsync) {
    return usageAsync.when(
      data: (usageMap) {
        final totalSeconds =
            usageMap.values.fold<int>(0, (sum, val) => sum + val);
        final totalHours = totalSeconds / 3600;
        final avgSeconds =
            usageMap.isEmpty ? 0 : totalSeconds / usageMap.length;
        final avgMinutes = (avgSeconds / 60).round();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text('Total Focus',
                      style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(
                    '${totalHours.toStringAsFixed(1)}h',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(width: 1, height: 40, color: Colors.blue[100]),
              Column(
                children: [
                  const Text('Daily Average',
                      style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(
                    '${avgMinutes}m',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
