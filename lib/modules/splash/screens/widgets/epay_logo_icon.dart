import 'package:flutter/material.dart';

import 'epay_logo_painter.dart';

class EPayLogoIcon extends StatelessWidget {
  const EPayLogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: EPayLogoPainter(),
      ),
    );
  }
}