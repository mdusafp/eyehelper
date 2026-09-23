import 'package:eyehelper/src/helpers/ads/ads_service.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/repositories/statistics_repository.dart';
import 'package:eyehelper/src/screens/about_exercises_screen.dart';
import 'package:eyehelper/src/screens/onboarding_screen.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_screen.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_screen.dart';
import 'package:eyehelper/src/widgets/ad_banner.dart';
import 'package:eyehelper/src/widgets/alert_dialog.dart';
import 'package:eyehelper/src/widgets/app_background.dart';
import 'package:eyehelper/src/widgets/vibration_toggle.dart';
import 'package:flutter/scheduler.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _bottomBarHeight = 60.0;

  int _currentIndex = 1;
  late StatisticsRepository _statisticsRepository;

  bool dataLoading = true;
  bool adsReady = false;
  final double _bannerHeight = 0.0;

  /// Notifications only for now. The training tab must stay free of anything
  /// moving next to the exercises, and statistics is waiting on a redesign.
  bool get _showBanner =>
      (adsReady || kAdPlaceholderMode) && _currentIndex == INDEX_NOTIFICATIONS_SCREEN;

  @override
  initState() {
    super.initState();

    _statisticsRepository = StatisticsRepository(FastPreferences());
    initAppConstants().then((_) {
      if (!(FastPreferences().prefs.getBool(FastPreferences.wasOnboardingShown) ?? false)) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutExercisesScreen()));
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await Navigator.of(context).push(
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => OnBoardingScreen(
                onSetupSettings: (screenNum) {
                  Future.delayed(Duration(milliseconds: 400))
                      .then((value) => setState(() => _currentIndex = screenNum));
                },
              ),
            ),
          );
          // The consent form and the ATT prompt must not collide with
          // onboarding, so they wait until it is dismissed.
          initAds();
        });
      } else {
        initAds();
      }
    });
  }

  Future<void> initAds() async {
    if (kAdPlaceholderMode) {
      // Nothing to consent to while the banner is only a red block.
      return;
    }

    final ads = AdsService();
    if (!ads.isEnabled) {
      return;
    }

    if (!ads.introAcknowledged) {
      // Still inside the ad-free grace period — ask again next launch.
      if (!ads.shouldIntroduceAds) {
        return;
      }
      // Where Google's consent form is due it already says ads are coming;
      // a second dialog on top of it would just be noise.
      final googleAsks = await ads.googleConsentFormPending();
      if (!googleAsks && (!mounted || !await _showAdsIntro())) {
        // Closed without acknowledging — ask again next launch.
        return;
      }
      await ads.markIntroAcknowledged();
    }

    await ads.init();
    if (mounted && ads.canShowAds) {
      setState(() => adsReady = true);
    }
  }

  /// Explains why ads are about to appear. Returns whether the user
  /// acknowledged it.
  Future<bool> _showAdsIntro() async {
    final acknowledged = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => EyeHelperAlertDialog(
        title: context.t.ads.introTitle,
        subtitle: context.t.ads.introSubtitle,
        mainBtnTitle: context.t.ads.introButton,
        mainBtnCallback: () => Navigator.of(dialogContext).pop(true),
      ),
    );
    return acknowledged ?? false;
  }

  Future<void> initAppConstants() async {
    await FastPreferences().init();
    // make text in toolbar black

    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    _statisticsRepository.addActivity(startOfToday);

    if (mounted) {
      setState(() => dataLoading = false);
    }
  }

  Map titles = {
    INDEX_STATISTICS_SCREEN: 'common.statistics',
    INDEX_EYE_SCREEN: 'common.exercises',
    INDEX_NOTIFICATIONS_SCREEN: 'common.notifications'
  };

  Map screens = {
    INDEX_STATISTICS_SCREEN: StatisticsScreen(),
    INDEX_EYE_SCREEN: EyeScreen(),
    INDEX_NOTIFICATIONS_SCREEN: NotificationScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      backgroundColor: EyehelperColorScheme.backgroundWhite,
      background: const AppBackground(),
      appBar: GlassAppBar(
        title: Text(
          trKey(context, titles[_currentIndex]),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        // The help button explains the exercises — no place for it on the
        // reminders tab. A same-width spacer keeps the title centred.
        leading: _currentIndex == INDEX_NOTIFICATIONS_SCREEN
            ? const SizedBox(width: 40)
            : Transform.translate(
                // Optically the button sits a touch too far in on statistics.
                offset: Offset(4, 0),
                child: GlassIconButton(
                  size: 40,
                  icon: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => AboutExercisesScreen()));
                  },
                ),
              ),
        actions: [
          if (FastPreferences().isInited && _currentIndex == INDEX_EYE_SCREEN)
            VibrationToggle()
          else
            // Balances the 40px leading button so the title stays centered.
            const SizedBox(width: 40),
        ],
      ),
      bottomBarHeight: _bottomBarHeight + (_showBanner ? _bannerHeight : 0.0),
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (_showBanner)
          //   AdBanner(
          //     onHeightChanged: (height) {
          //       if (mounted && _bannerHeight != height) {
          //         setState(() => _bannerHeight = height);
          //       }
          //     },
          //   ),
          GlassTabBar.bottom(
            glowOpacity: 0.03,
            interactionGlowRadius: 1,
            interactionBehavior: GlassInteractionBehavior.none,
            selectedIndex: _currentIndex,
            interactionGlowColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.14),
            onTabSelected: (index) => setState(() => _currentIndex = index),
            selectedIconColor: Theme.of(context).colorScheme.secondary,
            tabs: [
              GlassTab(icon: Icon(Icons.bar_chart)),
              GlassTab(icon: Icon(Icons.remove_red_eye)),
              GlassTab(icon: Icon(Icons.settings)),
            ],
          ),
        ],
      ),
      body: dataLoading ? Center(child: CircularProgressIndicator()) : screens[_currentIndex],
    );
  }
}
