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

class Assets {
  const Assets._();

  static const $AssetsAuthGen auth = $AssetsAuthGen();
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
