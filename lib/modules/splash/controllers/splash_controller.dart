import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 2), () {
      debugPrint('xxx');
      Get.offNamed(AppRoutes.onboarding);
    });
  }
}