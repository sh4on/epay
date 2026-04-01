import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_typography.dart';

// language toggle pill shown in top_section-right of auth screens
class LanguageToggleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LanguageToggleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.languageBadgeBg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        // language label
        child: Text(
          AppStrings.bangla,
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.languageBadgeText,
          ),
        ),
      ),
    );
  }
}
