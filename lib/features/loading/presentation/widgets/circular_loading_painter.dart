import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../core/theme/app_colors.dart';

class CircularLoadingPainter extends CustomPainter {
  final double animationValue;

  CircularLoadingPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width / 2, size.height / 2);
    final radius = maxRadius - 15;

    final outerRadius1 = maxRadius + 20;
    final outerRadius2 = maxRadius + 40;

    // Dış çember 1
    final outerCircle1Paint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.primaryWithOpacity(0.8),
          AppColors.primaryWithOpacity(0.1),
          AppColors.primaryWithOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: pi * 2,
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius1))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Dış çember 2
    final outerCircle2Paint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.primaryWithOpacity(0.6),
          AppColors.primaryWithOpacity(0.1),
          AppColors.primaryWithOpacity(0.6),
        ],
        stops: const [0.0, 0.5, 1.0],
        startAngle: 0,
        endAngle: pi * 2,
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Ana çember
    final baseCirclePaint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.greyWithOpacity(0.05),
          AppColors.greyWithOpacity(0.2),
          AppColors.greyWithOpacity(0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    // Dönen gradient çember
    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          AppColors.primaryWithOpacity(0.0),
          AppColors.primaryWithOpacity(0.8),
          AppColors.primaryWithOpacity(0.8),
          AppColors.primaryWithOpacity(0.0),
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
        transform: GradientRotation(-2 * pi * animationValue),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    _drawCircles(canvas, center, outerRadius1, outerRadius2, outerCircle1Paint, outerCircle2Paint);
    _drawDots(canvas, center, outerRadius1, outerRadius2);
    
    canvas.drawCircle(center, radius, baseCirclePaint);
    canvas.drawCircle(center, radius, progressPaint);
  }

  void _drawCircles(Canvas canvas, Offset center, double outerRadius1, double outerRadius2,
      Paint outerCircle1Paint, Paint outerCircle2Paint) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * pi * animationValue * 0.24);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, outerRadius1, outerCircle1Paint);
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(2 * pi * animationValue * 0.12);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, outerRadius2, outerCircle2Paint);
    canvas.restore();
  }

  void _drawDots(Canvas canvas, Offset center, double outerRadius1, double outerRadius2) {
    // İlk çember noktaları
    for (var i = 0; i < 8; i++) {
      final angle = (2 * pi * i / 8) + (2 * pi * animationValue * 0.24);
      final dotOffset = Offset(
        center.dx + outerRadius1 * cos(angle),
        center.dy + outerRadius1 * sin(angle),
      );
      canvas.drawCircle(
        dotOffset,
        2,
        Paint()..color = AppColors.primaryWithOpacity(0.8),
      );
    }

    // İkinci çember noktaları
    for (var i = 0; i < 12; i++) {
      final angle = (2 * pi * i / 12) + (2 * pi * animationValue * 0.12);
      final dotOffset = Offset(
        center.dx + outerRadius2 * cos(angle),
        center.dy + outerRadius2 * sin(angle),
      );
      canvas.drawCircle(
        dotOffset,
        1.5,
        Paint()..color = AppColors.primaryWithOpacity(0.6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 