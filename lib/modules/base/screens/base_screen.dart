import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/base_controller.dart';
import '../../home/screens/home_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/language_toggle_button.dart';

class BaseScreen extends GetView<BaseController> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer — side menu
      drawer: _AppDrawer(controller: controller),
      body: Obx(() {
        // switch between bottom nav tabs
        switch (controller.activeIndex.value) {
          case 1:
          // qr scan placeholder
            return const _QrScanPlaceholder();
          case 2:
          // inbox placeholder
            return const _InboxPlaceholder();
          default:
          // home screen
            return const HomeScreen();
        }
      }),

      // bottom navigation bar
      bottomNavigationBar: _AppBottomNavBar(controller: controller),
    );
  }
}

// ─── drawer ──────────────────────────────────────────────────────────────────

class _AppDrawer extends StatelessWidget {
  final BaseController controller;

  const _AppDrawer({required this.controller});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // drawer title
              Text(
                AppStrings.epayMenu,
                style: AppTypography.headlineMedium,
              ),
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
              style: labelStyle ??
                  AppTypography.bodyLarge.copyWith(
                    color: AppColors.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── bottom navigation bar ───────────────────────────────────────────────────

class _AppBottomNavBar extends StatelessWidget {
  final BaseController controller;

  const _AppBottomNavBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              // home tab
              _BottomNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: AppStrings.home,
                isActive: controller.activeIndex.value == 0,
                onTap: () => controller.onTabChanged(0),
              ),

              // qr scan — center elevated button
              _QrScanNavItem(
                isActive: controller.activeIndex.value == 1,
                onTap: () => controller.onTabChanged(1),
              ),

              // inbox tab
              _BottomNavItem(
                icon: Icons.mail_outline,
                activeIcon: Icons.mail,
                label: AppStrings.inbox,
                isActive: controller.activeIndex.value == 2,
                onTap: () => controller.onTabChanged(2),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

// standard bottom nav tab item
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              size: AppSpacing.iconMd + 2,
            ),
            const SizedBox(height: 2),

            // label
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// qr scan center elevated circular button
class _QrScanNavItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _QrScanNavItem({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // elevated circular qr button
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
                border: Border.all(
                  color: AppColors.divider,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                size: AppSpacing.iconLg,
              ),
            ),
            const SizedBox(height: 2),

            // qr scan label
            Text(
              AppStrings.qrScan,
              style: AppTypography.labelSmall.copyWith(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── placeholder screens ─────────────────────────────────────────────────────

// qr scan placeholder
class _QrScanPlaceholder extends StatelessWidget {
  const _QrScanPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner,
                size: 72, color: AppColors.textSecondary),
            SizedBox(height: AppSpacing.lg),
            Text('QR Scanner coming soon.',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

// inbox placeholder
class _InboxPlaceholder extends StatelessWidget {
  const _InboxPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline, size: 72, color: AppColors.textSecondary),
            SizedBox(height: AppSpacing.lg),
            Text('Inbox coming soon.',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}