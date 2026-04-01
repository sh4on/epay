import 'package:epay/modules/send_money/screens/widgets/amount_input_field.dart';
import 'package:epay/modules/send_money/screens/widgets/confirm_button.dart';
import 'package:epay/modules/send_money/screens/widgets/confirm_detail_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/send_money_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';

class ConfirmSendMoneyScreen extends GetView<SendMoneyController> {
  const ConfirmSendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // split title — regular + bold
        title: RichText(
          text: TextSpan(
            style: AppTypography.headlineSmall,
            children: const [
              TextSpan(
                text: 'Confirm to ',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: 'Send Money',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xl),

                  // contact number section
                  ConfirmDetailSection(
                    label: AppStrings.contactNumber,
                    child: Obx(
                      () => Text(
                        controller.selectedPhone.value,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const Divider(height: 1),

                  const SizedBox(height: AppSpacing.xl),

                  // amount section
                  ConfirmDetailSection(
                    label: AppStrings.amount,
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.xl),

                        // amount display — large centered with clickable area
                        Obx(
                          () => InkWell(
                            onTap: () {
                              controller.amountFocusNode.requestFocus();
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Text(
                                'TK: ${controller.enteredAmount.value.toStringAsFixed(0)}',
                                style: controller.enteredAmount.value > 0
                                    ? AppTypography.amountDisplay
                                    : AppTypography.amountDisplay.copyWith(
                                        color: AppColors.textHint,
                                      ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        // available balance hint
                        Obx(
                          () => Text(
                            '${AppStrings.availableBalance} '
                            '${(controller.availableBalance - controller.enteredAmount.value).toStringAsFixed(0)} TK',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  const SizedBox(height: AppSpacing.xl),

                  // hidden amount input
                  AmountInputField(controller: controller),
                ],
              ),
            ),
          ),

          // confirm button — disabled when no amount entered
          ConfirmButton(controller: controller),
        ],
      ),
    );
  }
}
