import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';

class ConfirmDetailSection extends StatelessWidget {
  final String label;
  final Widget child;

  const ConfirmDetailSection({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section label
        Text(label, style: AppTypography.titleMedium),

        const SizedBox(height: AppSpacing.md),

        // centered content
        Center(child: child),

        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
