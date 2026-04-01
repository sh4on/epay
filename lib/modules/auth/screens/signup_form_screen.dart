import 'package:epay/shared/common_widgets/contact_us_row.dart';
import 'package:epay/modules/auth/screens/widgets/top_bar.dart';
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

class SignupFormScreen extends GetView<SignupController> {
  const SignupFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Form(
            key: controller.formKey,
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top bar
                      const TopBar(),

                      const SizedBox(height: AppSpacing.xxl),

                      // screen title
                      const Text(
                        AppStrings.createAccount,
                        style: AppTypography.headlineLarge,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // phone number field
                      AppTextField(
                        label: AppStrings.phoneNumber,
                        hint: '8801701*****4',
                        controller: controller.phoneController,
                        isRequired: true,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: controller.validatePhone,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // pin field
                      AppTextField(
                        label: AppStrings.enterFourDigitPin,
                        hint: '123456',
                        controller: controller.pinController,
                        isRequired: true,
                        isPassword: true,
                        keyboardType: TextInputType.text,
                        validator: controller.validatePassword,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // confirm pin field
                      AppTextField(
                        label: AppStrings.reEnterPin,
                        hint: '123456',
                        controller: controller.confirmPinController,
                        isRequired: true,
                        isPassword: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return controller.validateConfirmPassword(
                            value,
                            controller.pinController.text,
                          );
                        },
                        textInputAction: TextInputAction.done,
                      ),

                      const SizedBox(height: AppSpacing.xxxl),

                      // sign up button
                      Obx(
                        () => controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : AppButton(
                                label: AppStrings.signUp,
                                onPressed: controller.onSignUpTap,
                              ),
                      ),

                      const Spacer(),

                      const SizedBox(height: AppSpacing.xxxl),

                      // contact us row
                      const ContactUsRow(),

                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
