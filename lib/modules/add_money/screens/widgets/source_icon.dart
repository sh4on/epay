import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class SourceIcon extends StatelessWidget {
  final String icon;
  final bool isSelected;

  const SourceIcon({super.key, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Icon(
      _iconData(icon),
      color: isSelected ? AppColors.primary : AppColors.textSecondary,
      size: AppSpacing.iconLg,
    );
  }

  IconData _iconData(String icon) {
    switch (icon) {
      case 'bank_account':
        return Icons.account_balance_outlined;
      case 'internet_banking':
        return Icons.language_outlined;
      case 'debit_card':
      case 'credit_card':
        return Icons.credit_card_outlined;
      default:
        return Icons.payment_outlined;
    }
  }
}
