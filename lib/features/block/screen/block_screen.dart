import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

@RoutePage()
class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Greyscale Light Theme (Darker)
    final backgroundColor =
        const Color(0xFFE0E0E0); // Slightly darker grey background
    final cardColor = const Color(0xFFEEEEEE); // Darker card color
    final textPrimary = Colors.black;
    final textSecondary =
        const Color(0xFF666666); // Dark grey for secondary text

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Blocks',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      _buildHeaderButton(
                          IconsaxPlusLinear.setting_2, textPrimary,
                          backgroundColor: cardColor),
                      const SizedBox(width: 12),
                      _buildHeaderButton(Icons.add, Colors.white,
                          backgroundColor: Colors.black),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // "Now" Section
              Text(
                'Now',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.none,
                  ),
                ),
                child: CustomPaint(
                  painter: _DashedBorderPainter(
                      color: Colors.black26, strokeWidth: 2, radius: 24),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.black54, size: 24),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Limit App or Website',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Reload Blocks Link
              Row(
                children: [
                  Icon(IconsaxPlusLinear.refresh,
                      size: 16, color: textSecondary),
                  const SizedBox(width: 6),
                  Text(
                    'Have an issue? Reload Blocks',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // "Upcoming" Section
              Text(
                'Upcoming',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              _buildUpcomingCard(
                title: 'Work Time',
                subtitle: 'Weekdays, 9:00 - 17:00',
                badgeText: 'Starting in 11h 6m',
                icon: IconsaxPlusBold.monitor,
                cardColor: cardColor,
                textColor: textPrimary,
                iconColor: Colors.black87,
              ),
              const SizedBox(height: 12),
              _buildUpcomingCard(
                title: 'Weekend Zen',
                subtitle: 'Weekends, 9:00 - 11:00',
                badgeText: 'Starting Saturday',
                icon: IconsaxPlusBold.moon,
                cardColor: cardColor,
                textColor: textPrimary,
                iconColor: Colors.black87,
              ),

              const SizedBox(height: 40),

              // "Get More Done" Section
              Text(
                'Get More Done',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Maximize your productivity while staying sane.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _buildCollectionCard(
                      title: 'Laser Focus',
                      description: 'Your daily focus hour from 2-3pm, Weekdays',
                      imagePath: 'assets/images/focus_bg.png', // Placeholder
                      gradientColors: [
                        const Color(0xFFE0E0E0),
                        const Color(0xFFF5F5F5)
                      ],
                      textColor: Colors.black,
                      descriptionColor: Colors.black87,
                    ),
                    const SizedBox(width: 16),
                    _buildCollectionCard(
                      title: 'Rise & Shine',
                      description: 'Wake up without distraction 6-9am Daily',
                      imagePath: 'assets/images/morning_bg.png', // Placeholder
                      gradientColors: [
                        const Color(0xFFD6D6D6),
                        const Color(0xFFEFEFEF)
                      ],
                      textColor: Colors.black,
                      descriptionColor: Colors.black87,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // "Sleep, Relax and Reset" Section
              Text(
                'Sleep, Relax and Reset',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sleep better, rise refreshed.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _buildCollectionCard(
                      title: 'Wind Down',
                      description: 'Great sleep starts before bed, 8pm-10pm',
                      gradientColors: [
                        const Color(0xFFE0E0E0),
                        const Color(0xFFCCCCCC)
                      ],
                      textColor: Colors.black,
                      descriptionColor: Colors.black87,
                    ),
                    const SizedBox(width: 16),
                    _buildCollectionCard(
                      title: 'Deep Sleep',
                      description: 'Boost your sleep\'s restorative qualities',
                      gradientColors: [
                        const Color(0xFFD1D1D1),
                        const Color(0xFFBDBDBD)
                      ],
                      textColor: Colors.black,
                      descriptionColor: Colors.black87,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, Color iconColor,
      {Color? backgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2C2C2C),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }

  Widget _buildUpcomingCard({
    required String title,
    required String subtitle,
    required String badgeText,
    required IconData icon,
    required Color cardColor,
    required Color textColor,
    Color iconColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white30),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(IconsaxPlusLinear.clock,
                          size: 14, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        badgeText,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard({
    required String title,
    required String description,
    String? imagePath,
    required List<Color> gradientColors,
    Color textColor = Colors.white,
    Color descriptionColor = Colors.white70,
  }) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background Image (if we had real assets, for now just gradient)
          // Padding content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon at the top
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(IconsaxPlusBold.lamp_1,
                      color: descriptionColor, size: 20), // Placeholder icon
                ),
                const Spacer(),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: descriptionColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: textColor, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Add',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.radius = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    // Using manual path metric iteration for dashed border as implemented in _drawDashedPath

    // Flutter's PathDashPathEffect is a bit complex for simple rounded dashed borders sometimes.
    // A simpler approach for rounded rects is iterating the path metric.
    // However, for simplicity in this artifact, let's use a standard path metric approach or just draw it manually if needed.
    // Actually, `dash_painter` or similar packages are best, but I don't want to add deps.
    // Let's standard dash effect using paint.

    // NOTE: Paint().maskFilter doesn't do dashes. We need a path effect.
    // Since dart:ui isn't imported, I cannot use PathDashPathEffect easily without correct imports.
    // Standard approach:

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    // Simple implementation of drawing a dashed path
    // Getting path metrics
    final orgPathMetrics = path.computeMetrics();
    for (var metric in orgPathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final double len = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        final Path extractPath = metric.extractPath(distance, distance + len);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
