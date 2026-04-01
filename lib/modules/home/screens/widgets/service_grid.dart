import 'package:epay/modules/home/screens/widgets/see_more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../data/models/service_item.dart';
import '../../../../gen/assets.gen.dart';
import '../../controllers/home_controller.dart';

class ServicesGrid extends StatelessWidget {
  final HomeController controller;

  const ServicesGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // show first 4 or all 8 based on toggle
      final displayItems = controller.showAllServices.value
          ? controller.services
          : controller.services.take(8).toList();

      return Column(
        children: [
          // 4-column grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            childAspectRatio: 0.85,
            children: displayItems
                .map(
                  (item) => _ServiceGridItem(
                    item: item,
                    onTap: () => controller.onServiceTap(item),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // see more button
          SeeMoreButton(
            label: controller.showAllServices.value
                ? 'See Less'
                : AppStrings.seeMore,
            onTap: controller.toggleSeeMoreServices,
          ),
        ],
      );
    });
  }
}

// individual service icon + label in grid
class _ServiceGridItem extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback onTap;

  const _ServiceGridItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: _serviceIcon(item.icon),
          ),

          const SizedBox(height: AppSpacing.xs + 2),

          // service label
          Text(
            item.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // map icon string to flutter icon
  Widget _serviceIcon(String icon) {
    switch (icon) {
      case 'cash_in':
        return SvgPicture.asset(Assets.home.topSection.cachIn);
      case 'cash_out':
        return SvgPicture.asset(Assets.home.topSection.cachOut);
      case 'add_money':
        return SvgPicture.asset(Assets.home.topSection.addMone);
      case 'send_money':
        return SvgPicture.asset(Assets.home.topSection.sendMoney);
      case 'mobile':
        return SvgPicture.asset(Assets.home.topSection.mobileRecharge);
      case 'mrt':
        return SvgPicture.asset(Assets.home.topSection.mrtRecharge);
      case 'payment':
        return SvgPicture.asset(Assets.home.topSection.makePayment);
      case 'card':
        return SvgPicture.asset(Assets.home.topSection.expressCardRecharge);
      default:
        return SvgPicture.asset(Assets.home.topSection.cachIn);
    }
  }
}
