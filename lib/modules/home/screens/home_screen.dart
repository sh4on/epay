import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../base/controllers/base_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';
import '../../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final baseController = Get.find<BaseController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Obx(() {
        // loading state
        if (homeController.status.value.isLoading) {
          return const LoadingStateWidget(loadingMessage: 'Loading your dashboard...');
        }

        // error state
        if (homeController.status.value.isError) {
          return ErrorStateWidget(onRetry: homeController.fetchHomeData);
        }

        return CustomScrollView(
          slivers: [
            // app bar with user info + points badge
            SliverToBoxAdapter(
              child: _HomeAppBar(baseController: baseController),
            ),

            // balance card
            SliverToBoxAdapter(
              child: _BalanceCard(baseController: baseController),
            ),

            // white content area
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // services grid — first 4 + see more
                    _ServicesGrid(controller: homeController),

                    const SizedBox(height: AppSpacing.lg),

                    // pay bill section
                    _PayBillSection(controller: homeController),

                    const SizedBox(height: AppSpacing.lg),

                    // remittance section
                    _RemittanceSection(controller: homeController),

                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── app bar ─────────────────────────────────────────────────────────────────

class _HomeAppBar extends StatelessWidget {
  final BaseController baseController;

  const _HomeAppBar({required this.baseController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppSpacing.md,
        left: AppSpacing.screenPadding,
        right: AppSpacing.screenPadding,
        bottom: AppSpacing.lg,
      ),
      child: Row(
        children: [
          // drawer menu icon
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Row(
              children: [
                // avatar placeholder
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: AppSpacing.iconMd,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // user name
                Obx(() => Text(
                  baseController.user.value?.name ?? '',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),

          const Spacer(),

          // points badge
          Obx(() => _PointsBadge(points: baseController.formattedPoints)),
        ],
      ),
    );
  }
}

// gold points badge — top right
class _PointsBadge extends StatelessWidget {
  final String points;

  const _PointsBadge({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        children: [
          // trophy icon
          const Icon(Icons.emoji_events, color: AppColors.white, size: 16),
          const SizedBox(width: AppSpacing.xs),

          // points text
          Text(
            points,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── balance card ─────────────────────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  final BaseController baseController;

  const _BalanceCard({required this.baseController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      child: Container(
        margin: const EdgeInsets.only(
          left: AppSpacing.screenPadding,
          right: AppSpacing.screenPadding,
          bottom: AppSpacing.xl,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.xl,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          children: [
            // your balance label
            Text(
              AppStrings.yourBalance,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // balance amount + visibility toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                  baseController.isBalanceVisible.value
                      ? baseController.formattedBalance
                      : 'Tk: ••••••',
                  style: AppTypography.balanceAmount,
                )),
                const SizedBox(width: AppSpacing.sm),

                // show/hide balance icon
                GestureDetector(
                  onTap: baseController.toggleBalanceVisibility,
                  child: Obx(() => Icon(
                    baseController.isBalanceVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textSecondary,
                    size: AppSpacing.iconMd,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── services grid ────────────────────────────────────────────────────────────

class _ServicesGrid extends StatelessWidget {
  final HomeController controller;

  const _ServicesGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // show first 4 or all 8 based on toggle
      final displayItems = controller.showAllServices.value
          ? controller.services
          : controller.services.take(4).toList();

      return Column(
        children: [
          // 4-column grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            childAspectRatio: 0.85,
            children: displayItems
                .map((item) => _ServiceGridItem(
              item: item,
              onTap: () => controller.onServiceTap(item),
            ))
                .toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // see more button
          _SeeMoreButton(
            label: controller.showAllServices.value
                ? 'See Less'
                : AppStrings.seeMore,
            onTap: controller.toggleSeeMoreServices,
          ),
        ],
      );
    });
  }
}

// individual service icon + label in grid
class _ServiceGridItem extends StatelessWidget {
  final ServiceItem item;
  final VoidCallback onTap;

  const _ServiceGridItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              _serviceIcon(item.icon),
              color: AppColors.primary,
              size: AppSpacing.iconLg,
            ),
          ),

          const SizedBox(height: AppSpacing.xs + 2),

          // service label
          Text(
            item.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // map icon string to flutter icon
  IconData _serviceIcon(String icon) {
    switch (icon) {
      case 'cash_in':
        return Icons.arrow_downward_rounded;
      case 'cash_out':
        return Icons.arrow_upward_rounded;
      case 'add_money':
        return Icons.add_card_outlined;
      case 'send_money':
        return Icons.send_outlined;
      case 'mobile':
        return Icons.smartphone_outlined;
      case 'mrt':
        return Icons.train_outlined;
      case 'payment':
        return Icons.payment_outlined;
      case 'card':
        return Icons.credit_card_outlined;
      default:
        return Icons.circle_outlined;
    }
  }
}

// ─── pay bill section ─────────────────────────────────────────────────────────

class _PayBillSection extends StatelessWidget {
  final HomeController controller;

  const _PayBillSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          Text(AppStrings.payBill, style: AppTypography.headlineSmall),

          const SizedBox(height: AppSpacing.lg),

          // bill items — 2 rows of 4
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 0.85,
            children: controller.billServices
                .take(8)
                .map((item) => _BillGridItem(
              item: item,
              onTap: () => controller.onBillTap(item),
            ))
                .toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // see more button
          _SeeMoreButton(
            label: AppStrings.seeMore,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// bill grid item
class _BillGridItem extends StatelessWidget {
  final BillItem item;
  final VoidCallback onTap;

  const _BillGridItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              _billIcon(item.icon),
              color: AppColors.primary,
              size: AppSpacing.iconLg,
            ),
          ),

          const SizedBox(height: AppSpacing.xs + 2),

          // bill label
          Text(
            item.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  IconData _billIcon(String icon) {
    switch (icon) {
      case 'electricity':
        return Icons.electrical_services_outlined;
      case 'gas':
        return Icons.local_fire_department_outlined;
      case 'water':
        return Icons.water_drop_outlined;
      case 'internet':
        return Icons.wifi_outlined;
      case 'telephone':
        return Icons.phone_outlined;
      case 'credit_card':
        return Icons.credit_card_outlined;
      case 'govt':
        return Icons.account_balance_outlined;
      case 'cable':
        return Icons.cast_outlined;
      default:
        return Icons.circle_outlined;
    }
  }
}

// ─── remittance section ───────────────────────────────────────────────────────

class _RemittanceSection extends StatelessWidget {
  final HomeController controller;

  const _RemittanceSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section title
          Text(AppStrings.remittance, style: AppTypography.headlineSmall),

          const SizedBox(height: AppSpacing.lg),

          // horizontal scrollable remittance partner logos
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.remittanceItems.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, index) {
                final item = controller.remittanceItems[index];
                return _RemittanceCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// single remittance partner card
class _RemittanceCard extends StatelessWidget {
  final RemittanceItem item;

  const _RemittanceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // partner icon placeholder
          Icon(
            _remittanceIcon(item.logo),
            color: AppColors.primary,
            size: AppSpacing.iconLg,
          ),

          const SizedBox(height: AppSpacing.xs),

          // partner name
          Text(
            item.label,
            style: AppTypography.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _remittanceIcon(String logo) {
    switch (logo) {
      case 'paypal':
        return Icons.account_balance_wallet_outlined;
      case 'payoneer':
        return Icons.payments_outlined;
      case 'wise':
        return Icons.currency_exchange_outlined;
      case 'wind':
        return Icons.air_outlined;
      default:
        return Icons.monetization_on_outlined;
    }
  }
}

// ─── see more button ──────────────────────────────────────────────────────────

class _SeeMoreButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SeeMoreButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}