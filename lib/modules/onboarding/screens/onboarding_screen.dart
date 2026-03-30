import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/language_toggle_button.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // top bar with language toggle
            _OnboardingTopBar(controller: controller),

            // page view — illustrations + text
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  // page 1 — trusted by millions
                  _OnboardingPage(
                    illustration: _HandshakeIllustration(),
                    title: AppStrings.onboarding1Title,
                  ),

                  // page 2 — pay bills
                  _OnboardingPage(
                    illustration: _CardPayIllustration(),
                    title: AppStrings.onboarding2Title,
                  ),

                  // page 3 — secure transactions
                  _OnboardingPage(
                    illustration: _SecurePhoneIllustration(),
                    title: AppStrings.onboarding3Title,
                  ),
                ],
              ),
            ),

            // dot indicators
            Obx(() => _DotIndicator(
              total: OnboardingController.totalPages,
              current: controller.currentPage.value,
            )),

            const SizedBox(height: AppSpacing.xxl),

            // next button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: AppButton(
                label: AppStrings.next,
                onPressed: controller.onNextTap,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // skip text link
            GestureDetector(
              onTap: controller.onSkipTap,
              child: Text(
                AppStrings.skip,
                style: AppTypography.link,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// top bar with language toggle aligned right
class _OnboardingTopBar extends StatelessWidget {
  final OnboardingController controller;

  const _OnboardingTopBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // language toggle pill
          LanguageToggleButton(onTap: () {}),
        ],
      ),
    );
  }
}

// single onboarding page — illustration + title
class _OnboardingPage extends StatelessWidget {
  final Widget illustration;
  final String title;

  const _OnboardingPage({
    required this.illustration,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // illustration area
          SizedBox(
            height: 260,
            child: illustration,
          ),

          const SizedBox(height: AppSpacing.xxl),

          // onboarding title text
          Text(
            title,
            style: AppTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// dot indicator row
class _DotIndicator extends StatelessWidget {
  final int total;
  final int current;

  const _DotIndicator({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final bool isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: isActive ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            // active dot is primary, inactive is grey
            color: isActive ? AppColors.primary : AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        );
      }),
    );
  }
}

// ─── illustrations drawn with CustomPainter ───────────────────────────────────

// page 1 — handshake with shield
class _HandshakeIllustration extends StatelessWidget {
  const _HandshakeIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(240, 240),
      painter: _HandshakePainter(),
    );
  }
}

class _HandshakePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // outer shield
    final shieldPath = Path()
      ..moveTo(cx, cy - 80)
      ..lineTo(cx + 52, cy - 55)
      ..lineTo(cx + 52, cy - 10)
      ..quadraticBezierTo(cx + 52, cy + 30, cx, cy + 52)
      ..quadraticBezierTo(cx - 52, cy + 30, cx - 52, cy - 10)
      ..lineTo(cx - 52, cy - 55)
      ..close();

    canvas.drawPath(shieldPath, paint);

    // checkmark inside shield
    final checkPath = Path()
      ..moveTo(cx - 18, cy)
      ..lineTo(cx - 5, cy + 14)
      ..lineTo(cx + 20, cy - 16);

    canvas.drawPath(checkPath, paint);

    // left arm of handshake
    final leftArm = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(cx - 60, cy + 70),
      Offset(cx - 20, cy + 45),
      leftArm,
    );

    // right arm
    canvas.drawLine(
      Offset(cx + 60, cy + 70),
      Offset(cx + 20, cy + 45),
      leftArm,
    );

    // handshake clasp
    final claspPath = Path()
      ..moveTo(cx - 20, cy + 45)
      ..quadraticBezierTo(cx, cy + 38, cx + 20, cy + 45);

    canvas.drawPath(claspPath, paint);

    // left sleeve rectangle
    final sRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx - 70, cy + 72),
        width: 22,
        height: 36,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(sRect, paint);

    // right sleeve rectangle
    final sRect2 = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx + 70, cy + 72),
        width: 22,
        height: 36,
      ),
      const Radius.circular(6),
    );
    canvas.drawRRect(sRect2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// page 2 — hand holding card
class _CardPayIllustration extends StatelessWidget {
  const _CardPayIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(240, 240),
      painter: _CardPayPainter(),
    );
  }
}

