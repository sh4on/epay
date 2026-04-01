import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/send_money_controller.dart';

class ConfirmButton extends StatelessWidget {
  final SendMoneyController controller;

  const ConfirmButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Obx(() {
        final hasAmount = controller.enteredAmount.value > 0;
        final isProcessing = controller.isProcessing.value;

        // show spinner while processing
        if (isProcessing) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton(
            onPressed: hasAmount
                ? () => controller.onConfirmTap(context)
                : null,
            style: ElevatedButton.styleFrom(
              // active navy when amount entered, grey when empty
              backgroundColor: hasAmount
                  ? AppColors.primary
                  : AppColors.buttonDisabled,
              disabledBackgroundColor: AppColors.buttonDisabled,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
              ),
              elevation: 0,
            ),
            child: const Text(AppStrings.confirm, style: AppTypography.labelLarge),
          ),
        );
      }),
    );
  }
}
