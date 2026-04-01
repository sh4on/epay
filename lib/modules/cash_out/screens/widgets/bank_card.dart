import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../data/models/bank_model.dart';

class BankCard extends StatelessWidget {
  final BankModel bank;
  final VoidCallback onTap;

  const BankCard({super.key, required this.bank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            // bank info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // bank name
                  Text(bank.name, style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.xs),

                  // branch name
                  Text(
                    'Branch Name: ${bank.branchName}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),

            // bank illustration placeholder
            Container(
              width: 72,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: const Icon(
                Icons.account_balance,
                color: AppColors.primary,
                size: AppSpacing.iconLg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
