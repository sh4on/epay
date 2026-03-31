import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/common_widgets/language_toggle_button.dart';

class TopBar extends StatelessWidget {
  final bool showBackButton;

  const TopBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        mainAxisAlignment: showBackButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
        children: [
          if (showBackButton) GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_outlined,
              size: AppSpacing.iconMd,
              color: AppColors.textPrimary,
            ),
          ),
          LanguageToggleButton(onTap: () {}),
        ],
      ),
    );
  }
}