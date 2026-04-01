import 'package:epay/modules/cash_out/screens/widgets/confirm_section.dart';
import 'package:epay/modules/cash_out/screens/widgets/hidden_amount_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cash_out_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';

class ConfirmCashOutScreen extends GetView<CashOutController> {
  const ConfirmCashOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title with regular + bold split
        title: RichText(
          text: const TextSpan(
            style: AppTypography.headlineSmall,
            children: [
              TextSpan(
                text: 'Confirm to ',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: 'Cash Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            controller.enteredAmount.value = 0;
            Get.back();
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // agent section
                    ConfirmSection(
                      label: AppStrings.agent,
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
                    ConfirmSection(
                      label: AppStrings.amount,
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.xl),

                          // amount display — large centered
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

                          // available balance
                          Text(
                            '${AppStrings.availableBalance} ${controller.availableBalance.toStringAsFixed(0)} TK',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    const SizedBox(height: AppSpacing.xl),

                    // hidden numpad input
                    HiddenAmountInput(controller: controller),
                  ],
                ),
              ),
            ),
          ),

          // confirm button — disabled when amount is 0
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Obx(() {
              final hasAmount = controller.enteredAmount.value > 0;
              final isProcessing = controller.isProcessing.value;

              if (isProcessing) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              return SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: ElevatedButton(
                  onPressed: hasAmount
                      ? () => controller.onConfirmTap(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hasAmount
                        ? AppColors.primary
                        : AppColors.buttonDisabled,
                    disabledBackgroundColor: AppColors.buttonDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusButton,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    AppStrings.confirm,
                    style: AppTypography.labelLarge,
                  ),
                ),
              );
            }),
          ),

          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom > 0
                ? 10
                : kBottomNavigationBarHeight,
          ),
        ],
      ),
    );
  }
}
