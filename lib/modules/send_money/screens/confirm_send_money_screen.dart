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
      backgroundColor: AppColors.white,
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

                  // contact number section
                  _ConfirmDetailSection(
                    label: AppStrings.contactNumber,
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
                  _ConfirmDetailSection(
                    label: AppStrings.amount,
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.xl),

                        // large centered amount display
                        Obx(() => Text(
                          'TK: ${controller.enteredAmount.value.toStringAsFixed(0)}',
                          style: controller.enteredAmount.value > 0
                              ? AppTypography.amountDisplay
                              : AppTypography.amountDisplay.copyWith(
                            color: AppColors.textHint,
                          ),
                        )),

                        const SizedBox(height: AppSpacing.lg),

                        // available balance hint
                        Obx(() => Text(
                          '${AppStrings.availableBalance} '
                              '${(controller.availableBalance - controller.enteredAmount.value).toStringAsFixed(0)} TK',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        )),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  const SizedBox(height: AppSpacing.xl),

                  // hidden auto-focus amount input
                  _AmountInputField(controller: controller),
                ],
              ),
            ),
          ),

          // confirm button — disabled when no amount entered
          _ConfirmButton(controller: controller),
        ],
      ),
    );
  }
}

// ─── confirm detail section ───────────────────────────────────────────────────

class _ConfirmDetailSection extends StatelessWidget {
  final String label;
  final Widget child;

  const _ConfirmDetailSection({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section label
        Text(label, style: AppTypography.titleMedium),

        const SizedBox(height: AppSpacing.md),

        // centered content
        Center(child: child),

        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

// ─── hidden amount input ──────────────────────────────────────────────────────

class _AmountInputField extends StatelessWidget {
  final SendMoneyController controller;

  const _AmountInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // invisible 1x1 autofocus field
          SizedBox(
            width: 1,
            height: 1,
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: controller.onAmountChanged,
              decoration: const InputDecoration(border: InputBorder.none),
              style: const TextStyle(
                fontSize: 1,
                color: Colors.transparent,
              ),
            ),
          ),

          // tap hint text
          Text(
            'Tap to enter amount',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── confirm button ───────────────────────────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  final SendMoneyController controller;

  const _ConfirmButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Obx(() {
        final hasAmount = controller.enteredAmount.value > 0;
        final isProcessing = controller.isProcessing.value;

        // show spinner while processing
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
              // active navy when amount entered, grey when empty
              backgroundColor:
              hasAmount ? AppColors.primary : AppColors.buttonDisabled,
              disabledBackgroundColor: AppColors.buttonDisabled,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
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
    );
  }
}