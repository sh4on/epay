import 'package:epay/modules/cash_out/screens/widgets/tab_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../gen/assets.gen.dart';
import '../../controllers/cash_out_controller.dart';

class CashOutTabSelector extends StatelessWidget {
  final CashOutController controller;

  const CashOutTabSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAgent = controller.activeTab.value == CashOutTab.agent;

      return Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Row(
          children: [
            // agent tab
            Expanded(
              child: TabButton(
                iconPath: Assets.home.cashOut.agent,
                label: AppStrings.agent,
                isActive: isAgent,
                onTap: () => controller.switchTab(CashOutTab.agent),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // atm tab
            Expanded(
              child: TabButton(
                iconPath: Assets.home.cashOut.atm,
                label: AppStrings.atm,
                isActive: !isAgent,
                onTap: () => controller.switchTab(CashOutTab.atm),
              ),
            ),
          ],
        ),
      );
    });
  }
}
