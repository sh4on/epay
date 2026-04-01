import 'package:epay/shared/common_widgets/contact_us_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/error_state_widget.dart';
import '../../../../shared/common_widgets/loading_state_widget.dart';
import '../../controllers/cash_out_controller.dart';
import 'bank_card.dart';

class AtmTabContent extends StatelessWidget {
  final CashOutController controller;

  const AtmTabContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.banksStatus.value.isLoading) {
        return const LoadingStateWidget(loadingMessage: 'Loading banks...');
      }

      if (controller.banksStatus.value.isError) {
        return ErrorStateWidget(onRetry: controller.fetchBanks);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // available balance row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
              vertical: AppSpacing.md,
            ),
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodyLarge,
                children: [
                  TextSpan(
                    text: '${AppStrings.availableBalance} ',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text:
                        '${controller.availableBalance.toStringAsFixed(0)} TK',
                    style: AppTypography.bodyLarge,
                  ),
                ],
              ),
            ),
          ),

          // bank search field
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: TextField(
              controller: controller.bankSearchController,
              style: AppTypography.bodyMedium,
              decoration: InputDecoration(
                hintText: AppStrings.searchForPartnerBank,
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // bank list
          Expanded(
            child: Obx(
              () => controller.filteredBanks.isEmpty
                  ? const Center(
                      child: Text(
                        'No banks found.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenPadding,
                      ),
                      itemCount: controller.filteredBanks.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (_, index) {
                        final bank = controller.filteredBanks[index];
                        return BankCard(
                          bank: bank,
                          onTap: () => controller.onBankTapped(bank),
                        );
                      },
                    ),
            ),
          ),

          // contact us footer
          const ContactUsRow(),
          const SizedBox(height: kToolbarHeight),
        ],
      );
    });
  }
}
