import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../controllers/cash_out_controller.dart';

class TabButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 120,
        width: 100,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tab icon
            SvgPicture.asset(
              iconPath,
              width: AppSpacing.iconLg,
              height: AppSpacing.iconLg,

              colorFilter: ColorFilter.mode(
                isActive ? AppColors.white : AppColors.primary,
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(height: AppSpacing.xs),

            // tab label
            Text(
              label,
              style: AppTypography.titleMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
