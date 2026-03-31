import 'package:epay/modules/base/screens/widgets/app_bottom_navbar.dart';
import 'package:epay/modules/base/screens/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/base_controller.dart';
import '../../home/screens/home_screen.dart';
class BaseScreen extends GetView<BaseController> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: AppDrawer(controller: controller),
      extendBody: true,
      body: Obx(() {
        switch (controller.activeIndex.value) {
          case 1:
            return const QrScanPlaceholder();
          case 2:
            return const InboxPlaceholder();
          default:
            return const HomeScreen();
        }
      }),
      bottomNavigationBar: SafeArea(child: AppBottomNavBar(controller: controller)),
    );
  }
}