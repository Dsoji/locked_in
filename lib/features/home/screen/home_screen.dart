import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../widgets/focus_score_indicator.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFE0E0E0), // Slightly darker grey background
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LOCKED IN',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                          color: Colors.black, // Black text
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(IconsaxPlusBold.flash_1,
                              color: Colors.black, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '42',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'PRO',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(IconsaxPlusLinear.export_1,
                              color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Center Orb
                  const FocusScoreIndicator(
                    score: 61,
                    label: 'Focusing',
                  ),
                  const SizedBox(height: 56),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('FOCUS', '61%', Colors.black),
                      _buildStatItem('SCREEN TIME', '8h 40m', Colors.black,
                          hasArrow: true),
                      Column(
                        children: [
                          Text(
                            'CULPRITS',
                            style: GoogleFonts.inter(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(IconsaxPlusBold.instagram,
                                  size: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Icon(IconsaxPlusBold.message,
                                  size: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Icon(IconsaxPlusBold.video_circle,
                                  size: 16, color: Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Daily Insights Card
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daily Insights',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today's update on your focus",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 280,
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE), // Darker card background
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.4,
                            ),
                            children: const [
                              TextSpan(text: 'You could\'ve earned '),
                              TextSpan(
                                text: 'US\$151',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: '\nin the time spent scrolling'),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'FOCUS RECEIPT',
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '2 Feb',
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 24, color: Colors.black12),
                              _buildReceiptRow('TikTok', 'US\$95.85'),
                              const SizedBox(height: 8),
                              _buildReceiptRow('Snapchat', 'US\$31.96'),
                              const SizedBox(height: 8),
                              _buildReceiptRow('Books', 'US\$23.12'),
                              const Divider(height: 24, color: Colors.black12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SUBTOTAL',
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Priceless',
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120), // Bottom padding for FAB
                ],
              ),
            ),
          ),

          // Floating Action Bar
          Positioned(
            bottom: 32, // Adjusted to avoid bottom nav if needed
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Light shadow
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildIconButton(Icons.remove),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '20m',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildIconButton(Icons.add),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade900,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.play_arrow,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Start Timer',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color,
      {bool hasArrow = false}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.black54, // Grey text
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.black26), // Light arrow
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildReceiptRow(String item, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item,
          style: GoogleFonts.spaceMono(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
        Text(
          price,
          style: GoogleFonts.spaceMono(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05), // Light grey bg
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 20), // Black icon
    );
  }
}
