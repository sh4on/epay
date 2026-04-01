import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';

class AddMoneyTabIcon extends StatelessWidget {
  final bool isActive;
  final String label;

  const AddMoneyTabIcon({
    super.key,
    required this.isActive,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // bank tab icon
    return SvgPicture.asset(
      label == AppStrings.bankToEkpay
          ? Assets.home.addMoney.bankToEpay
          : Assets.home.addMoney.cardToEpay,
      width: AppSpacing.iconLg,
      height: AppSpacing.iconLg,

      colorFilter: ColorFilter.mode(
        isActive ? AppColors.white : AppColors.primary,
        BlendMode.srcIn,
      ),
    );
  }
}
