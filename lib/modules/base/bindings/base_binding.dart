import 'package:get/get.dart';
import '../controllers/base_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../data/providers/home_provider.dart';
import '../../../data/repositories/home_repository.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    // base controller — manages drawer + bottom nav state
    Get.lazyPut<BaseController>(() => BaseController());

    // home dependencies registered here so home is ready inside base
    Get.lazyPut<HomeProvider>(() => HomeProvider());
    Get.lazyPut<HomeRepository>(() => HomeRepository(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
