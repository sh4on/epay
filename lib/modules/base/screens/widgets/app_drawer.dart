import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/common_widgets/language_toggle_button.dart';
import '../../controllers/base_controller.dart';

class AppDrawer extends StatelessWidget {
  final BaseController controller;

  const AppDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // drawer header — title + language + points
            _DrawerHeader(controller: controller),

            const Divider(height: 1),

            // drawer menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    label: AppStrings.home,
                    onTap: () {
                      Get.back();
                      controller.onTabChanged(0);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.person_outline,
                    label: AppStrings.profile,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.attach_file_outlined,
                    label: AppStrings.statements,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.info_outline,
                    label: AppStrings.limits,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.monetization_on_outlined,
                    label: AppStrings.coupons,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.emoji_events_outlined,
                    label: AppStrings.points,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.edit_outlined,
                    label: AppStrings.informationUpdate,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.settings_outlined,
                    label: AppStrings.settings,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.swap_horiz_outlined,
                    label: AppStrings.nomineeUpdate,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.headset_mic_outlined,
                    label: AppStrings.support,
                    onTap: () => Get.back(),
                  ),
                  _DrawerItem(
                    icon: Icons.person_add_outlined,
                    label: AppStrings.referEkpayApp,
                    onTap: () => Get.back(),
                  ),

                  const Divider(height: 1),

                  // logout — bold + different color
                  _DrawerItem(
                    icon: Icons.logout_outlined,
                    label: AppStrings.logout,
                    labelStyle: AppTypography.titleLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    iconColor: AppColors.primary,
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(AppRoutes.signupWelcome);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// drawer top_section header section
class _DrawerHeader extends StatelessWidget {
  final BaseController controller;

  const _DrawerHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // drawer title
              Text(AppStrings.epayMenu, style: AppTypography.headlineMedium),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // language toggle pill
          LanguageToggleButton(onTap: () {}),
        ],
      ),
    );
  }
}

// single drawer menu item row
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final TextStyle? labelStyle;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.labelStyle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md + 2,
        ),
        child: Row(
          children: [
            // menu icon
            Icon(
              icon,
              size: AppSpacing.iconMd,
              color: iconColor ?? AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.lg),

            // menu label
            Text(
              label,
              style:
                  labelStyle ??
                  AppTypography.bodyLarge.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
