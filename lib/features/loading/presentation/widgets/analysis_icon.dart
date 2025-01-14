import 'package:animation_assigment/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalysisIcon extends StatefulWidget {
  final double size;
  final Color color;

  const AnalysisIcon({
    super.key,
    this.size = 10,
    this.color = const Color.fromARGB(255, 7, 171, 149),
  });

  @override
  State<AnalysisIcon> createState() => _AnalysisIconState();
}

class _AnalysisIconState extends State<AnalysisIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _AnalysisIconPainter(
            animation: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _AnalysisIconPainter extends CustomPainter {
  final double animation;
  final Color color;

  _AnalysisIconPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 5;

    // Arka plan için beyaz yarı saydam daire
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.9, backgroundPaint);

    // Dış halka
    final outerRingPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(center, radius * 0.8, outerRingPaint);

    // Dönen halka
    final rotatingArcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final rotatingArcRect = Rect.fromCircle(center: center, radius: radius * 0.8);
    canvas.drawArc(
      rotatingArcRect,
      animation * 2 * math.pi,
      math.pi / 2,
      false,
      rotatingArcPaint,
    );

    // Hareket eden noktalar
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 3; i++) {
      final angle = (animation * 2 * math.pi) + (i * 2 * math.pi / 3);
      final dotRadius = 3.0;
      final x = center.dx + math.cos(angle) * radius * 0.6;
      final y = center.dy + math.sin(angle) * radius * 0.6;
      canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
    }

    // İç çizgiler
    final linePaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    for (var i = 0; i < 4; i++) {
      final angle = (animation * math.pi) + (i * math.pi / 2);
      final startX = center.dx + math.cos(angle) * radius * 0.3;
      final startY = center.dy + math.sin(angle) * radius * 0.3;
      final endX = center.dx + math.cos(angle) * radius * 0.5;
      final endY = center.dy + math.sin(angle) * radius * 0.5;
      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 