import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:eyehelper/src/helpers/ads/ad_ids.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Owns the Mobile Ads SDK lifecycle: consent, initialization, and the
/// interstitial shown between trainings.
class AdsService {
  static final AdsService _singleton = AdsService._internal();

  factory AdsService() => _singleton;

  AdsService._internal();

  /// Kill switch. `--dart-define=ADS_DISABLED=true` builds the app ad-free;
  /// [disableForSession] does the same at run time, which is where a future
  /// "remove ads" purchase would hook in.
  static const bool _disabledAtBuild = bool.fromEnvironment('ADS_DISABLED');

  static const String _lastInterstitialKey = 'last_interstitial_shown_at';
  static const String _introAcknowledgedKey = 'ads_intro_acknowledged';

  /// The first two launches stay ad-free, so the app gets to make its case
  /// before it asks anything of the user.
  static const int _adFreeLaunches = 2;

  /// Minimum gap between two interstitials.
  static const Duration _interstitialCooldown = Duration(minutes: 3);

  /// After a failed banner load a placement waits this long before asking
  /// again, so a slot with no fill does not hammer AdMob on every tab switch.
  static const Duration _bannerRetryDelay = Duration(seconds: 30);

  bool _disabledAtRuntime = false;
  bool _initialized = false;
  bool _canRequestAds = false;

  /// Flips to true once the SDK is up and may serve; banners that were built
  /// before that listen and load themselves when it happens.
  final ValueNotifier<bool> ready = ValueNotifier(false);
  // Banners are loaded once per placement and kept for the session; the tab
  // that shows them can come and go without a new request each time.
  final Map<String, BannerAd> _banners = {};
  final Map<String, Future<BannerAd?>> _bannerLoads = {};
  final Map<String, DateTime> _bannerFailedAt = {};

  // Native ads are cached the same way; Google renders them with its small
  // template, styled below to sit among the app's cards.
  final Map<String, NativeAd> _natives = {};
  final Map<String, Future<NativeAd?>> _nativeLoads = {};
  final Map<String, DateTime> _nativeFailedAt = {};
  InterstitialAd? _interstitial;
  bool _interstitialLoading = false;

  bool get isEnabled => !_disabledAtBuild && !_disabledAtRuntime && AdIds.isSupportedPlatform;

  /// True once the SDK is up and consent allows ad requests.
  bool get canShowAds => isEnabled && _initialized && _canRequestAds;

  void disableForSession() {
    _disabledAtRuntime = true;
    _interstitial?.dispose();
    _interstitial = null;
    for (final ad in _banners.values) {
      ad.dispose();
    }
    _banners.clear();
    for (final ad in _natives.values) {
      ad.dispose();
    }
    _natives.clear();
  }

  /// Whether the user has already been told that ads are coming.
  bool get introAcknowledged {
    final prefs = FastPreferences();
    return prefs.isInited && (prefs.prefs.getBool(_introAcknowledgedKey) ?? false);
  }

  /// True once this launch is past the ad-free grace period and the user still
  /// has not seen the explanation.
  bool get shouldIntroduceAds {
    final prefs = FastPreferences();
    if (!isEnabled || !prefs.isInited || introAcknowledged) {
      return false;
    }
    return (prefs.prefs.getInt(FastPreferences.appOpenCount) ?? 0) > _adFreeLaunches;
  }

  Future<void> markIntroAcknowledged() async {
    await FastPreferences().prefs.setBool(_introAcknowledgedKey, true);
  }

  /// Consent, then ATT, then the SDK. Safe to call more than once; a failed
  /// attempt is simply retried on the next call.
  Future<void> init() async {
    if (!isEnabled || _initialized) {
      return;
    }

    await _updateConsentInfo();
    await ConsentForm.loadAndShowConsentFormIfRequired((formError) {
      if (formError != null) {
        debugPrint('Consent form error: ${formError.message}');
      }
    });
    await _requestTrackingAuthorization();

    _canRequestAds = await ConsentInformation.instance.canRequestAds();
    if (!_canRequestAds) {
      return;
    }

    await MobileAds.instance.initialize();
    _initialized = true;
    ready.value = true;

    // Nobody should meet an interstitial right after their first training, so
    // the cooldown starts counting from the first launch rather than from zero.
    final prefs = FastPreferences();
    if (prefs.isInited && prefs.prefs.getInt(_lastInterstitialKey) == null) {
      await prefs.prefs.setInt(_lastInterstitialKey, DateTime.now().millisecondsSinceEpoch);
    }

    unawaited(_loadInterstitial());
  }

  /// The loaded banner for [placement], loading it on first use. Later calls
  /// hand back the same ad, so a screen that is left and re-entered shows it
  /// again without another request. Null when ads are off, the load failed
  /// recently, or [width] no longer fits the cached size.
  Future<BannerAd?> banner(String placement, {required int width}) {
    if (!canShowAds) {
      debugPrint('Banner "$placement": ads not ready '
          '(enabled=$isEnabled initialized=$_initialized canRequest=$_canRequestAds)');
      return Future.value(null);
    }
    final cached = _banners[placement];
    if (cached != null) {
      if (cached.size.width == width) {
        debugPrint('Banner "$placement": reusing cached ad');
        return Future.value(cached);
      }
      // Rotation or a different frame: the old creative no longer fits.
      cached.dispose();
      _banners.remove(placement);
    }
    final inFlight = _bannerLoads[placement];
    if (inFlight != null) {
      debugPrint('Banner "$placement": load already in flight');
      return inFlight;
    }
    final failedAt = _bannerFailedAt[placement];
    if (failedAt != null && DateTime.now().difference(failedAt) < _bannerRetryDelay) {
      debugPrint('Banner "$placement": last load failed, waiting before retrying');
      return Future.value(null);
    }
    debugPrint('Banner "$placement": loading, width $width');
    // Block body on purpose: Map.remove returns the removed value — this very
    // future — and whenComplete would wait for it, i.e. for itself.
    final load = _loadBanner(placement, width).whenComplete(() {
      _bannerLoads.remove(placement);
    });
    _bannerLoads[placement] = load;
    return load;
  }

