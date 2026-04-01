import 'package:epay/modules/add_money/screens/widgets/radio_indicator.dart';
import 'package:epay/modules/add_money/screens/widgets/source_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/add_money_controller.dart';

class SourceOptionCard extends StatelessWidget {
  final MoneySourceItem source;
  final bool isSelected;
  final VoidCallback onTap;

  const SourceOptionCard({
    super.key,
    required this.source,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xxl,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // source icon
            SourceIcon(icon: source.icon, isSelected: isSelected),

            const SizedBox(width: AppSpacing.lg),

            // source label
            Expanded(
              child: Text(
                source.label,
                style: AppTypography.titleMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),

            // radio circle indicator
            RadioIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
