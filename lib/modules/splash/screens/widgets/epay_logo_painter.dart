import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EPayLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.width * 0.42;
    final double strokeW = size.width * 0.11;

    // arc paint — navy blue ring
    final arcPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    // draw the open "c" arc (270° sweep, leaving gap at top-right)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      -2.2, // start angle (slightly past top)
      5.0,  // sweep angle (almost full circle)
      false,
      arcPaint,
    );

    // orange dot — accent mark at gap end
    final dotPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;

    // position dot at top-right of arc opening
    final dotX = cx + radius * 0.62;
    final dotY = cy - radius * 0.70;
    canvas.drawCircle(
      Offset(dotX, dotY),
      strokeW * 0.52,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}