import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/cash_out_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/contact_model.dart';
import '../../../data/models/bank_model.dart';
import '../../../shared/common_widgets/contact_list_item.dart';
import '../../../shared/common_widgets/contact_book_icon_button.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../shared/common_widgets/section_header.dart';

class CashOutScreen extends GetView<CashOutController> {
  const CashOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.cashOut),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          // agent / atm tab selector
          _CashOutTabSelector(controller: controller),

          // tab content
          Expanded(
            child: Obx(() {
              return controller.activeTab.value == CashOutTab.agent
                  ? _AgentTabContent(controller: controller)
                  : _AtmTabContent(controller: controller);
            }),
          ),
        ],
      ),
    );
  }
}

// ─── tab selector ─────────────────────────────────────────────────────────────

class _CashOutTabSelector extends StatelessWidget {
  final CashOutController controller;

  const _CashOutTabSelector({required this.controller});

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
              child: _TabButton(
                icon: Icons.group,
                label: AppStrings.agent,
                isActive: isAgent,
                onTap: () => controller.switchTab(CashOutTab.agent),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // atm tab
            Expanded(
              child: _TabButton(
                icon: Icons.atm,
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

// single tab button — active is filled navy, inactive is white
class _TabButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
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
        height: 88,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: AppColors.divider,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // tab icon
            Icon(
              icon,
              size: AppSpacing.iconLg,
              color: isActive ? AppColors.white : AppColors.primary,
            ),

            const SizedBox(height: AppSpacing.xs),

            // tab label
            Text(
              label,
              style: AppTypography.titleMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── agent tab ────────────────────────────────────────────────────────────────

class _AgentTabContent extends StatelessWidget {
  final CashOutController controller;

  const _AgentTabContent({required this.controller});

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
            _AgentNumberRow(controller: controller),

            const SizedBox(height: AppSpacing.lg),

            // qr scan button
            _QrScanButton(onTap: controller.onQrScanTap),

            const SizedBox(height: AppSpacing.xl),

            // recent contacts section
            SectionHeader(title: AppStrings.recentContacts),

            _ContactsList(
              contacts: controller.recentContacts,
              onContactTap: controller.onContactTapped,
            ),

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
    });
  }
}

// agent number input + contact book icon
class _AgentNumberRow extends StatelessWidget {
  final CashOutController controller;

  const _AgentNumberRow({required this.controller});

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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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

// qr scan outlined button
class _QrScanButton extends StatelessWidget {
  final VoidCallback onTap;

  const _QrScanButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // qr icon
            const Icon(
              Icons.qr_code_scanner,
              color: AppColors.primary,
              size: AppSpacing.iconMd,
            ),

            const SizedBox(width: AppSpacing.sm),

            // label
            Text(
              AppStrings.tapToScanQrCode,
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// contacts list — renders contact items
class _ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  final void Function(ContactModel) onContactTap;

  const _ContactsList({
    required this.contacts,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contacts
          .map((contact) => Column(
        children: [
          ContactListItem(
            contact: contact,
            onTap: () => onContactTap(contact),
          ),
          const Divider(height: 1),
        ],
      ))
          .toList(),
    );
  }
}

// ─── atm tab ──────────────────────────────────────────────────────────────────

class _AtmTabContent extends StatelessWidget {
  final CashOutController controller;

  const _AtmTabContent({required this.controller});

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
            child: Obx(() => controller.filteredBanks.isEmpty
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
                return _BankCard(
                  bank: bank,
                  onTap: () => controller.onBankTapped(bank),
                );
              },
            )),
          ),

          // contact us footer
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.didYouFaceIssue} ',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  AppStrings.contactUs,
                  style: AppTypography.link,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

// partner bank card
class _BankCard extends StatelessWidget {
  final BankModel bank;
  final VoidCallback onTap;

  const _BankCard({required this.bank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            // bank info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // bank name
                  Text(bank.name, style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.xs),

                  // branch name
                  Text(
                    'Branch Name: ${bank.branchName}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),

            // bank illustration placeholder
            Container(
              width: 72,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: const Icon(
                Icons.account_balance,
                color: AppColors.primary,
                size: AppSpacing.iconLg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}