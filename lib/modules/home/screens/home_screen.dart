import 'package:epay/modules/home/screens/widgets/balance_card.dart';
import 'package:epay/modules/home/screens/widgets/home_app_bar.dart';
import 'package:epay/modules/home/screens/widgets/pay_bill_section.dart';
import 'package:epay/modules/home/screens/widgets/remittance_section.dart';
import 'package:epay/modules/home/screens/widgets/service_grid.dart';
import 'package:epay/shared/common_widgets/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../base/controllers/base_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/common_widgets/loading_state_widget.dart';
import '../../../shared/common_widgets/error_state_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final baseController = Get.find<BaseController>();

    return DoubleTapToExit(
      child: Scaffold(
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
                child: HomeAppBar(baseController: baseController),
              ),

              // balance card
              SliverToBoxAdapter(
                child: BalanceCard(baseController: baseController),
              ),

              // white content area
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.xs),

                      // services grid
                      ServicesGrid(controller: homeController),

                      const SizedBox(height: AppSpacing.lg),

                      // pay bill section
                      PayBillSection(controller: homeController),

                      const SizedBox(height: AppSpacing.lg),

                      // remittance section
                      RemittanceSection(controller: homeController),

                      const SizedBox(height: kToolbarHeight * 3),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}