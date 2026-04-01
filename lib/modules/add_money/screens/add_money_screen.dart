import 'package:epay/modules/add_money/screens/widgets/add_money_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_money_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';

class AddMoneyScreen extends GetView<AddMoneyController> {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.addMoney),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        // loading state
        if (controller.status.value.isLoading) {
          return const LoadingStateWidget(loadingMessage: 'Loading sources...');
        }

        // error state
        if (controller.status.value.isError) {
          return ErrorStateWidget(onRetry: controller.fetchSources);
        }

        // success state
        return AddMoneyBody(controller: controller);
      }),
    );
  }
}
