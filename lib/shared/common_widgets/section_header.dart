import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

// section label used in home and contact lists
class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsets? padding;

  const SectionHeader({super.key, required this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Text(title, style: AppTypography.headlineSmall),
    );
  }
}
