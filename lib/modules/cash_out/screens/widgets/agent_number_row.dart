import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../controllers/cash_out_controller.dart';

class AgentNumberRow extends StatelessWidget {
  final CashOutController controller;

  const AgentNumberRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // input field
        Expanded(
          child: GestureDetector(
            onTap: controller.onAgentProceed,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider, width: 1),
                ),
              ),
              child: Row(
                children: [
                  // input or filled phone number
                  Expanded(
                    child: TextField(
                      controller: controller.agentNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: AppTypography.bodyLarge,
                      decoration: InputDecoration(
                        hintText: AppStrings.inputAgentNumber,
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textHint,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (val) {
                        controller.selectedPhone.value = val;
                      },
                    ),
                  ),

                  // arrow icon
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        // contact book icon
        ContactBookIconButton(onTap: () {}),
      ],
    );
  }
}
