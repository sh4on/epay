import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

// button variant types
enum AppButtonVariant { primary, outlined, disabled }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final Widget? prefixIcon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height = AppSpacing.buttonHeight,
    this.prefixIcon,
  });

  // convenience constructor — disabled state
  const AppButton.disabled({
    super.key,
    required this.label,
    this.width,
    this.height = AppSpacing.buttonHeight,
    this.prefixIcon,
  }) : variant = AppButtonVariant.disabled,
       onPressed = null;

  // convenience constructor — outlined style
  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height = AppSpacing.buttonHeight,
    this.prefixIcon,
  }) : variant = AppButtonVariant.outlined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (variant) {
      // outlined button
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            ),
          ),
          child: _buildChild(color: AppColors.primary),
        );

      // disabled button
      case AppButtonVariant.disabled:
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonDisabled,
            disabledBackgroundColor: AppColors.buttonDisabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            ),
            elevation: 0,
          ),
          child: _buildChild(color: AppColors.white),
        );

      // primary button (default)
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
            ),
            elevation: 0,
          ),
          child: _buildChild(color: AppColors.white),
        );
    }
  }

  Widget _buildChild({required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // prefix icon
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(label, style: AppTypography.labelLarge.copyWith(color: color)),
      ],
    );
  }
}
