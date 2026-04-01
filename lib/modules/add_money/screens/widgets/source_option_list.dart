import 'package:epay/modules/add_money/screens/widgets/source_option_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../controllers/add_money_controller.dart';

class SourceOptionsList extends StatelessWidget {
  final AddMoneyController controller;

  const SourceOptionsList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // single Obx reads ALL observables it needs directly in one scope
    return Obx(() {
      // read active tab to determine which list to show
      final isBank = controller.activeTab.value == AddMoneyTab.bankToEkpay;

      // read the correct sources list observable directly
      final sources = isBank
          ? controller.bankSources.toList()
          : controller.cardSources.toList();

      // read the correct selected id observable directly
      final selectedId = isBank
          ? controller.selectedBankSourceId.value
          : controller.selectedCardSourceId.value;

      if (sources.isEmpty) {
        return const Center(
          child: Text(
            'No sources available.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        );
      }

      return Column(
        children: sources.map((source) {
          final isSelected = source.id == selectedId;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: SourceOptionCard(
              source: source,
              isSelected: isSelected,
              onTap: () {
                // select correct source based on active tab
                if (isBank) {
                  controller.selectBankSource(source.id);
                } else {
                  controller.selectCardSource(source.id);
                }
              },
            ),
          );
        }).toList(),
      );
    });
  }
}
