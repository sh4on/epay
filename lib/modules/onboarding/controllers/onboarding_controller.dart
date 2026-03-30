import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  // page controller for pageview
  final PageController pageController = PageController();

  // current page index
  final RxInt currentPage = 0.obs;

  // total number of onboarding pages
  static const int totalPages = 3;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // called when page changes via swipe
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // next button tap
  void onNextTap() {
    if (currentPage.value < totalPages - 1) {
      // go to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      // last page — go to signup welcome
      _navigateToAuth();
    }
  }

  // skip button tap
  void onSkipTap() {
    _navigateToAuth();
  }

  // navigate to auth flow
  void _navigateToAuth() {
    Get.offAllNamed(AppRoutes.signupWelcome);
  }
}