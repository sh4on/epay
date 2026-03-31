import 'package:epay/modules/cash_out/screens/widgets/agent_tab_content.dart';
import 'package:epay/modules/cash_out/screens/widgets/atm_tab_content.dart';
import 'package:epay/modules/cash_out/screens/widgets/cash_out_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../controllers/cash_out_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/models/bank_model.dart';
import '../../../shared/common_widgets/contact_list_item.dart';
import '../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../shared/common_widgets/section_header.dart';

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