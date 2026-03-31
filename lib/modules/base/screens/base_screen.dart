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
      drawer: _AppDrawer(controller: controller),
      extendBody: true, // Critical: Allows body to extend under the bottom nav
      body: Obx(() {
        switch (controller.activeIndex.value) {
          case 1:
            return const _QrScanPlaceholder();
          case 2:
            return const _InboxPlaceholder();
          default:
            return const HomeScreen();
        }
      }),
      bottomNavigationBar: SafeArea(child: _AppBottomNavBar(controller: controller)),
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
    return Obx(() => CurvedNavigationBar(
      currentIndex: controller.activeIndex.value,
      items: const [
        CurvedNavigationBarItem(
          iconData: Icons.home_outlined,
          selectedIconData: Icons.home,
        ),
        CurvedNavigationBarItem(
          iconData: Icons.qr_code_scanner,
          selectedIconData: Icons.qr_code_scanner,
        ),
        CurvedNavigationBarItem(
          iconData: Icons.mail_outline,
          selectedIconData: Icons.mail,
        ),
      ],
      onTap: (index) => controller.onTabChanged(index),
      selectedColor: AppColors.primary,
      unselectedColor: AppColors.textSecondary,
    ));
  }
}

class CurvedNavigationBarItem {
  const CurvedNavigationBarItem({
    required this.iconData,
    this.selectedIconData,
  });

  final IconData iconData;
  final IconData? selectedIconData;
}

class CurvedNavigationBar extends StatelessWidget {
  const CurvedNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.currentIndex = 0,
  })  : assert(
  items.length == 3,
  'This widget requires exactly 3 items',
  ),
        super(key: key);

  final List<CurvedNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipPath(
        clipper: _CurvedClipper(),
        child: Container(
          height: 105, // Reduced back to 80
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == currentIndex;

                // QR scan button - now properly positioned within the curve
                if (index == 1) {
                  return _QrScanNavItem(
                    isActive: isActive,
                    onTap: () => onTap?.call(index),
                  );
                }

                return _BottomNavItem(
                  icon: item.iconData,
                  activeIcon: item.selectedIconData ?? item.iconData,
                  label: _getLabelForIndex(index),
                  isActive: isActive,
                  onTap: () => onTap?.call(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return AppStrings.home;
      case 1:
        return AppStrings.qrScan;
      case 2:
        return AppStrings.inbox;
      default:
        return '';
    }
  }
}

class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = 30.0; // Moderate curve height

    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.5,
        curveHeight,
        size.width,
        0
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// QR scan center button - positioned within the curve, not floating
// QR scan center button - positioned within the curve, not floating
class _QrScanNavItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _QrScanNavItem({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48, // Reduced from 52 to 48
              height: 48, // Reduced from 52 to 48
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                )
                    : null,
                color: isActive ? null : AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isActive ? Colors.transparent : AppColors.divider,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                color: isActive ? AppColors.white : AppColors.primary,
                size: 26, // Reduced from 32 to 26
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.qrScan,
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

// Standard bottom nav tab item
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
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              size: AppSpacing.iconMd + 2,
            ),
            const SizedBox(height: 4),
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