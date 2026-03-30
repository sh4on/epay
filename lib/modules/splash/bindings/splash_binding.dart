import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // splash controller — lazy false so it loads immediately
    Get.lazyPut<SplashController>(() => SplashController());
  }
}