import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/app_text_field.dart';
import '../../../shared/common_widgets/language_toggle_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top bar — back + language
                _LoginTopBar(),

                const SizedBox(height: AppSpacing.xxl),

                // screen title
                Text(
                  AppStrings.loginTitle,
                  style: AppTypography.headlineLarge,
                ),

                const SizedBox(height: AppSpacing.xxl),

                // phone number field
                AppTextField(
                  label: AppStrings.phoneNumber,
                  hint: '01701*****4',
                  controller: controller.phoneController,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validatePhone,
                ),

                const SizedBox(height: AppSpacing.lg),

                // 6-digit pin field
                AppTextField(
                  label: AppStrings.enterSixDigitPin,
                  hint: '123456',
                  controller: controller.pinController,
                  isRequired: true,
                  isPassword: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validatePin,
                ),

                const SizedBox(height: AppSpacing.sm),

                // forgot pin link — right aligned
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: controller.onForgotPinTap,
                    child: Text(
                      AppStrings.forgotPin,
                      style: AppTypography.link,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // login button
                Obx(() => controller.isLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
                    : AppButton(
                  label: AppStrings.logIn,
                  onPressed: controller.onLoginTap,
                )),

                const SizedBox(height: AppSpacing.xxxl),

                // biometric fingerprint button
                Center(
                  child: GestureDetector(
                    onTap: controller.onBiometricTap,
                    child: _FingerprintIcon(),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // don't have an account — sign up
                _SignUpRow(controller: controller),

                const SizedBox(height: AppSpacing.xxxl),

                // contact us row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${AppStrings.didYouFaceIssue} ',
                      style: AppTypography.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppStrings.contactUs,
                        style: AppTypography.link,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// login top bar
class _LoginTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: AppSpacing.iconMd,
              color: AppColors.textPrimary,
            ),
          ),
          LanguageToggleButton(onTap: () {}),
        ],
      ),
    );
  }
}

// fingerprint icon drawn with custom paint
class _FingerprintIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(painter: _FingerprintPainter()),
    );
  }
}

class _FingerprintPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // concentric arcs to simulate fingerprint ridges
    final radii = [8.0, 14.0, 20.0, 26.0, 32.0, 38.0];

    for (final r in radii) {
      // each arc is a partial circle
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        3.4,   // start — bottom-left
        -3.8,  // sweep — over top
        false,
        paint,
      );
    }

    // center dot
    canvas.drawCircle(
      Offset(cx, cy),
      3,
      paint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// don't have an account? sign up row
class _SignUpRow extends StatelessWidget {
  final LoginController controller;
  const _SignUpRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${AppStrings.dontHaveAccount} ',
          style: AppTypography.bodyMedium,
        ),
        GestureDetector(
          onTap: controller.onSignUpTap,
          child: Text(AppStrings.signUp, style: AppTypography.link),
        ),
      ],
    );
  }
}