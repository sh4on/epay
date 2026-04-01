import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../base/controllers/base_controller.dart';

class BalanceCard extends StatelessWidget {
  final BaseController baseController;

  const BalanceCard({super.key, required this.baseController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
        ),
        child: Column(
          children: [
            // your balance label
            Text(
              AppStrings.yourBalance,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // balance amount + visibility toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    baseController.isBalanceVisible.value
                        ? baseController.formattedBalance
                        : 'Tk: ••••••',
                    style: AppTypography.balanceAmount,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // show/hide balance icon
                GestureDetector(
                  onTap: baseController.toggleBalanceVisibility,
                  child: Obx(
                    () => Icon(
                      baseController.isBalanceVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
