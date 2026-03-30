import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class SignupController extends GetxController {
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

  // validate phone
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    return null;
  }

  // validate 4-digit pin
  String? validatePin(String? value) {
    if (value == null || value.isEmpty) return 'PIN is required';
    if (value.length != 4) return 'PIN must be 4 digits';
    return null;
  }

  // validate confirm pin matches
  String? validateConfirmPin(String? value) {
    if (value == null || value.isEmpty) return 'Please re-enter your PIN';
    if (value != pinController.text) return 'PINs do not match';
    return null;
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