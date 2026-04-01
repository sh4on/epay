import 'package:epay/modules/home/screens/widgets/point_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      padding: const EdgeInsets.only(
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
                Stack(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Obx(() {
                          final avatarUrl =
                              baseController.user.value?.avatarUrl;

                          return CachedNetworkImage(
                            imageUrl:
                                avatarUrl ??
                                'https://cdn.vectorstock.com/i/1000v/51/05/male-profile-avatar-with-brown-hair-vector-12055105.jpg',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person),
                          );
                        }),
                      ),
                    ),

                    // 2. Orange Status Dot
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          // Or use AppColors.orange if defined
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 1.5,
                          ), // Cutout effect
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),

                // user name
                Obx(
                  () => Text(
                    baseController.user.value?.name ?? '',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
