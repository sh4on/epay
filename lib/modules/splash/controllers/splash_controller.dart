import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  // wait then go to onboarding
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Get.offAllNamed(AppRoutes.onboarding);
  }
}