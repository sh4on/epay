import 'package:get/get.dart';
import '../controllers/cash_out_controller.dart';
import '../../../data/providers/cash_out_provider.dart';
import '../../../data/repositories/cash_out_repository.dart';

class CashOutBinding extends Bindings {
  @override
  void dependencies() {
    // provider and repository
    Get.lazyPut<CashOutProvider>(() => CashOutProvider());
    Get.lazyPut<CashOutRepository>(() => CashOutRepository(Get.find()));

    // controller
    Get.lazyPut<CashOutController>(() => CashOutController(Get.find()));
  }
}
