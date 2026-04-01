import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../data/models/contact_model.dart';

// single contact row used in send money and cash out screens
class ContactListItem extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback? onTap;

  const ContactListItem({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            // avatar placeholder
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.textSecondary,
                size: AppSpacing.iconLg,
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // contact name and number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // contact name
                  Text(contact.name, style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  // contact number with bank prefix
                  Text(
                    'Bank - ${contact.phone}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
