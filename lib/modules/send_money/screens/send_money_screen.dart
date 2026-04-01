import 'package:epay/modules/send_money/screens/widgets/send_money_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/send_money_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/contact_model.dart';
import '../../../shared/common_widgets/contact_list_item.dart';
import '../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../shared/common_widgets/section_header.dart';

class SendMoneyScreen extends GetView<SendMoneyController> {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sendMoney),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        // loading state
        if (controller.contactsStatus.value.isLoading) {
          return const LoadingStateWidget(
            loadingMessage: 'Loading contacts...',
          );
        }

        // error state
        if (controller.contactsStatus.value.isError) {
          return ErrorStateWidget(onRetry: controller.fetchContacts);
        }

        // success state
        return SendMoneyBody(controller: controller);
      }),
    );
  }
}
