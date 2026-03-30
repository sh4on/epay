import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/app_text_field.dart';
import '../../../shared/common_widgets/language_toggle_button.dart';

class SignupFormScreen extends GetView<SignupController> {
  const SignupFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top bar
                _AuthTopBar(),

                const SizedBox(height: AppSpacing.xxl),

                // screen title
                Text(
                  AppStrings.createAccount,
                  style: AppTypography.headlineLarge,
                ),

                const SizedBox(height: AppSpacing.xxl),

                // phone number field
                AppTextField(
                  label: AppStrings.phoneNumber,
                  hint: '+8801701*****4',
                  controller: controller.phoneController,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validatePhone,
                ),

                const SizedBox(height: AppSpacing.lg),

                // 4-digit pin field
                AppTextField(
                  label: AppStrings.enterFourDigitPin,
                  hint: '123456',
                  controller: controller.pinController,
                  isRequired: true,
                  isPassword: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validatePin,
                ),

                const SizedBox(height: AppSpacing.lg),

                // confirm pin field
                AppTextField(
                  label: AppStrings.reEnterPin,
                  hint: '123456',
                  controller: controller.confirmPinController,
                  isRequired: true,
                  isPassword: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: controller.validateConfirmPin,
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // sign up button
                Obx(() => controller.isLoading.value
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
                    : AppButton(
                  label: AppStrings.signUp,
                  onPressed: controller.onSignUpTap,
                )),

                const SizedBox(height: AppSpacing.xxxl),

                // contact us row
                _ContactUsRow(),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// shared auth top bar — back + language toggle
class _AuthTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back arrow
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

// contact us footer row
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
          child: Text(AppStrings.contactUs, style: AppTypography.link),
        ),
      ],
    );
  }
}