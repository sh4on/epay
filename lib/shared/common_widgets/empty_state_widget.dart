import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

// full-screen empty state
class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({super.key, this.message = 'No data found!'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // empty icon
          const Icon(Icons.inbox_outlined, size: 72, color: AppColors.textHint),
          const SizedBox(height: AppSpacing.lg),

          // empty message
          Text(
            message,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
