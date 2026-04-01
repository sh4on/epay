import 'package:epay/modules/home/screens/widgets/see_more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../data/models/bill_item.dart';
import '../../../../gen/assets.gen.dart';
import '../../controllers/home_controller.dart';

class PayBillSection extends StatelessWidget {
  final HomeController controller;

  const PayBillSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          const Text(AppStrings.payBill, style: AppTypography.headlineSmall),

          // bill items — 2 rows of 4
          GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 0.85,
            children: controller.billServices
                .take(8)
                .map(
                  (item) => _BillGridItem(
                    item: item,
                    onTap: () => controller.onBillTap(item),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // see more button
          SeeMoreButton(label: AppStrings.seeMore, onTap: () {}),
        ],
      ),
    );
  }
}

// bill grid item
class _BillGridItem extends StatelessWidget {
  final BillItem item;
  final VoidCallback onTap;

  const _BillGridItem({required this.item, required this.onTap});

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
            child: _billIcon(item.icon),
          ),

          const SizedBox(height: AppSpacing.xs + 2),

          // bill label
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

  Widget _billIcon(String icon) {
    switch (icon) {
      case 'electricity':
        return SvgPicture.asset(Assets.home.payBill.electricity);
      case 'gas':
        return SvgPicture.asset(Assets.home.payBill.gas);
      case 'water':
        return SvgPicture.asset(Assets.home.payBill.water);
      case 'internet':
        return SvgPicture.asset(Assets.home.payBill.internet);
      case 'telephone':
        return SvgPicture.asset(Assets.home.payBill.telephone);
      case 'credit_card':
        return SvgPicture.asset(Assets.home.payBill.creditCard);
      case 'govt':
        return SvgPicture.asset(Assets.home.payBill.govtFees);
      case 'cable':
        return SvgPicture.asset(Assets.home.payBill.cableNetwork);
      default:
        return SvgPicture.asset(Assets.home.topSection.cachIn);
    }
  }
}
