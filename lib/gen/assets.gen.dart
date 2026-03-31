// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAuthGen {
  const $AssetsAuthGen();

  /// File path: assets/auth/fingerprint.svg
  String get fingerprint => 'assets/auth/fingerprint.svg';

  /// File path: assets/auth/mobile_image.svg
  String get mobileImage => 'assets/auth/mobile_image.svg';

  /// List of all assets
  List<String> get values => [fingerprint, mobileImage];
}

class $AssetsHomeGen {
  const $AssetsHomeGen();

  /// Directory path: assets/home/pay_bill
  $AssetsHomePayBillGen get payBill => const $AssetsHomePayBillGen();

  /// Directory path: assets/home/remittance
  $AssetsHomeRemittanceGen get remittance => const $AssetsHomeRemittanceGen();

  /// Directory path: assets/home/top_section
  $AssetsHomeTopSectionGen get topSection => const $AssetsHomeTopSectionGen();
}

class $AssetsOnboardingGen {
  const $AssetsOnboardingGen();

  /// File path: assets/onboarding/first_onboarding_image.svg
  String get firstOnboardingImage =>
      'assets/onboarding/first_onboarding_image.svg';

  /// File path: assets/onboarding/second_onboarding_image.svg
  String get secondOnboardingImage =>
      'assets/onboarding/second_onboarding_image.svg';

  /// File path: assets/onboarding/third_onboarding_image.svg
  String get thirdOnboardingImage =>
      'assets/onboarding/third_onboarding_image.svg';

  /// List of all assets
  List<String> get values => [
    firstOnboardingImage,
    secondOnboardingImage,
    thirdOnboardingImage,
  ];
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/bottom_bg_graphic.png
  AssetGenImage get bottomBgGraphic =>
      const AssetGenImage('assets/splash/bottom_bg_graphic.png');

  /// File path: assets/splash/splash_logo.svg
  String get splashLogo => 'assets/splash/splash_logo.svg';

  /// File path: assets/splash/top_bg_graphic.png
  AssetGenImage get topBgGraphic =>
      const AssetGenImage('assets/splash/top_bg_graphic.png');

  /// List of all assets
  List<dynamic> get values => [bottomBgGraphic, splashLogo, topBgGraphic];
}

class $AssetsHomePayBillGen {
  const $AssetsHomePayBillGen();

  /// File path: assets/home/pay_bill/cable_network.svg
  String get cableNetwork => 'assets/home/pay_bill/cable_network.svg';

  /// File path: assets/home/pay_bill/credit_card.svg
  String get creditCard => 'assets/home/pay_bill/credit_card.svg';

  /// File path: assets/home/pay_bill/electricity.svg
  String get electricity => 'assets/home/pay_bill/electricity.svg';

  /// File path: assets/home/pay_bill/gas.svg
  String get gas => 'assets/home/pay_bill/gas.svg';

  /// File path: assets/home/pay_bill/govt_fees.svg
  String get govtFees => 'assets/home/pay_bill/govt_fees.svg';

  /// File path: assets/home/pay_bill/internet.svg
  String get internet => 'assets/home/pay_bill/internet.svg';

  /// File path: assets/home/pay_bill/telephone.svg
  String get telephone => 'assets/home/pay_bill/telephone.svg';

  /// File path: assets/home/pay_bill/water.svg
  String get water => 'assets/home/pay_bill/water.svg';

  /// List of all assets
  List<String> get values => [
    cableNetwork,
    creditCard,
    electricity,
    gas,
    govtFees,
    internet,
    telephone,
    water,
  ];
}

class $AssetsHomeRemittanceGen {
  const $AssetsHomeRemittanceGen();

  /// File path: assets/home/remittance/payoneer.svg
  String get payoneer => 'assets/home/remittance/payoneer.svg';

  /// File path: assets/home/remittance/paypal.svg
  String get paypal => 'assets/home/remittance/paypal.svg';

  /// File path: assets/home/remittance/wind.svg
  String get wind => 'assets/home/remittance/wind.svg';

  /// File path: assets/home/remittance/wise.svg
  String get wise => 'assets/home/remittance/wise.svg';

  /// List of all assets
  List<String> get values => [payoneer, paypal, wind, wise];
}

class $AssetsHomeTopSectionGen {
  const $AssetsHomeTopSectionGen();

  /// File path: assets/home/top_section/add_mone.svg
  String get addMone => 'assets/home/top_section/add_mone.svg';

  /// File path: assets/home/top_section/cach_in.svg
  String get cachIn => 'assets/home/top_section/cach_in.svg';

  /// File path: assets/home/top_section/cach_out.svg
  String get cachOut => 'assets/home/top_section/cach_out.svg';

  /// File path: assets/home/top_section/express_card_recharge.svg
  String get expressCardRecharge =>
      'assets/home/top_section/express_card_recharge.svg';

  /// File path: assets/home/top_section/make_payment.svg
  String get makePayment => 'assets/home/top_section/make_payment.svg';

  /// File path: assets/home/top_section/mobile_recharge.svg
  String get mobileRecharge => 'assets/home/top_section/mobile_recharge.svg';

  /// File path: assets/home/top_section/mrt_recharge.svg
  String get mrtRecharge => 'assets/home/top_section/mrt_recharge.svg';

  /// File path: assets/home/top_section/send_money.svg
  String get sendMoney => 'assets/home/top_section/send_money.svg';

  /// List of all assets
  List<String> get values => [
    addMone,
    cachIn,
    cachOut,
    expressCardRecharge,
    makePayment,
    mobileRecharge,
    mrtRecharge,
    sendMoney,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsAuthGen auth = $AssetsAuthGen();
  static const $AssetsHomeGen home = $AssetsHomeGen();
  static const $AssetsOnboardingGen onboarding = $AssetsOnboardingGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
