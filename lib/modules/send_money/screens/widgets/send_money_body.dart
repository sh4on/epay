import 'package:epay/modules/send_money/screens/widgets/search_input_row.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/common_widgets/section_header.dart';
import '../../../cash_out/screens/widgets/contacts_list.dart';
import '../../controllers/send_money_controller.dart';

class SendMoneyBody extends StatelessWidget {
  final SendMoneyController controller;

  const SendMoneyBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // search / number input row
          SearchInputRow(controller: controller),

          const Divider(height: AppSpacing.xxl),

          // recent contacts section
          const SectionHeader(title: AppStrings.recentContacts),

          ContactsList(
            contacts: controller.recentContacts,
            onContactTap: controller.onContactTapped,
          ),

          const SizedBox(height: AppSpacing.md),

          // all contacts section
          const SectionHeader(title: AppStrings.allContacts),

          ContactsList(
            contacts: controller.allContacts,
            onContactTap: controller.onContactTapped,
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
