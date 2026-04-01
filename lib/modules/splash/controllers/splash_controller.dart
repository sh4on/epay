import 'dart:async';

import 'package:epay/core/services/cache_service.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 2), () {
      if (CacheService.instance.read(CacheKeys.isFirstTime) != null) {
        Get.offAllNamed(AppRoutes.signupWelcome);
      } else {
        Get.offNamed(AppRoutes.onboarding);
      }
    });
  }
}