  Future<BannerAd?> _loadBanner(String placement, int width) async {
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (size == null) {
      debugPrint('Banner "$placement": no adaptive size for width $width');
      return null;
    }
    final loaded = Completer<BannerAd?>();
    final ad = BannerAd(
      size: size,
      adUnitId: AdIds.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Banner "$placement": loaded ${size.width}x${size.height}');
          _banners[placement] = ad as BannerAd;
          _bannerFailedAt.remove(placement);
          if (!loaded.isCompleted) {
            loaded.complete(ad);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner "$placement" failed to load: $error');
          ad.dispose();
          _bannerFailedAt[placement] = DateTime.now();
          if (!loaded.isCompleted) {
            loaded.complete(null);
          }
        },
      ),
    );
    await ad.load();
    debugPrint('Banner "$placement": load() returned, waiting for callback');
    final result = await loaded.future;
    debugPrint('Banner "$placement": handing ad to widget');
    return result;
  }

  /// The loaded native ad for [placement], loading it on first use and
  /// keeping it for the session — same contract as [banner].
  Future<NativeAd?> native(String placement) {
    if (!canShowAds) {
      debugPrint('Native "$placement": ads not ready');
      return Future.value(null);
    }
    final cached = _natives[placement];
    if (cached != null) {
      return Future.value(cached);
    }
    final inFlight = _nativeLoads[placement];
    if (inFlight != null) {
      return inFlight;
    }
    final failedAt = _nativeFailedAt[placement];
    if (failedAt != null && DateTime.now().difference(failedAt) < _bannerRetryDelay) {
      return Future.value(null);
    }
    debugPrint('Native "$placement": loading');
    final load = _loadNative(placement).whenComplete(() {
      _nativeLoads.remove(placement);
    });
    _nativeLoads[placement] = load;
    return load;
  }

  Future<NativeAd?> _loadNative(String placement) async {
    final loaded = Completer<NativeAd?>();
    final ad = NativeAd(
      adUnitId: AdIds.native,
      request: const AdRequest(),
      // Drawn natively as one compact row by RowNativeAdFactory (iOS).
      factoryId: 'row',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('Native "$placement": loaded');
          _natives[placement] = ad as NativeAd;
          _nativeFailedAt.remove(placement);
          if (!loaded.isCompleted) {
            loaded.complete(ad);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Native "$placement" failed to load: $error');
          ad.dispose();
          _nativeFailedAt[placement] = DateTime.now();
          if (!loaded.isCompleted) {
            loaded.complete(null);
          }
        },
      ),
    );
    await ad.load();
    return loaded.future;
  }

  /// Shows the interstitial when one is ready and the cooldown has passed.
  /// Completes once the ad is dismissed, so the caller can resume its flow.
  Future<void> maybeShowInterstitial() async {
    if (!canShowAds || !_cooldownPassed) {
      unawaited(_loadInterstitial());
      return;
    }

    final ad = _interstitial;
    if (ad == null) {
      unawaited(_loadInterstitial());
      return;
    }
    _interstitial = null;

    final dismissed = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!dismissed.isCompleted) {
          dismissed.complete();
        }
        unawaited(_loadInterstitial());
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Interstitial failed to show: $error');
        ad.dispose();
        if (!dismissed.isCompleted) {
          dismissed.complete();
        }
        unawaited(_loadInterstitial());
      },
    );

    await FastPreferences()
        .prefs
        .setInt(_lastInterstitialKey, DateTime.now().millisecondsSinceEpoch);
    await ad.show();
    return dismissed.future;
  }

  bool get _cooldownPassed {
    final prefs = FastPreferences();
    if (!prefs.isInited) {
      return false;
    }
    final last = prefs.prefs.getInt(_lastInterstitialKey);
    if (last == null) {
      return true;
    }
    final since = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(last));
    return since >= _interstitialCooldown;
  }

  Future<void>? _consentInfo;

  /// Whether Google's own consent form is about to be shown by [init] — true
  /// for users in regions where it is required and consent is still missing.
  /// The app's own "ads are coming" note is redundant then and can be skipped.
  Future<bool> googleConsentFormPending() async {
    if (!isEnabled) {
      return false;
    }
    await _updateConsentInfo();
    final info = ConsentInformation.instance;
    return await info.getConsentStatus() == ConsentStatus.required &&
        await info.isConsentFormAvailable();
  }

  /// Asks the UMP SDK for the current consent state once per session.
  Future<void> _updateConsentInfo() {
    return _consentInfo ??= () {
      final updated = Completer<void>();
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () {
          if (!updated.isCompleted) {
            updated.complete();
          }
        },
        (error) {
          debugPrint('Consent info update failed: ${error.message}');
          if (!updated.isCompleted) {
            updated.complete();
          }
        },
      );
      return updated.future;
    }();
  }

  Future<void> _requestTrackingAuthorization() async {
    if (!Platform.isIOS) {
      return;
    }
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> _loadInterstitial() async {
    if (!canShowAds || _interstitial != null || _interstitialLoading) {
      return;
    }
    _interstitialLoading = true;

    await InterstitialAd.load(
      adUnitId: AdIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialLoading = false;
          _interstitial = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialLoading = false;
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }
}
