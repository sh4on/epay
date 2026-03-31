import 'package:epay/modules/home/screens/widgets/point_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../base/controllers/base_controller.dart';

class HomeAppBar extends StatelessWidget {
  final BaseController baseController;

  const HomeAppBar({super.key, required this.baseController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF345DD8),
            Color(0xFF355BD1),
            Color(0xFF4867CA),
            Color(0xFF2A3F8F),
            Color(0xFF1A2E6C),
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
      padding: EdgeInsets.only(
        top: 60,
        left: AppSpacing.screenPadding,
        right: AppSpacing.screenPadding,
        bottom: 30,
      ),
      child: Row(
        children: [
          // drawer menu icon + avatar + name
          GestureDetector(
            onTap: () {
              baseController.openDrawer();
            },
            child: Row(
              children: [
                // avatar circle
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: AppSpacing.iconMd,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // user name
                Obx(() => Text(
                  baseController.user.value?.name ?? '',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),

          const Spacer(),

          // points badge
          Obx(() => PointsBadge(points: baseController.formattedPoints)),
        ],
      ),
    );
  }
}