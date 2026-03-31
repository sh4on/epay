import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/extensions/string_extensions.dart';
import '../../../core/utils/mixins/validation_mixin.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController with ValidationMixin {
  final AuthRepository _repository;

  LoginController(this._repository);

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController phoneController = TextEditingController(
    text: kDebugMode ? '01711111111' : null,
  );
  final TextEditingController pinController = TextEditingController(
    text: kDebugMode ? '123456' : null,
  );

  // loading state
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    pinController.dispose();
    super.onClose();
  }

  // login button tap
  Future<void> onLoginTap() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final result = await _repository.login(
      phone: phoneController.text.trim(),
      pin: pinController.text.trim(),
    );

    isLoading.value = false;

    if (result.isSuccess) {
      // parse user and navigate to base
      final user = UserModel.fromJson(result.data);
      Get.offAllNamed(AppRoutes.base, arguments: user);
    } else {
      Get.snackbar(
        'Login Failed',
        result.message ?? 'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  // forgot pin tap
  void onForgotPinTap() {
    // placeholder — wire to forgot pin flow later
    Get.snackbar(
      'Forgot PIN',
      'Forgot PIN flow coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // biometric tap
  void onBiometricTap() {
    // placeholder — wire biometric auth later
    Get.snackbar(
      'Biometric',
      'Biometric authentication coming soon.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  // go to sign up
  void onSignUpTap() {
    Get.toNamed(AppRoutes.signupForm);
  }
}
