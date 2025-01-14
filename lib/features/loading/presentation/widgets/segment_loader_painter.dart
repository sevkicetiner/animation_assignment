import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/loading_config.dart';

class SegmentLoaderPainter extends CustomPainter {
  final double animationValue;
  final LoadingConfig config;

  SegmentLoaderPainter({
    required this.animationValue,
    this.config = const LoadingConfig(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < config.segmentCount; i++) {
      final progress = (animationValue + i / config.segmentCount) % 1;
      final alpha = (sin(progress * pi) * 255).toInt();

      final color = Color.lerp(
        AppColors.primaryWithOpacity(0.9),
        AppColors.primaryWithOpacity(0.3),
        i / config.segmentCount,
      )!;
      paint.color = color.withAlpha(alpha);

      final angle = config.gapAngle * pi / config.segmentCount * i;
      
      final x = center.dx + (radius - config.segmentHeight / 2) * cos(angle);
      final y = center.dy + (radius - config.segmentHeight / 2) * sin(angle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(0, 0),
            width: config.segmentWidth,
            height: config.segmentHeight,
          ),
          const Radius.circular(8),
        ),
        paint,
      );
      canvas.restore();

      if (alpha > 200) {
        final glowPaint = Paint()
          ..color = color.withOpacity(config.glowIntensity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
          ..style = PaintingStyle.fill;
        
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(angle);

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset(0, 0),
              width: config.segmentWidth + 6,
              height: config.segmentHeight + 4,
            ),
            const Radius.circular(8),
          ),
          glowPaint,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 