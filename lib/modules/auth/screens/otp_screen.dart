import 'package:epay/modules/auth/screens/widgets/contact_us_row.dart';
import 'package:epay/modules/auth/screens/widgets/otp_box_row.dart';
import 'package:epay/modules/auth/screens/widgets/resend_row.dart';
import 'package:epay/modules/auth/screens/widgets/top_bar.dart';
import 'package:flutter/material.dart';
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
              OtpBoxRow(controller: controller),

              const SizedBox(height: AppSpacing.xxl),

              // resend row
              ResendRow(controller: controller),

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