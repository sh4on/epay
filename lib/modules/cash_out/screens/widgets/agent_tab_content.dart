
import 'package:epay/modules/cash_out/screens/widgets/qr_scan_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../../shared/common_widgets/error_state_widget.dart';
import '../../../../shared/common_widgets/loading_state_widget.dart';
import '../../../../shared/common_widgets/section_header.dart';
import '../../controllers/cash_out_controller.dart';
import 'agent_number_row.dart';
import 'contacts_list.dart';

class AgentTabContent extends StatelessWidget {
  final CashOutController controller;

  const AgentTabContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.contactsStatus.value.isLoading) {
        return const LoadingStateWidget(loadingMessage: 'Loading contacts...');
      }

      if (controller.contactsStatus.value.isError) {
        return ErrorStateWidget(onRetry: controller.fetchContacts);
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // agent number input row
            AgentNumberRow(controller: controller),

            const SizedBox(height: AppSpacing.lg),

            // qr scan button
            QrScanButton(onTap: controller.onQrScanTap),

            const SizedBox(height: AppSpacing.xl),

            // recent contacts section
            SectionHeader(title: AppStrings.recentContacts),

            ContactsList(
              contacts: controller.recentContacts,
              onContactTap: controller.onContactTapped,
            ),

            // all contacts section
            SectionHeader(title: AppStrings.allContacts),

            ContactsList(
              contacts: controller.allContacts,
              onContactTap: controller.onContactTapped,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      );
    });
  }
}