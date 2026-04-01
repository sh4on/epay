import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  final AuthRepository _repository;
  OtpController(this._repository);

  // phone passed from signup
  String phone = '';

  // 4 individual otp digit controllers
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  // 4 focus nodes for auto-jump between boxes
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  // loading state
  final RxBool isLoading = false.obs;

  // resend countdown in seconds
  final RxInt resendCountdown = 30.obs;
  final RxBool canResend = false.obs;
  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();

    // get phone from arguments
    if (Get.arguments != null && Get.arguments is Map) {
      phone = Get.arguments['phone'] ?? '';
    }

    // start resend countdown
    _startCountdown();
  }

  @override
  void onClose() {
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    _countdownTimer?.cancel();
    super.onClose();
  }

  // countdown timer for resend
  void _startCountdown() {
    resendCountdown.value = 30;
    canResend.value = false;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // called on each otp box input
  void onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      // move focus to next box
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // move focus back on delete
      focusNodes[index - 1].requestFocus();
    }
  }

  // get full otp string
  String get _fullOtp => otpControllers.map((c) => c.text).join();

  // verify button tap
  Future<void> onVerifyTap() async {
    if (_fullOtp.length < 4) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the 4-digit code.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isLoading.value = true;

    final result = await _repository.verifyOtp(phone: phone, otp: _fullOtp);

    isLoading.value = false;

    if (result.isSuccess) {
      final user = UserModel.fromJson(result.data);
      Get.offAllNamed(AppRoutes.base, arguments: user);
    } else {
      Get.snackbar(
        'Verification Failed',
        result.message ?? 'Invalid OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  // resend otp tap
  Future<void> onResendTap() async {
    if (!canResend.value) return;

    // clear all boxes
    for (final c in otpControllers) {
      c.clear();
    }
    focusNodes[0].requestFocus();

    // restart countdown
    _startCountdown();

    Get.snackbar(
      'OTP Resent',
      'A new code has been sent to $phone',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
