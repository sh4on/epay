import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class DotIndicator extends StatelessWidget {
  final int total;
  final int current;

  const DotIndicator({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final bool isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          width: isActive ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            // active dot is primary, inactive is grey
            color: isActive ? AppColors.primary : AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        );
      }),
    );
  }
}