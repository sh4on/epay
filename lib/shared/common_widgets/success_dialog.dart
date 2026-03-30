import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import 'app_button.dart';

// reusable success dialog — used for cash out and send money success
class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String highlightedAmount;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  final Widget illustration;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.highlightedAmount,
    required this.buttonLabel,
    required this.onButtonPressed,
    required this.illustration,
  });

  // show the dialog
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String highlightedAmount,
    required String buttonLabel,
    required VoidCallback onButtonPressed,
    required Widget illustration,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessDialog(
        title: title,
        message: message,
        highlightedAmount: highlightedAmount,
        buttonLabel: buttonLabel,
        onButtonPressed: onButtonPressed,
        illustration: illustration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // success illustration
            illustration,
            const SizedBox(height: AppSpacing.lg),

            // title
            Text(
              title,
              style: AppTypography.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),

            // message with highlighted amount
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTypography.bodyMedium,
                children: [
                  TextSpan(text: message),
                  TextSpan(
                    text: highlightedAmount,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // back to home button
            AppButton(
              label: buttonLabel,
              onPressed: onButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}