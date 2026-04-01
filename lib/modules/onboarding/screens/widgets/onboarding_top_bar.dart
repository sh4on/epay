import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../shared/common_widgets/language_toggle_button.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingTopBar extends StatelessWidget {
  final OnboardingController controller;

  const OnboardingTopBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: controller.currentPage == 0
              ? MainAxisAlignment.center
              : MainAxisAlignment.end,
          children: [
            // language toggle pill
            LanguageToggleButton(onTap: () {}),
          ],
        );
      }),
    );
  }
}
