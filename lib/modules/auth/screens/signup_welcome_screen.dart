import 'package:epay/shared/common_widgets/contact_us_row.dart';
import 'package:epay/modules/auth/screens/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/double_tap_to_exit.dart';

class SignupWelcomeScreen extends StatelessWidget {
  const SignupWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top bar
                TopBar(showBackButton: false),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // image
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: SvgPicture.asset(Assets.auth.mobileImage),
                      ),

                      SizedBox(height: context.height * 0.09),

                      // title text
                      Center(
                        child: Text(
                          AppStrings.signUpWelcomeTitle,
                          style: AppTypography.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxxl),

                // sign up button
                AppButton(
                  label: AppStrings.signUp,
                  onPressed: () => Get.toNamed(AppRoutes.signupForm),
                ),

                const SizedBox(height: AppSpacing.md),

                // login button
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceDark,
                      foregroundColor: AppColors.textSecondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusButton,
                        ),
                      ),
                    ),
                    child: Text(
                      AppStrings.logIn,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // contact us row
                ContactUsRow(),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
