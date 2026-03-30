import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_money_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../shared/common_widgets/app_button.dart';

class AddMoneyScreen extends GetView<AddMoneyController> {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(AppStrings.addMoney),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() {
        // loading state
        if (controller.status.value.isLoading) {
          return const LoadingStateWidget(
            loadingMessage: 'Loading sources...',
          );
        }

        // error state
        if (controller.status.value.isError) {
          return ErrorStateWidget(onRetry: controller.fetchSources);
        }

        // success state
        return _AddMoneyBody(controller: controller);
      }),
    );
  }
}

// ─── body ─────────────────────────────────────────────────────────────────────

class _AddMoneyBody extends StatelessWidget {
  final AddMoneyController controller;

  const _AddMoneyBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // tab selector — bank to ekpay / card to ekpay
        _AddMoneyTabSelector(controller: controller),

        const SizedBox(height: AppSpacing.xxl),

        // select source label
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.selectAddMoneySource,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),

        const Divider(height: AppSpacing.xl),

        // source options list
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Obx(() => _SourceOptionsList(
              controller: controller,
            )),
          ),
        ),

        // proceed button
        Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Obx(() => controller.isProcessing.value
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
              : AppButton(
            label: 'Proceed',
            onPressed: controller.onProceedTap,
          )),
        ),
      ],
    );
  }
}

// ─── tab selector ─────────────────────────────────────────────────────────────

class _AddMoneyTabSelector extends StatelessWidget {
  final AddMoneyController controller;

  const _AddMoneyTabSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isBankTab =
          controller.activeTab.value == AddMoneyTab.bankToEkpay;

