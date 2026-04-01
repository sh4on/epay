import 'package:epay/modules/cash_out/screens/widgets/agent_tab_content.dart';
import 'package:epay/modules/cash_out/screens/widgets/atm_tab_content.dart';
import 'package:epay/modules/cash_out/screens/widgets/cash_out_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cash_out_controller.dart';
import '../../../core/constants/app_strings.dart';

class CashOutScreen extends GetView<CashOutController> {
  const CashOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cashOut),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Column(
        children: [
          // agent / atm tab selector
          CashOutTabSelector(controller: controller),

          // tab content
          Expanded(
            child: Obx(() {
              return controller.activeTab.value == CashOutTab.agent
                  ? AgentTabContent(controller: controller)
                  : AtmTabContent(controller: controller);
            }),
          ),
        ],
      ),
    );
  }
}
