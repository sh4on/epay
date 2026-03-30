import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        // title with regular + bold split
        title: RichText(
          text: TextSpan(
            style: AppTypography.headlineSmall,
            children: const [
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
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
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

                  // agent section
                  _ConfirmSection(
                    label: AppStrings.agent,
                    child: Obx(() => Text(
                      controller.selectedPhone.value,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),

                  const Divider(height: 1),

                  const SizedBox(height: AppSpacing.xl),

                  // amount section
                  _ConfirmSection(
                    label: AppStrings.amount,
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.xl),

                        // amount display — large centered
                        Obx(() => Text(
                          'TK: ${controller.enteredAmount.value.toStringAsFixed(0)}',
                          style: controller.enteredAmount.value > 0
                              ? AppTypography.amountDisplay
                              : AppTypography.amountDisplay.copyWith(
                            color: AppColors.textHint,
                          ),
                        )),

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
                  _HiddenAmountInput(controller: controller),
                ],
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
                      borderRadius:
                      BorderRadius.circular(AppSpacing.radiusButton),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.confirm,
                    style: AppTypography.labelLarge,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// confirm detail section with label + child
class _ConfirmSection extends StatelessWidget {
  final String label;
  final Widget child;

  const _ConfirmSection({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section label
        Text(label, style: AppTypography.titleMedium),

        const SizedBox(height: AppSpacing.md),

        // section content centered
        Center(child: child),

        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

// invisible text field to capture numpad input for amount
class _HiddenAmountInput extends StatelessWidget {
  final CashOutController controller;

  const _HiddenAmountInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // show keyboard to enter amount
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            SizedBox(
              width: 1,
              height: 1,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: true,
                onChanged: controller.onAmountChanged,
                decoration: const InputDecoration(border: InputBorder.none),
                style: const TextStyle(fontSize: 1, color: Colors.transparent),
              ),
            ),

            // tap to enter amount hint
            Text(
              'Tap to enter amount',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}