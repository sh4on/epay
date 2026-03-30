import 'package:get/get.dart';
import '../controllers/send_money_controller.dart';
import '../../../data/providers/send_money_provider.dart';
import '../../../data/repositories/send_money_repository.dart';

class SendMoneyBinding extends Bindings {
  @override
  void dependencies() {
    // provider and repository
    Get.lazyPut<SendMoneyProvider>(() => SendMoneyProvider());
    Get.lazyPut<SendMoneyRepository>(
            () => SendMoneyRepository(Get.find()));

    // controller
    Get.lazyPut<SendMoneyController>(
            () => SendMoneyController(Get.find()));
  }
}