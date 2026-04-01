# ePay — Mobile Financial Services App

> A professional-grade Flutter mobile application for digital wallet and financial transactions.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Asset Structure](#asset-structure)
- [Architecture](#architecture)
- [Features](#features)
- [Screens](#screens)
- [Design System](#design-system)
- [State Management](#state-management)
- [Networking](#networking)
- [Navigation](#navigation)
- [Reusable Components](#reusable-components)
- [Extensions & Mixins](#extensions--mixins)
- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Replacing Mock APIs](#replacing-mock-apis)
- [Asset Setup](#asset-setup)
- [Code Conventions](#code-conventions)
- [Dependencies](#dependencies)

---

## Overview

**ePay** is a Bangladeshi mobile financial services (MFS) application similar to bKash or Nagad. It allows users to manage their digital wallet — send money, cash out via agents or ATMs, add money from banks or cards, pay utility bills, and access remittance services.

---

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Flutter (Dart) |
| State Management | GetX (`^4.6.6`) |
| Networking | Dio (`^5.4.0`) |
| Image Caching | CachedNetworkImage (`^3.3.1`) |
| Local Storage | SharedPreferences (`^2.2.2`) |
| SVG Rendering | flutter_svg (`^2.0.9`) |
| Asset Generation | flutter_gen (`^5.4.0`) |
| Theme | Light mode only via `ThemeData` |
| Navigation | GetX named routes |
| Minimum SDK | Android 5.0 (API 21) / iOS 12 |

---

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # all color constants
│   │   ├── app_strings.dart        # all string constants
│   │   ├── app_typography.dart     # all text styles
│   │   └── app_spacing.dart        # spacing, radius, button height constants
│   ├── services/
│   │   └── network_service.dart    # singleton Dio HTTP client + NetworkResult<T>
│   ├── theme/
│   │   └── app_theme.dart          # centralized ThemeData (light mode only)
│   └── utils/
│       ├── extensions/
│       │   ├── context_extensions.dart   # screen size, theme, snackbar shortcuts
│       │   └── string_extensions.dart    # phone validation, PIN validation, masking
│       └── mixins/
│           └── validation_mixin.dart     # reusable form validation logic
│
├── data/
│   ├── models/
│   │   ├── user_model.dart          # logged-in user data
│   │   ├── contact_model.dart       # contact for send money / cash out
│   │   ├── bank_model.dart          # partner bank for ATM cash out
│   │   └── transaction_model.dart   # transaction history record
│   ├── providers/
│   │   ├── auth_provider.dart       # auth API calls (login, signup, OTP)
│   │   ├── home_provider.dart       # home screen API calls (services, bills)
│   │   ├── cash_out_provider.dart   # cash out API calls (contacts, banks, process)
│   │   ├── send_money_provider.dart # send money API calls (contacts, process)
│   │   └── add_money_provider.dart  # add money API calls (sources, process)
│   └── repositories/
│       ├── auth_repository.dart
│       ├── home_repository.dart
│       ├── cash_out_repository.dart
│       ├── send_money_repository.dart
│       └── add_money_repository.dart
│
├── modules/
│   ├── splash/
│   │   ├── bindings/splash_binding.dart
│   │   ├── controllers/splash_controller.dart
│   │   └── screens/splash_screen.dart
│   ├── onboarding/
│   │   ├── bindings/onboarding_binding.dart
│   │   ├── controllers/onboarding_controller.dart
│   │   └── screens/onboarding_screen.dart
│   ├── auth/
│   │   ├── bindings/auth_binding.dart
│   │   ├── controllers/
│   │   │   ├── login_controller.dart
│   │   │   ├── signup_controller.dart
│   │   │   └── otp_controller.dart
│   │   └── screens/
│   │       ├── signup_welcome_screen.dart
│   │       ├── signup_form_screen.dart
│   │       ├── otp_screen.dart
│   │       └── login_screen.dart
│   ├── base/
│   │   ├── bindings/base_binding.dart
│   │   ├── controllers/base_controller.dart
│   │   └── screens/base_screen.dart
│   ├── home/
│   │   ├── bindings/home_binding.dart
│   │   ├── controllers/home_controller.dart
│   │   └── screens/home_screen.dart
│   ├── cash_out/
│   │   ├── bindings/cash_out_binding.dart
│   │   ├── controllers/cash_out_controller.dart
│   │   └── screens/
│   │       ├── cash_out_screen.dart
│   │       └── confirm_cash_out_screen.dart
│   ├── send_money/
│   │   ├── bindings/send_money_binding.dart
│   │   ├── controllers/send_money_controller.dart
│   │   └── screens/
│   │       ├── send_money_screen.dart
│   │       └── confirm_send_money_screen.dart
│   └── add_money/
│       ├── bindings/add_money_binding.dart
│       ├── controllers/add_money_controller.dart
│       └── screens/add_money_screen.dart
│
├── routes/
│   ├── app_pages.dart     # GetPage list — all route definitions
│   └── app_routes.dart    # named route string constants
│
├── shared/
│   ├── bindings/
│   │   └── initial_binding.dart   # app-level bindings at startup
│   └── common_widgets/
│       ├── app_button.dart                # primary / outlined / disabled button
│       ├── app_text_field.dart            # text field with PIN toggle
│       ├── language_toggle_button.dart    # বাংলা pill badge
│       ├── contact_list_item.dart         # contact row with avatar
│       ├── curved_bottom_nav_bar.dart     # custom curved bottom nav bar
│       ├── success_dialog.dart            # reusable success dialog
│       ├── loading_state_widget.dart      # full-screen loading spinner
│       ├── empty_state_widget.dart        # full-screen empty state
│       ├── error_state_widget.dart        # full-screen error + retry
│       ├── section_header.dart            # bold section title
│       └── contact_book_icon_button.dart  # blue contact book icon
│
├── main.dart      # app entry point, orientation lock
└── my_app.dart    # GetMaterialApp setup with theme and routes
```

---

## Asset Structure

All assets are organized by feature and registered in `pubspec.yaml`:

```
assets/
├── splash/
│   ├── splash_logo.svg           # ePay logo — navy "e" arc + orange dot
│   ├── top_bg_graphic.png        # dark blue blob graphic for top of splash
│   └── bottom_bg_graphic.png     # dark blue blob graphic for bottom of splash
│
├── onboarding/
│   ├── first_onboarding_image.svg    # handshake + shield illustration
│   ├── second_onboarding_image.svg   # card payment illustration
│   └── third_onboarding_image.svg    # secure phone illustration
│
├── auth/
│   ├── fingerprint.svg           # biometric fingerprint icon on login screen
│   └── mobile_image.svg          # phone illustration on sign up welcome screen
│
└── home/
    ├── top_section/              # home header / balance section assets
    ├── add_money/
    │   ├── bank_to_epay.svg      # bank to ekpay tab icon
    │   └── card_to_epay.svg      # card to ekpay tab icon
    ├── cash_out/
    │   ├── agent.svg             # agent tab icon
    │   ├── atm.svg               # atm tab icon
    │   └── success.svg           # cash out success dialog illustration
    ├── pay_bill/
    │   ├── electricity.svg
    │   ├── gas.svg
    │   ├── water.svg
    │   ├── internet.svg
    │   ├── telephone.svg
    │   ├── credit_card.svg
    │   ├── govt_fees.svg
    │   └── cable_network.svg
    ├── remittance/
    │   ├── payoneer.svg
    │   ├── paypal.svg
    │   ├── wind.svg
    │   └── wise.svg
    └── send_money/
        └── sucess.svg            # send money success dialog illustration
```

### flutter_gen Usage

Assets are accessed via the generated `Assets` class — no hardcoded path strings anywhere:

```dart
// splash
Assets.splash.splashLogo.svg()
Assets.splash.topBgGraphic.image(fit: BoxFit.fill)
Assets.splash.bottomBgGraphic.image(fit: BoxFit.fill)

// onboarding illustrations
Assets.onboarding.firstOnboardingImage.svg()
Assets.onboarding.secondOnboardingImage.svg()
Assets.onboarding.thirdOnboardingImage.svg()

// auth
Assets.auth.fingerprint.svg()
Assets.auth.mobileImage.svg()

// pay bill icons
Assets.home.payBill.electricity.svg(colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn))
Assets.home.payBill.gas.svg(colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn))

// remittance logos
Assets.home.remittance.payoneer.svg()
Assets.home.remittance.paypal.svg()

// cash out
Assets.home.cashOut.agent.svg()
Assets.home.cashOut.atm.svg()
Assets.home.cashOut.success.svg()

// send money success
Assets.home.sendMoney.sucess.svg()

// add money tabs
Assets.home.addMoney.bankToEpay.svg()
Assets.home.addMoney.cardToEpay.svg()
```

---

## Architecture

This project follows a **layered clean architecture** pattern:

```
┌─────────────────────────────────┐
│           UI Layer              │  Screens + Widgets
│   (modules/*/screens/)          │  Pure Flutter widgets, no business logic
├─────────────────────────────────┤
│        Controller Layer         │  GetxController per module
│   (modules/*/controllers/)      │  Handles state, user events, navigation
├─────────────────────────────────┤
│        Repository Layer         │  Mediates between controller and provider
│   (data/repositories/)          │  Single source of truth for data access
├─────────────────────────────────┤
│         Provider Layer          │  Raw API calls via NetworkService
│   (data/providers/)             │  All mock endpoints — easily replaceable
├─────────────────────────────────┤
│          Core Layer             │  Constants, theme, services, utils
│   (core/)                       │  No dependencies on other layers
└─────────────────────────────────┘
```

### Key Principles Applied

- **Separation of Concerns** — each layer has a single responsibility
- **Dependency Injection** — via GetX bindings; controllers receive repositories through constructors
- **Repository Pattern** — controllers never call providers directly
- **Mock-First API Design** — all providers return mock data; real endpoints are drop-in replacements
- **Single Responsibility** — each file does exactly one thing

---

## Features

### ✅ Authentication
- Sign Up Welcome screen with animated illustration and floating colored dots
- Sign Up with phone number + 4-digit PIN + confirm PIN validation
- OTP verification with 4-box input, auto-focus between boxes, 30-second resend countdown
- Login with phone number + 6-digit PIN + biometric fingerprint placeholder
- Language toggle (English / বাংলা) on every auth screen

### ✅ Home Dashboard
- Personalized greeting with user avatar and name
- Real-time balance display with show/hide toggle
- Points badge with trophy icon (e.g. 1,972 Points)
- 8-item services grid with "See More / See Less" toggle
- Pay Bill section — 8 utility categories (Electricity, Gas, Water, Internet, Telephone, Credit Card, Govt. Fees, Cable Network)
- Remittance partners horizontal scroll (Payoneer, PayPal, Wind, Wise)

### ✅ Cash Out
- **Agent Tab** — input agent number manually, QR code scan button, recent contacts, all contacts
- **ATM Tab** — available balance display, live bank search, partner bank cards with branch info
- Confirm screen — agent number display, large centered amount, available balance, disabled/enabled confirm button based on input
- Success dialog — orange circular checkmark with withdrawal amount highlighted in gold

### ✅ Send Money
- Search by name or number input field with contact book icon
- Recent contacts and All contacts sections
- Confirm screen — contact number, large centered amount, real-time remaining balance
- Success dialog — two-hands flying coins custom `CustomPainter` illustration with amount highlighted

### ✅ Add Money
- **Bank to Ekpay Tab** — Bank Account + Internet Banking radio options
- **Card to Ekpay Tab** — Debit Card + Credit Card radio options
- Animated radio selection cards with border highlight
- Custom SVG tab icons (bank with arrow, card with arrows)

### ✅ Navigation
- Custom curved bottom navigation bar with floating QR Scan button using `CustomPaint`
- Side drawer with 12 menu items (Home, Profile, Statements, Limits, Coupons, Points, Information Update, Settings, Nominee Update, Support, Refer ekPay App, Logout)
- Points badge in drawer header

### ✅ UX Polish
- Loading, empty, and error states on every data-driven screen
- Smooth animated page transitions between routes
- `AnimatedContainer` for all state-driven style changes
- `AnimatedSwitcher` for icon swaps on active tab change
- Portrait-only orientation lock
- Consistent corner radii — 30px buttons, 12px fields and cards, 16px dialogs

---

## Screens

| # | Screen | Route | Module |
|---|--------|-------|--------|
| 1 | Splash | `/splash` | `splash` |
| 2 | Onboarding | `/onboarding` | `onboarding` |
| 3 | Sign Up Welcome | `/signup-welcome` | `auth` |
| 4 | Sign Up Form | `/signup-form` | `auth` |
| 5 | OTP Confirmation | `/otp` | `auth` |
| 6 | Login | `/login` | `auth` |
| 7 | Base Shell (Drawer + Nav) | `/base` | `base` |
| 8 | Home | nested in base | `home` |
| 9 | Cash Out | `/cash-out` | `cash_out` |
| 10 | Confirm Cash Out | `/confirm-cash-out` | `cash_out` |
| 11 | Send Money | `/send-money` | `send_money` |
| 12 | Confirm Send Money | `/confirm-send-money` | `send_money` |
| 13 | Add Money | `/add-money` | `add_money` |

---

## Design System

All design tokens are centralized in `lib/core/constants/`:

### Colors (`AppColors`)
```dart
AppColors.primary        // #1A2E6C — dark navy blue (brand)
AppColors.accent         // #F5A623 — orange/gold (highlights, points, amounts)
AppColors.background     // #FFFFFF — white
AppColors.surface        // #F0F2F5 — light grey (fields, icon containers)
AppColors.textPrimary    // #1A1A2E — near black
AppColors.textSecondary  // #8A8A9A — grey
AppColors.error          // #E53935 — red
AppColors.success        // #4CAF50 — green
AppColors.otpBoxFilled   // #FDE8C0 — warm peach (OTP input boxes)
```

### Typography (`AppTypography`)
```dart
AppTypography.displayLarge    // 28px bold
AppTypography.headlineMedium  // 20px bold
AppTypography.titleLarge      // 16px semibold
AppTypography.bodyMedium      // 14px regular
AppTypography.labelLarge      // 16px semibold white (buttons)
AppTypography.balanceAmount   // 26px bold (home balance display)
AppTypography.amountDisplay   // 32px semibold (confirm screens)
AppTypography.link            // 14px semibold primary color (tappable links)
```

### Spacing (`AppSpacing`)
```dart
AppSpacing.xs     // 4px
AppSpacing.sm     // 8px
AppSpacing.md     // 12px
AppSpacing.lg     // 16px
AppSpacing.xl     // 20px
AppSpacing.xxl    // 24px
AppSpacing.xxxl   // 32px

AppSpacing.screenPadding  // 20px — consistent horizontal screen padding
AppSpacing.buttonHeight   // 54px — height of all primary buttons
AppSpacing.radiusButton   // 30px — pill-shaped buttons
AppSpacing.radiusMd       // 12px — cards and text fields
AppSpacing.radiusLg       // 16px — dialog corners
```

---

## State Management

GetX is used throughout with the following conventions:

### Observable Pattern
```dart
// in controller
Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());
RxList<ContactModel> contacts = <ContactModel>[].obs;
final RxBool isLoading = false.obs;
final RxString selectedPhone = ''.obs;

// in screen — Obx reads .value at the exact point of use
Obx(() => Text(controller.selectedPhone.value))
```

### Obx Placement Rule
Every `.value` read **must be directly inside** its own `Obx` closure. Observables are read at the lowest possible widget level to minimise unnecessary rebuilds.

```dart
// ✅ correct — .value read directly inside Obx scope
Obx(() => Text(controller.name.value))

// ❌ wrong — .value hidden inside child widget, outside Obx tracking scope
Obx(() => _ChildWidget(controller: controller))
// causes "improper use of GetX" warning if _ChildWidget reads .value internally
```

### Controller Lifecycle
- Controllers registered via `Bindings` — one binding class per module
- `Get.lazyPut` so controllers are created only when their screen is first visited
- Controllers automatically disposed when their screen is removed from the stack
- `onClose()` overridden to dispose `TextEditingController`, `FocusNode`, and `Timer`

---

## Networking

### NetworkResult\<T\>
All API calls return a typed `NetworkResult<T>` wrapper:

```dart
NetworkResult.success(data, statusCode, message)  // isSuccess = true
NetworkResult.failure(statusCode, message)         // isSuccess = false
```

### NetworkService
A singleton Dio client with centralized request/response logging:

```dart
final result = await NetworkService.instance.get(endpoint);
final result = await NetworkService.instance.post(endpoint, body);
```

### Mock API Pattern
All providers use structured mock data that mirrors the expected real API response shape. Replacing them requires changes in **one file only** — the provider.

```dart
// current mock
Future<NetworkResult<dynamic>> login({required String phone, required String pin}) async {
  return NetworkResult.success({'id': '1', 'name': 'RAHUL', ...}, 200, 'Success');
}

// real endpoint — zero changes to controller or repository
Future<NetworkResult<dynamic>> login({required String phone, required String pin}) async {
  return NetworkService.instance.post('$_base/auth/login', {'phone': phone, 'pin': pin});
}
```

---

## Navigation

Named routes via GetX:

```dart
Get.toNamed(AppRoutes.cashOut);                                    // push
Get.toNamed(AppRoutes.otp, arguments: {'phone': phone});           // push with args
Get.offAllNamed(AppRoutes.base, arguments: user);                  // replace stack
Get.back();                                                        // pop
Get.until((route) => route.settings.name == AppRoutes.base);      // pop to route
```

All route strings are defined in `AppRoutes` and all `GetPage` definitions live in `AppPages.pages`.

---

## Reusable Components

### AppButton
```dart
AppButton(label: 'Confirm', onPressed: onTap)           // primary — navy blue
AppButton.outlined(label: 'Cancel', onPressed: onTap)   // outlined
AppButton.disabled(label: 'Confirm')                    // grey, no tap
```

### AppTextField
```dart
AppTextField(
  label: 'Phone Number',
  hint: '01701*****4',
  controller: controller.phoneController,
  isRequired: true,       // shows red asterisk next to label
  isPassword: true,       // shows show/hide eye icon toggle
  keyboardType: TextInputType.phone,
  validator: controller.validatePhone,
)
```

### State Widgets
```dart
LoadingStateWidget(loadingMessage: 'Loading contacts...')  // spinner + message
EmptyStateWidget(message: 'No contacts found!')            // icon + message
ErrorStateWidget(onRetry: controller.fetchData)            // icon + retry button
```

### Curved Bottom Navigation Bar
```dart
CurvedBottomNavBar(
  currentIndex: controller.activeIndex.value,
  onTap: controller.onTabChanged,
)
```
Drawn with `CustomPaint` to preserve shadows on the floating QR button — `ClipPath` would clip them away.

---

## Extensions & Mixins

### String Extensions
```dart
'01701234567'.isValidBdPhone   // validates BD phone number format
'1234'.isValid4DigitPin        // validates 4-digit PIN
'123456'.isValid6DigitPin      // validates 6-digit PIN
'01701234567'.maskedPhone      // → '017*****67'
'5000'.currencyFormat          // → 'TK: 5000'
```

### Context Extensions
```dart
context.screenWidth                          // MediaQuery screen width
context.screenHeight                         // MediaQuery screen height
context.theme                                // Theme.of(context)
context.showSnack('Done')                    // floating success snackbar
context.showSnack('Failed', isError: true)   // floating error snackbar
```

### Validation Mixin
```dart
class LoginController extends GetxController with ValidationMixin {
  // inherits: validatePhone(), validateSixDigitPin(),
  //           validateFourDigitPin(), validateConfirmPin()
}
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code with Flutter plugin
- Android emulator / iOS simulator or a physical device

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/your-username/epay-flutter.git
cd epay-flutter
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Generate asset references**
```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates the type-safe `Assets` class — no hardcoded asset path strings anywhere in the codebase.

---

## Running the App

```bash
flutter run                        # debug mode
flutter run --release              # release mode
flutter run -d emulator-5554       # specific device
flutter build apk --release        # build release APK
flutter build ios --release        # build iOS
```

---

## Replacing Mock APIs

**Step 1** — Set the real base URL in the provider file:
```dart
static const String _base = 'https://your-real-api.com/api/v1';
```

**Step 2** — Replace the mock return with a real Dio call:
```dart
// before (mock)
Future<NetworkResult<dynamic>> login({...}) async {
  return NetworkResult.success({'name': 'RAHUL', ...}, 200, 'Success');
}

// after (real)
Future<NetworkResult<dynamic>> login({...}) async {
  return NetworkService.instance.post('$_base/auth/login', {
    'phone': phone, 'pin': pin,
  });
}
```

**Step 3** — Update the model `fromJson` if the real API response shape differs.

✅ Controllers, repositories, and screens require **zero changes**.

---

## Asset Setup

### pubspec.yaml
```yaml
flutter:
  assets:
    - assets/splash/
    - assets/onboarding/
    - assets/auth/
    - assets/home/top_section/
    - assets/home/pay_bill/
    - assets/home/remittance/
    - assets/home/cash_out/
    - assets/home/add_money/
    - assets/home/send_money/

flutter_gen:
  output: lib/gen/
  line_length: 80

dev_dependencies:
  flutter_gen_runner: ^5.4.0
  build_runner: ^2.4.8
```

---

## Code Conventions

| Convention | Example |
|-----------|---------|
| All inline comments in lowercase | `// balance visibility toggle` |
| Private widgets prefixed with `_` | `class _BalanceCard` |
| All constants in dedicated classes | `AppColors.primary`, `AppStrings.login` |
| One screen per file | `home_screen.dart` |
| Screen-specific sub-widgets in the same file | `_HomeAppBar`, `_BalanceCard` in `home_screen.dart` |
| Cross-screen widgets in `common_widgets/` | `AppButton`, `LoadingStateWidget` |
| Controllers receive repositories via constructor | `HomeController(this._repository)` |
| Observables named descriptively | `isBalanceVisible`, `selectedPhone` |
| Each `Obx` reads only the `.value` it directly needs | No child widget hides `.value` from parent `Obx` |
| No hardcoded asset path strings | Always use generated `Assets.xxx` class |
| No hardcoded color, size, or text literals | Always use `AppColors`, `AppSpacing`, `AppTypography`, `AppStrings` |

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                    # state management, navigation, dependency injection
  dio: ^5.4.0                    # HTTP client with interceptors and response logging
  cached_network_image: ^3.3.1   # network image caching with memCacheWidth/Height
  shared_preferences: ^2.2.2     # lightweight local key-value storage
  pinput: ^3.1.1                 # OTP and PIN input widget
  flutter_svg: ^2.0.9            # SVG asset rendering

dev_dependencies:
  flutter_lints: ^3.0.0          # dart analysis and lint rules
  flutter_gen_runner: ^5.4.0     # generates type-safe Assets class from asset paths
  build_runner: ^2.4.8           # code generation runner
```

---

*Built with Flutter & GetX*