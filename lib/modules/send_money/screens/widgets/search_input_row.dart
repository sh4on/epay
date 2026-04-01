import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../controllers/send_money_controller.dart';

class SearchInputRow extends StatelessWidget {
  final SendMoneyController controller;

  const SearchInputRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // name or number text field
        Expanded(
          child: Container(
            height: 48,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.divider, width: 1),
              ),
            ),
            child: Row(
              children: [
                // text input
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    style: AppTypography.bodyLarge,
                    onSubmitted: (_) => controller.onProceed(),
                    decoration: InputDecoration(
                      hintText: AppStrings.enterNameOrNumber,
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textHint,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                // chevron — tap to proceed
                GestureDetector(
                  onTap: controller.onProceed,
                  child: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
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
