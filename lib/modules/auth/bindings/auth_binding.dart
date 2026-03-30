import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/otp_controller.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/providers/auth_provider.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // auth provider and repository
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));

    // auth controllers
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
    Get.lazyPut<SignupController>(() => SignupController(Get.find()));
    Get.lazyPut<OtpController>(() => OtpController(Get.find()));
  }
}