import 'package:epay/modules/add_money/screens/widgets/source_option_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/app_button.dart';
import '../../controllers/add_money_controller.dart';
import 'add_money_tab_selector.dart';

class AddMoneyBody extends StatelessWidget {
  final AddMoneyController controller;

  const AddMoneyBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tab selector
        AddMoneyTabSelector(controller: controller),

        const SizedBox(height: AppSpacing.xxl),

        // select source label
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Center(
            child: Text(
              AppStrings.selectAddMoneySource,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),

        const Divider(height: AppSpacing.xl),

        // source options list — reactive reads are inside the list itself
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: SourceOptionsList(controller: controller),
          ),
        ),

        // proceed button — own Obx only for isProcessing
        // Padding(
        //   padding: const EdgeInsets.all(AppSpacing.screenPadding),
        //   child: Obx(
        //     () => controller.isProcessing.value
        //         ? const Center(
        //             child: CircularProgressIndicator(color: AppColors.primary),
        //           )
        //         : AppButton(
        //             label: 'Proceed',
        //             onPressed: controller.onProceedTap,
        //           ),
        //   ),
        // ),
      ],
    );
  }
}
