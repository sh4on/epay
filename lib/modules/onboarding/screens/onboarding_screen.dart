import 'package:epay/core/utils/extensions/context_extensions.dart';
import 'package:epay/modules/onboarding/screens/widgets/dot_indicator.dart';
import 'package:epay/modules/onboarding/screens/widgets/onboarding_page.dart';
import 'package:epay/modules/onboarding/screens/widgets/onboarding_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../controllers/onboarding_controller.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // top bar with language toggle
            OnboardingTopBar(controller: controller),

            // page view
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [
                  // page 1 — trusted by millions
                  OnboardingPage(
                    imageWidget: SvgPicture.asset(
                      Assets.onboarding.firstOnboardingImage,
                      height: context.screenHeight * 0.3,
                      width: context.screenWidth * 0.75,
                    ),
                    title: AppStrings.onboarding1Title,
                  ),

                  // page 2 — pay bills
                  OnboardingPage(
                    imageWidget: SvgPicture.asset(
                      Assets.onboarding.secondOnboardingImage,
                    ),
                    title: AppStrings.onboarding2Title,
                  ),

                  // page 3 — secure transactions
                  OnboardingPage(
                    imageWidget: SvgPicture.asset(
                      Assets.onboarding.thirdOnboardingImage,
                    ),
                    title: AppStrings.onboarding3Title,
                  ),
                ],
              ),
            ),

            // dot indicators
            Obx(
              () => DotIndicator(
                total: OnboardingController.totalPages,
                current: controller.currentPage.value,
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // next button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: AppButton(
                label: AppStrings.next,
                onPressed: controller.onNextTap,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // skip text link
            InkWell(
              onTap: controller.onSkipTap,
              child: const Text(AppStrings.skip, style: AppTypography.link),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
