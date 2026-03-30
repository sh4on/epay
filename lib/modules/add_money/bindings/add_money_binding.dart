import 'package:get/get.dart';
import '../controllers/add_money_controller.dart';
import '../../../data/providers/add_money_provider.dart';
import '../../../data/repositories/add_money_repository.dart';

class AddMoneyBinding extends Bindings {
  @override
  void dependencies() {
    // provider and repository
    Get.lazyPut<AddMoneyProvider>(() => AddMoneyProvider());
    Get.lazyPut<AddMoneyRepository>(
            () => AddMoneyRepository(Get.find()));

    // controller
    Get.lazyPut<AddMoneyController>(
            () => AddMoneyController(Get.find()));
  }
}