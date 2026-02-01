import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/focus_score_indicator.dart';
import '../widgets/metric_card.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCKED IN'),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Good evening,',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            Text(
              'Ready to focus?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            const Center(
              child: FocusScoreIndicator(
                score: 82.0,
                label: 'Highly focused',
              ),
            ),
            const SizedBox(height: 48),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: const [
                MetricCard(
                  title: 'Saved Time',
                  value: '4h 12m',
                  subtitle: '+12% from yesterday',
                  icon: Icons.timer_outlined,
                ),
                MetricCard(
                  title: 'Deep Work',
                  value: '3 slots',
                  subtitle: '2 remaining today',
                  icon: Icons.auto_graph_rounded,
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('START FOCUS SESSION'),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RECENT SESSIONS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black45,
                        letterSpacing: 1.2,
                      ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRecentSession(
              context,
              'Social Media Block',
              '2h 00m',
              'Focused',
              Icons.block_flipped,
            ),
            _buildRecentSession(
              context,
              'Deep Work Alpha',
              '1h 30m',
              'Highly Effective',
              Icons.psychology_outlined,
            ),
            const SizedBox(height: 40),
          ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            duration,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
