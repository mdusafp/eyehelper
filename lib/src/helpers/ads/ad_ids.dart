import 'dart:io';

import 'package:flutter/foundation.dart';

/// AdMob identifiers.
///
/// Release builds (an Xcode Archive included) use the real units; debug and
/// profile builds use Google's sample units, so nobody taps live ads while
/// developing. `--dart-define=ADS_PROD=true|false` overrides either way.
///
/// Android is deliberately unsupported: the Play listing is gone and the
/// rewrite will ship under a new application id with its own AdMob app.
class AdIds {
  AdIds._();

  static const bool _useProd = bool.fromEnvironment('ADS_PROD', defaultValue: kReleaseMode);

  // AdMob app "Eye Helper" (iOS), app id ca-app-pub-9224189586166998~5290189348 —
  // the same value sits in ios/Runner/Info.plist under GADApplicationIdentifier.
  static const String _prodBanner = 'ca-app-pub-9224189586166998/3409211598';
  static const String _prodInterstitial = 'ca-app-pub-9224189586166998/8549857632';
  static const String _prodNative = 'ca-app-pub-9224189586166998/6084396266';

  static const String _testBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const String _testInterstitial = 'ca-app-pub-3940256099942544/4411468910';
  static const String _testNative = 'ca-app-pub-3940256099942544/3986624511';

  static bool get isSupportedPlatform => Platform.isIOS;

  static String get banner => _pick(_prodBanner, _testBanner);

  static String get interstitial => _pick(_prodInterstitial, _testInterstitial);

  /// Native advanced — rendered as a row, not a picture.
  static String get native => _pick(_prodNative, _testNative);

  static String _pick(String prod, String test) => _useProd && prod.isNotEmpty ? prod : test;
}
