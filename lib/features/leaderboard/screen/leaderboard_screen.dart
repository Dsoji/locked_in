import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

@RoutePage()
@RoutePage()
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Darker Greyscale Theme
    final backgroundColor = const Color(0xFFE0E0E0);
    final cardColor = const Color(0xFFEEEEEE);
    final textPrimary = Colors.black;
    final textSecondary = Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LEADERBOARD',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      color: textPrimary,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(IconsaxPlusBold.global,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Global',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Podium Top 3
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPodiumItem(2, 'Alex', '850', 120, textPrimary),
                  _buildPodiumItem(1, 'You', '1,240', 160, textPrimary,
                      isChampion: true),
                  _buildPodiumItem(3, 'Sarah', '720', 100, textPrimary),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // List of Rankers
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final rank = index + 4;
                    // Mock current user at rank 12
                    final isCurrentUser = rank == 12;

                    if (isCurrentUser) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          leading: Text(
                            '#$rank',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'You',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Text(
                            '450 pts',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              '#$rank',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: textSecondary,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: Icon(IconsaxPlusBold.user,
                                size: 18, color: Colors.grey[400]),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'User $rank',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(600 - index * 10)} pts',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: textPrimary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem(
      int rank, String name, String score, double height, Color textColor,
      {bool isChampion = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: isChampion ? 32 : 24,
          backgroundColor: isChampion ? Colors.black : Colors.white,
          child: Icon(
            IconsaxPlusBold.user,
            size: isChampion ? 28 : 20,
            color: isChampion ? Colors.white : Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: isChampion ? 100 : 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isChampion
                  ? [Colors.black, Colors.grey.shade800]
                  : [Colors.white, Colors.grey.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '#$rank',
                style: GoogleFonts.inter(
                  fontSize: isChampion ? 24 : 18,
                  fontWeight: FontWeight.w900,
                  color: isChampion ? Colors.white24 : Colors.black12,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: isChampion ? 16 : 14,
            color: textColor,
          ),
        ),
        Text(
          score,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
