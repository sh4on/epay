import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class OnboardingPage extends StatelessWidget {
  final Widget imageWidget;
  final String title;

  const OnboardingPage({super.key, required this.imageWidget, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        spacing: context.screenHeight * 0.1,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image
          SizedBox(height: 260, child: imageWidget),

          // onboarding title text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              title,
              style: AppTypography.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}