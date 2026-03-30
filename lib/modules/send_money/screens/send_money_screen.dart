import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/send_money_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/contact_model.dart';
import '../../../shared/common_widgets/contact_list_item.dart';
import '../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../shared/common_widgets/section_header.dart';

class SendMoneyScreen extends GetView<SendMoneyController> {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.sendMoney),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() {
        // loading state
        if (controller.contactsStatus.value.isLoading) {
          return const LoadingStateWidget(
            loadingMessage: 'Loading contacts...',
          );
        }

        // error state
        if (controller.contactsStatus.value.isError) {
          return ErrorStateWidget(onRetry: controller.fetchContacts);
        }

        // success state
        return _SendMoneyBody(controller: controller);
      }),
    );
  }
}

// ─── body ─────────────────────────────────────────────────────────────────────

class _SendMoneyBody extends StatelessWidget {
  final SendMoneyController controller;

  const _SendMoneyBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // search / number input row
          _SearchInputRow(controller: controller),

          const Divider(height: AppSpacing.xxl),

          // recent contacts section
          SectionHeader(title: AppStrings.recentContacts),

          _ContactsList(
            contacts: controller.recentContacts,
            onContactTap: controller.onContactTapped,
          ),

          const SizedBox(height: AppSpacing.md),

          // all contacts section
          SectionHeader(title: AppStrings.allContacts),

          _ContactsList(
            contacts: controller.allContacts,
            onContactTap: controller.onContactTapped,
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

// ─── search input row ─────────────────────────────────────────────────────────

class _SearchInputRow extends StatelessWidget {
  final SendMoneyController controller;

  const _SearchInputRow({required this.controller});

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

// ─── contacts list ────────────────────────────────────────────────────────────

class _ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final void Function(ContactModel) onContactTap;

  const _ContactsList({
    required this.contacts,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Text(
          'No contacts found.',
          style: AppTypography.bodySmall,
        ),
      );
    }

    return Column(
      children: contacts
          .map(
            (contact) => Column(
          children: [
            // single contact row
            ContactListItem(
              contact: contact,
              onTap: () => onContactTap(contact),
            ),
            const Divider(height: 1),
          ],
        ),
      )
          .toList(),
    );
  }
}