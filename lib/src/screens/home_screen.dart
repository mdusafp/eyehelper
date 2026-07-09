import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/repositories/statistics_repository.dart';
import 'package:eyehelper/src/screens/about_exercises_screen.dart';
import 'package:eyehelper/src/screens/onboarding_screen.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_screen.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_screen.dart';
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
  int _currentIndex = 1;
  late StatisticsRepository _statisticsRepository;

  bool dataLoading = true;

  @override
  initState() {
    super.initState();

    _statisticsRepository = StatisticsRepository(FastPreferences());
    initAppConstants().then((_) {
      if (!(FastPreferences().prefs.getBool(FastPreferences.wasOnboardingShown) ?? false)) {
        Navigator.of(context).push(CupertinoPageRoute(
            fullscreenDialog: true, builder: (context) => AboutExercisesScreen()));
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
        });
      }
    });
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
    INDEX_STATISTICS_SCREEN: LocaleId.statistic,
    INDEX_EYE_SCREEN: LocaleId.excercises,
    INDEX_NOTIFICATIONS_SCREEN: LocaleId.notifications
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
          Localizer.getLocaleById(titles[_currentIndex], context),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        leading: GlassIconButton(
          size: 40,
          icon: Icon(
            Icons.help_outline,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true, builder: (context) => AboutExercisesScreen()));
          },
        ),
        actions: [
          if (FastPreferences().isInited && _currentIndex == INDEX_EYE_SCREEN)
            VibrationToggle()
          else
            // Balances the 40px leading button so the title stays centered.
            const SizedBox(width: 40),
        ],
      ),
      bottomBar: GlassTabBar.bottom(
        selectedIndex: _currentIndex,
        onTabSelected: (index) => setState(() => _currentIndex = index),
        selectedIconColor: Theme.of(context).colorScheme.secondary,
        tabs: [
          GlassTab(icon: ImageIcon(AssetImage('assets/stat_menu_icon.png'))),
          GlassTab(icon: Icon(Icons.remove_red_eye)),
          GlassTab(icon: Icon(Icons.settings)),
        ],
      ),
      body: dataLoading ? Center(child: CircularProgressIndicator()) : screens[_currentIndex],
    );
  }
}
