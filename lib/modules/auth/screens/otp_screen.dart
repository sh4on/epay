import 'package:epay/modules/auth/screens/widgets/contact_us_row.dart';
import 'package:epay/modules/auth/screens/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top bar — back + language
              TopBar(),

              const SizedBox(height: AppSpacing.xxl),

              // screen title
              Text(
                AppStrings.confirmPhone,
                style: AppTypography.headlineLarge,
              ),

              const SizedBox(height: AppSpacing.sm),

              // subtitle — sent to phone number
              Text(
                '${AppStrings.otpSentTo}${controller.phone}',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxxl),

              // 4 otp input boxes
              _OtpBoxRow(controller: controller),

              const SizedBox(height: AppSpacing.xxl),

              // resend row
              _ResendRow(controller: controller),

              const Spacer(),

              // verify button
              Obx(() => controller.isLoading.value
                  ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
                  : AppButton(
                label: AppStrings.verifyPhone,
                onPressed: controller.onVerifyTap,
              )),

              const SizedBox(height: AppSpacing.xxxl),

              // contact us row
              ContactUsRow(),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

// 4 otp digit input boxes
class _OtpBoxRow extends StatelessWidget {
  final OtpController controller;

  const _OtpBoxRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: _OtpBox(
            textController: controller.otpControllers[index],
            focusNode: controller.focusNodes[index],
            onChanged: (val) => controller.onOtpDigitChanged(index, val),
          ),
        );
      }),
    );
  }
}

// single otp digit box
class _OtpBox extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.textController,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTypography.headlineMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          // filled with orange tint matching design
          fillColor: AppColors.otpBoxFilled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(
              color: AppColors.accent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// resend row with countdown timer
class _ResendRow extends StatelessWidget {
  final OtpController controller;

  const _ResendRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${AppStrings.didntGetCode} ',
          style: AppTypography.bodyMedium,
        ),
        Obx(() => GestureDetector(
          onTap: controller.canResend.value
              ? controller.onResendTap
              : null,
          child: Text(
            controller.canResend.value
                ? AppStrings.resend
            // show countdown when not yet resendable
                : '${AppStrings.resend} (${controller.resendCountdown.value}s)',
            style: AppTypography.link.copyWith(
              color: controller.canResend.value
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        )),
      ],
    );
  }
}