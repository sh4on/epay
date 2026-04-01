import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';

class QrScanButton extends StatelessWidget {
  final VoidCallback onTap;

  const QrScanButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // qr icon
            const Icon(
              Icons.qr_code_scanner,
              color: AppColors.primary,
              size: AppSpacing.iconMd,
            ),

            const SizedBox(width: AppSpacing.sm),

            // label
            Text(
              AppStrings.tapToScanQrCode,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
