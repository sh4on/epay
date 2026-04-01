import 'package:epay/core/utils/mixins/validation_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController with ValidationMixin {
  final AuthRepository _repository;
  SignupController(this._repository);

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  // loading state
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    pinController.dispose();
    confirmPinController.dispose();
    super.onClose();
  }

  // sign up button tap
  Future<void> onSignUpTap() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final result = await _repository.signup(
      phone: phoneController.text.trim(),
      pin: pinController.text.trim(),
    );

    isLoading.value = false;

    if (result.isSuccess) {
      // navigate to otp with phone number
      Get.toNamed(
        AppRoutes.otp,
        arguments: {'phone': phoneController.text.trim()},
      );
    } else {
      Get.snackbar(
        'Sign Up Failed',
        result.message ?? 'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }
}
