import 'package:epay/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../controllers/add_money_controller.dart';
import 'add_money_tab_icon.dart';

class AddMoneyTabSelector extends StatelessWidget {
  final AddMoneyController controller;

  const AddMoneyTabSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: Row(
        children: [
          // bank to ekpay tab
          Expanded(
            child: Obx(
              () => _AddMoneyTab(
                icon: Icons.account_balance_outlined,
                label: AppStrings.bankToEkpay,
                // Obx reads .value here — correct scope
                isActive: controller.activeTab.value == AddMoneyTab.bankToEkpay,
                onTap: () => controller.switchTab(AddMoneyTab.bankToEkpay),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          // card to ekpay tab
          Expanded(
            child: Obx(
              () => _AddMoneyTab(
                icon: Icons.credit_card_outlined,
                label: AppStrings.cardToEkpay,
                // Obx reads .value here — correct scope
                isActive: controller.activeTab.value == AddMoneyTab.cardToEkpay,
                onTap: () => controller.switchTab(AddMoneyTab.cardToEkpay),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// single add money tab button — pure StatelessWidget, receives plain bool
class _AddMoneyTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _AddMoneyTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: context.screenHeight * 0.13,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.divider,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tab icon
            AddMoneyTabIcon(isActive: isActive, label: label),

            const SizedBox(height: AppSpacing.xs + 2),

            // tab label
            Text(
              label,
              style: AppTypography.titleMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
