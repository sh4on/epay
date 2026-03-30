import 'package:get/get.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/screens/splash_screen.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/screens/onboarding_screen.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/screens/signup_welcome_screen.dart';
import '../modules/auth/screens/signup_form_screen.dart';
import '../modules/auth/screens/otp_screen.dart';
import '../modules/auth/screens/login_screen.dart';
import '../modules/base/bindings/base_binding.dart';
import '../modules/base/screens/base_screen.dart';
import '../modules/cash_out/bindings/cash_out_binding.dart';
import '../modules/cash_out/screens/cash_out_screen.dart';
import '../modules/cash_out/screens/confirm_cash_out_screen.dart';
import '../modules/send_money/bindings/send_money_binding.dart';
import '../modules/send_money/screens/send_money_screen.dart';
import '../modules/send_money/screens/confirm_send_money_screen.dart';
import '../modules/add_money/bindings/add_money_binding.dart';
import '../modules/add_money/screens/add_money_screen.dart';
import 'app_pages.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    // splash
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // onboarding
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),

    // auth — signup welcome
    GetPage(
      name: AppRoutes.signupWelcome,
      page: () => const SignupWelcomeScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),

    // auth — signup form
    GetPage(
      name: AppRoutes.signupForm,
      page: () => const SignupFormScreen(),
      binding: AuthBinding(),
    ),

    // auth — otp
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
    ),

    // auth — login
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),

    // base shell (drawer + bottom nav)
    GetPage(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
      binding: BaseBinding(),
      transition: Transition.fadeIn,
    ),

    // cash out
    GetPage(
      name: AppRoutes.cashOut,
      page: () => const CashOutScreen(),
      binding: CashOutBinding(),
    ),

    // confirm cash out
    GetPage(
      name: AppRoutes.confirmCashOut,
      page: () => const ConfirmCashOutScreen(),
      binding: CashOutBinding(),
    ),

    // send money
    GetPage(
      name: AppRoutes.sendMoney,
      page: () => const SendMoneyScreen(),
      binding: SendMoneyBinding(),
    ),

    // confirm send money
    GetPage(
      name: AppRoutes.confirmSendMoney,
      page: () => const ConfirmSendMoneyScreen(),
      binding: SendMoneyBinding(),
    ),

    // add money
    GetPage(
      name: AppRoutes.addMoney,
      page: () => const AddMoneyScreen(),
      binding: AddMoneyBinding(),
    ),
  ];
}