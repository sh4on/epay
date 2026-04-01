import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const RadioIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.divider,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check, color: AppColors.white, size: 16)
          : null,
    );
  }
}