      return Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        child: Row(
          children: [
            // bank to ekpay tab
            Expanded(
              child: _AddMoneyTab(
                icon: Icons.account_balance_outlined,
                label: AppStrings.bankToEkpay,
                isActive: isBankTab,
                onTap: () => controller.switchTab(AddMoneyTab.bankToEkpay),
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            // card to ekpay tab
            Expanded(
              child: _AddMoneyTab(
                icon: Icons.credit_card_outlined,
                label: AppStrings.cardToEkpay,
                isActive: !isBankTab,
                onTap: () => controller.switchTab(AddMoneyTab.cardToEkpay),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// single add money tab button
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
        height: 88,
        decoration: BoxDecoration(
          // active — filled navy, inactive — white with border
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
            _AddMoneyTabIcon(
              icon: icon,
              isActive: isActive,
              label: label,
            ),

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

// custom icon per tab type
class _AddMoneyTabIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final String label;

  const _AddMoneyTabIcon({
    required this.icon,
    required this.isActive,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // bank tab — custom bank with arrow icon
    if (label == AppStrings.bankToEkpay) {
      return SizedBox(
        width: 36,
        height: 36,
        child: CustomPaint(
          painter: _BankArrowIconPainter(
            color: isActive ? AppColors.white : AppColors.primary,
          ),
        ),
      );
    }

    // card tab — custom card icon
    return SizedBox(
      width: 36,
      height: 36,
      child: CustomPaint(
        painter: _CardIconPainter(
          color: isActive ? AppColors.white : AppColors.primary,
        ),
      ),
    );
  }
}

// bank with right arrow icon painter
class _BankArrowIconPainter extends CustomPainter {
  final Color color;
  _BankArrowIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // bank building base
    canvas.drawLine(
      Offset(cx - 12, cy + 8),
      Offset(cx + 4, cy + 8),
      paint,
    );

    // bank columns
    canvas.drawLine(Offset(cx - 9, cy + 8), Offset(cx - 9, cy), paint);
    canvas.drawLine(Offset(cx - 4, cy + 8), Offset(cx - 4, cy), paint);
    canvas.drawLine(Offset(cx + 1, cy + 8), Offset(cx + 1, cy), paint);

    // bank roof line
    canvas.drawLine(
      Offset(cx - 14, cy),
      Offset(cx + 6, cy),
      paint,
    );

    // roof triangle peak
    canvas.drawLine(Offset(cx - 14, cy), Offset(cx - 4, cy - 8), paint);
    canvas.drawLine(Offset(cx + 6, cy), Offset(cx - 4, cy - 8), paint);

    // arrow pointing right
    canvas.drawLine(
      Offset(cx + 8, cy),
      Offset(cx + 16, cy),
      paint,
    );
    canvas.drawLine(Offset(cx + 12, cy - 4), Offset(cx + 16, cy), paint);
    canvas.drawLine(Offset(cx + 12, cy + 4), Offset(cx + 16, cy), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// card with arrows icon painter
class _CardIconPainter extends CustomPainter {
  final Color color;
  _CardIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // card body
    final cardRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx - 2, cy), width: 26, height: 18),
      const Radius.circular(3),
    );
    canvas.drawRRect(cardRect, paint);

    // card stripe
    canvas.drawLine(
      Offset(cx - 15, cy - 2),
      Offset(cx + 11, cy - 2),
      paint,
    );

    // up arrow — top right
    canvas.drawLine(Offset(cx + 12, cy - 6), Offset(cx + 12, cy - 12), paint);
    canvas.drawLine(Offset(cx + 9, cy - 9), Offset(cx + 12, cy - 12), paint);
    canvas.drawLine(Offset(cx + 15, cy - 9), Offset(cx + 12, cy - 12), paint);

    // down arrow — bottom right
    canvas.drawLine(Offset(cx + 12, cy + 4), Offset(cx + 12, cy + 10), paint);
    canvas.drawLine(Offset(cx + 9, cy + 7), Offset(cx + 12, cy + 10), paint);
    canvas.drawLine(Offset(cx + 15, cy + 7), Offset(cx + 12, cy + 10), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── source options list ──────────────────────────────────────────────────────

class _SourceOptionsList extends StatelessWidget {
  final AddMoneyController controller;

  const _SourceOptionsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    final sources = controller.activeSources;
    final selectedId = controller.activeSelectedId;

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
          child: _SourceOptionCard(
            source: source,
            isSelected: isSelected,
            onTap: () {
              // update selection based on active tab
              if (controller.activeTab.value == AddMoneyTab.bankToEkpay) {
                controller.selectBankSource(source.id);
              } else {
                controller.selectCardSource(source.id);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}

// single source option card with radio indicator
class _SourceOptionCard extends StatelessWidget {
  final MoneySourceItem source;
  final bool isSelected;
  final VoidCallback onTap;

  const _SourceOptionCard({
    required this.source,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            // highlighted border when selected
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // source icon
            _SourceIcon(icon: source.icon, isSelected: isSelected),

            const SizedBox(width: AppSpacing.lg),

            // source label
            Expanded(
              child: Text(
                source.label,
                style: AppTypography.titleMedium.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textPrimary,
                ),
              ),
            ),

            // radio circle indicator
            _RadioIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

// source type icon
class _SourceIcon extends StatelessWidget {
  final String icon;
  final bool isSelected;

  const _SourceIcon({required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Icon(
      _iconData(icon),
      color: isSelected ? AppColors.primary : AppColors.textSecondary,
      size: AppSpacing.iconLg,
    );
  }

  IconData _iconData(String icon) {
    switch (icon) {
      case 'bank_account':
        return Icons.account_balance_outlined;
      case 'internet_banking':
        return Icons.language_outlined;
      case 'debit_card':
        return Icons.credit_card_outlined;
      case 'credit_card':
        return Icons.credit_card_outlined;
      default:
        return Icons.payment_outlined;
    }
  }
}

// animated radio circle indicator
class _RadioIndicator extends StatelessWidget {
  final bool isSelected;

  const _RadioIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.divider,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
        Icons.check,
        color: AppColors.white,
        size: 16,
      )
          : null,
    );
  }
}