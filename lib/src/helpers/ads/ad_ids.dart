import 'dart:io';

/// AdMob identifiers.
///
/// Google's public sample units are used by default, so the integration runs
/// without an AdMob account. Build with `--dart-define=ADS_PROD=true` once the
/// real ids below are filled in.
///
/// Android is deliberately unsupported: the Play listing is gone and the
/// rewrite will ship under a new application id with its own AdMob app.
class AdIds {
  AdIds._();

  static const bool _useProd = bool.fromEnvironment('ADS_PROD');

  // TODO: fill in after registering com.fluttergods.eyehelperapp in AdMob.
  // The matching app id lives in ios/Runner/Info.plist under
  // GADApplicationIdentifier and still holds Google's sample value — it has to
  // be swapped there too, or the release ships against the test account.
  static const String _prodBanner = '';
  static const String _prodInterstitial = '';

  static const String _testBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const String _testInterstitial = 'ca-app-pub-3940256099942544/4411468910';

  static bool get isSupportedPlatform => Platform.isIOS;

  static String get banner => _pick(_prodBanner, _testBanner);

  static String get interstitial => _pick(_prodInterstitial, _testInterstitial);

  static String _pick(String prod, String test) => _useProd && prod.isNotEmpty ? prod : test;
}
