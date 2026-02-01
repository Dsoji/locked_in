import 'package:flutter/material.dart';

class FocusScoreIndicator extends StatefulWidget {
  final double score;
  final String label;

  const FocusScoreIndicator({
    super.key,
    required this.score,
    required this.label,
  });

  @override
  State<FocusScoreIndicator> createState() => _FocusScoreIndicatorState();
}

class _FocusScoreIndicatorState extends State<FocusScoreIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background Glow
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.05 + (_controller.value * 0.05)), // Dark glow
                        blurRadius: 60,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
            // Main Orb
            SizedBox(
              width: 220,
              height: 220,
              child: CustomPaint(
                painter: _OrbPainter(
                  score: widget.score,
                ),
              ),
            ),
            // Text Content
            Column(
              children: [
                Text(
                  widget.score.toInt().toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    color: Colors.black, // Black text
                    shadows: [
                      const Shadow(
                        color: Colors.white,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                Text(
                  'FOCUS SCORE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        letterSpacing: 2,
                        color: Colors.black54, // Grey text
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05), // Light container
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified,
                  color: Colors.black, size: 16), // Black icon
              const SizedBox(width: 8),
              Text(
                widget.label.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black, // Black text
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrbPainter extends CustomPainter {
  final double score;

  _OrbPainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Orb Gradient (Light Greyscale/Silver look)
    final gradient = RadialGradient(
      colors: [
        Colors.white,
        Colors.grey.shade100,
        Colors.grey.shade300,
        Colors.grey.shade400,
      ],
      stops: const [0.0, 0.5, 0.85, 1.0],
      center: const Alignment(-0.3, -0.3),
      radius: 1.2,
    );

    final paint = Paint()
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);

    // Inner shadow/rim
    final rimPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius, rimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
