import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/language_toggle_button.dart';

class SignupWelcomeScreen extends StatelessWidget {
  const SignupWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top bar — back + language
              _WelcomeTopBar(),

              // illustration area
              Expanded(
                child: Center(child: _WelcomeIllustration()),
              ),

              // title text
              Text(
                AppStrings.signUpWelcomeTitle,
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // sign up button
              AppButton(
                label: AppStrings.signUp,
                onPressed: () => Get.toNamed(AppRoutes.signupForm),
              ),

              const SizedBox(height: AppSpacing.md),

              // login button — secondary style (disabled-looking grey)
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
                      borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
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

              const SizedBox(height: AppSpacing.xl),

              // contact us row
              _ContactUsRow(),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

// top bar with back arrow and language toggle
class _WelcomeTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: AppSpacing.iconMd,
              color: AppColors.textPrimary,
            ),
          ),

          // language toggle
          LanguageToggleButton(onTap: () {}),
        ],
      ),
    );
  }
}

// welcome illustration — phone with person + floating colored dots
class _WelcomeIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // grey circular background
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEF5),
              shape: BoxShape.circle,
            ),
          ),

          // phone with agent icon — placeholder image
          Container(
            width: 90,
            height: 155,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // person icon on phone
                Icon(Icons.person_outline, color: AppColors.white, size: 40),
                SizedBox(height: 8),
                // briefcase icon
                Icon(Icons.work_outline, color: AppColors.white, size: 28),
              ],
            ),
          ),

          // floating dot — blue top
          Positioned(
            top: 28,
            left: 72,
            child: _FloatingDot(color: AppColors.primary, size: 16),
          ),

          // floating dot — pink right
          Positioned(
            top: 60,
            right: 20,
            child: _FloatingDot(color: const Color(0xFFE91E8C), size: 36),
          ),

          // floating dot — teal left
          Positioned(
            left: 18,
            bottom: 90,
            child: _FloatingDot(color: const Color(0xFF00BCD4), size: 14),
          ),

          // floating dot — orange bottom-left
          Positioned(
            bottom: 55,
            left: 50,
            child: _FloatingDot(color: AppColors.accent, size: 30),
          ),

          // floating dot — blue small bottom-right
          Positioned(
            bottom: 72,
            right: 52,
            child: _FloatingDot(color: const Color(0xFF2196F3), size: 14),
          ),
        ],
      ),
    );
  }
}

// small colored floating circle
class _FloatingDot extends StatelessWidget {
  final Color color;
  final double size;

  const _FloatingDot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// did you face any issue? contact us row
class _ContactUsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${AppStrings.didYouFaceIssue} ',
          style: AppTypography.bodyMedium,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppStrings.contactUs,
            style: AppTypography.link,
          ),
        ),
      ],
    );
  }
}