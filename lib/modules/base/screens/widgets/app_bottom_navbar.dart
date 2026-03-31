import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/base_controller.dart';

class AppBottomNavBar extends StatelessWidget {
  final BaseController controller;

  const AppBottomNavBar({super.key, required this.controller});

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
    super.key,
    required this.items,
    this.onTap,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.currentIndex = 0,
  })  : assert(
  items.length == 3,
  'This widget requires exactly 3 items',
  );

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
            color: AppColors.shadow.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipPath(
        clipper: _CurvedClipper(),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.1),
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

                // QR scan button 
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
    final curveHeight = 30.0;

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
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.8),
                  ],
                )
                    : null,
                color: isActive ? null : AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow.withValues(alpha: 0.2),
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
                size: 26,
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

class QrScanPlaceholder extends StatelessWidget {
  const QrScanPlaceholder({super.key});

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

class InboxPlaceholder extends StatelessWidget {
  const InboxPlaceholder({super.key});

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