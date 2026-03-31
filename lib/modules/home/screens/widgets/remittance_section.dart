import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../gen/assets.gen.dart';
import '../../controllers/home_controller.dart';

class RemittanceSection extends StatelessWidget {
  final HomeController controller;

  const RemittanceSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          Text(AppStrings.remittance, style: AppTypography.headlineSmall),

          const SizedBox(height: AppSpacing.lg),

          // horizontal scrollable remittance partner logos
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.remittanceItems.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, index) {
                final item = controller.remittanceItems[index];
                return _RemittanceCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// single remittance partner card
class _RemittanceCard extends StatelessWidget {
  final RemittanceItem item;

  const _RemittanceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // partner icon placeholder
          _remittanceIcon(item.logo),

          const SizedBox(height: AppSpacing.xs),

          // partner name
          Text(
            item.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _remittanceIcon(String logo) {
    switch (logo) {
      case 'paypal':
        return SvgPicture.asset(Assets.home.remittance.payoneer);
      case 'payoneer':
        return SvgPicture.asset(Assets.home.remittance.paypal);
      case 'wise':
        return SvgPicture.asset(Assets.home.remittance.paypal);
      case 'wind':
        return SvgPicture.asset(Assets.home.remittance.paypal);
      default:
        return SvgPicture.asset(Assets.home.remittance.payoneer);
    }
  }
}