class _CardPayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // card body — rotated rectangle
    canvas.save();
    canvas.translate(cx, cy - 30);
    canvas.rotate(-0.45);

    final cardRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: 100, height: 68),
      const Radius.circular(10),
    );
    canvas.drawRRect(cardRect, paint);

    // chip on card
    final chipRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(-20, -8), width: 26, height: 20),
      const Radius.circular(4),
    );
    canvas.drawRRect(chipRect, paint);

    // stripe on card
    canvas.drawLine(
      const Offset(-44, 12),
      const Offset(44, 12),
      paint,
    );

    canvas.restore();

    // hand holding from bottom
    final handPath = Path()
      ..moveTo(cx - 38, cy + 80)
      ..quadraticBezierTo(cx - 42, cy + 40, cx - 20, cy + 20)
      ..quadraticBezierTo(cx, cy + 10, cx + 20, cy + 20)
      ..quadraticBezierTo(cx + 42, cy + 40, cx + 38, cy + 80);

    canvas.drawPath(handPath, paint);

    // thumb
    final thumbPath = Path()
      ..moveTo(cx - 38, cy + 70)
      ..quadraticBezierTo(cx - 65, cy + 55, cx - 55, cy + 35);

    canvas.drawPath(thumbPath, paint);

    // sleeve / cuff
    canvas.drawLine(
      Offset(cx - 40, cy + 82),
      Offset(cx + 40, cy + 82),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// page 3 — shield + phone with plus sign
class _SecurePhoneIllustration extends StatelessWidget {
  const _SecurePhoneIllustration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(240, 240),
      painter: _SecurePhonePainter(),
    );
  }
}

class _SecurePhonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // phone body — right side
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx + 30, cy + 10),
        width: 68,
        height: 110,
      ),
      const Radius.circular(12),
    );
    canvas.drawRRect(phoneRect, paint);

    // phone speaker dot
    canvas.drawCircle(Offset(cx + 30, cy + 52), 5, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke;

    // phone home button
    canvas.drawCircle(Offset(cx + 30, cy + 52), 5, paint);

    // shield — left overlapping phone
    final shieldPath = Path()
      ..moveTo(cx - 22, cy - 72)
      ..lineTo(cx + 8, cy - 56)
      ..lineTo(cx + 8, cy - 20)
      ..quadraticBezierTo(cx + 8, cy + 14, cx - 22, cy + 30)
      ..quadraticBezierTo(cx - 52, cy + 14, cx - 52, cy - 20)
      ..lineTo(cx - 52, cy - 56)
      ..close();

    canvas.drawPath(shieldPath, paint);

    // checkmark inside shield
    final checkPath = Path()
      ..moveTo(cx - 42, cy - 16)
      ..lineTo(cx - 28, cy - 2)
      ..lineTo(cx - 5, cy - 28);

    canvas.drawPath(checkPath, paint);

    // dotted circle around shield
    _drawDottedCircle(
      canvas,
      Offset(cx - 22, cy - 20),
      78,
      paint..color = AppColors.primary.withOpacity(0.4),
    );

    // plus sign — top left of shield
    paint.color = AppColors.primary;
    canvas.drawLine(
      Offset(cx - 66, cy - 66),
      Offset(cx - 66, cy - 46),
      paint,
    );
    canvas.drawLine(
      Offset(cx - 76, cy - 56),
      Offset(cx - 56, cy - 56),
      paint,
    );
  }

  // draw dotted circle
  void _drawDottedCircle(
      Canvas canvas, Offset center, double radius, Paint paint) {
    const int dots = 24;
    const double dotRadius = 3;
    final dotPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < dots; i++) {
      final angle = (i / dots) * 2 * 3.14159;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
    }
  }

  double cos(double angle) => _cos(angle);
  double sin(double angle) => _sin(angle);

  // manual trig (no dart:math import needed in painter)
  static double _cos(double x) {
    // taylor series approximation
    x = x % (2 * 3.14159265);
    double result = 1;
    double term = 1;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
  }

  static double _sin(double x) {
    x = x % (2 * 3.14159265);
    double result = x;
    double term = x;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}