import 'package:epay/modules/auth/screens/widgets/top_bar.dart';
import 'package:epay/modules/auth/screens/widgets/sign_up_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../controllers/login_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/app_button.dart';
import '../../../shared/common_widgets/app_text_field.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopBar(),
                        const SizedBox(height: AppSpacing.xxl),
                        const Text(
                          AppStrings.loginTitle,
                          style: AppTypography.headlineLarge,
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // Phone Field
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

                        // password Field
                        AppTextField(
                          label: AppStrings.enterSixDigitPin,
                          hint: '123456',
                          controller: controller.pinController,
                          isRequired: true,
                          isPassword: true,
                          keyboardType: TextInputType.text,
                          validator: controller.validatePassword,
                          textInputAction: TextInputAction.done,
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: controller.onForgotPinTap,
                            child: const Text(
                              AppStrings.forgotPin,
                              style: AppTypography.link,
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xxl),

                        // Login Button
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : AppButton(
                                  label: AppStrings.logIn,
                                  onPressed: controller.onLoginTap,
                                ),
                        ),

                        const SizedBox(height: AppSpacing.xxxxl),

                        // Biometric
                        Center(
                          child: GestureDetector(
                            onTap: controller.onBiometricTap,
                            child: SvgPicture.asset(Assets.auth.fingerprint),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xxl),

                        SignUpRow(controller: controller),

                        const Spacer(),

                        const SizedBox(height: AppSpacing.xxxl),

                        // Contact Us Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '${AppStrings.didYouFaceIssue} ',
                              style: AppTypography.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                AppStrings.contactUs,
                                style: AppTypography.link,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
