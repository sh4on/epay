import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import 'app_button.dart';

// full-screen error state with retry
class ErrorStateWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const ErrorStateWidget({super.key, required this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // error icon
            const Icon(
              Icons.wifi_off_rounded,
              size: 72,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.lg),

            // error message
            Text(
              message ?? 'Something went wrong!\nPlease try again.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // retry button
            AppButton(label: 'Retry', onPressed: onRetry, width: 160),
          ],
        ),
      ),
    );
  }
}
