import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/otp_controller.dart';

class ResendRow extends StatelessWidget {
  final OtpController controller;

  const ResendRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('${AppStrings.didntGetCode} ', style: AppTypography.bodyMedium),
        Obx(
          () => GestureDetector(
            onTap: controller.canResend.value ? controller.onResendTap : null,
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
          ),
        ),
      ],
    );
  }
}
