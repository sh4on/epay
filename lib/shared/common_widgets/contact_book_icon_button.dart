import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

// blue contact book icon button used in cash out and send money search rows
class ContactBookIconButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ContactBookIconButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: const Icon(
          Icons.contact_page_outlined,
          color: AppColors.white,
          size: AppSpacing.iconMd,
        ),
      ),
    );
  }
}