import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/repositories/settings_repository.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_screen.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_screen.dart';
import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  NotificationsHelper _notificationHelper;
  SettingsRepository _settingsRepository;

  bool dataLoading = true;

  @override
  initState() {
    super.initState();
    _notificationHelper = new NotificationsHelper(context);
    _settingsRepository = new SettingsRepository(FastPreferences());
    initAppConstants();
  }

  Future<void> initAppConstants() async {
    await FastPreferences().init();

    // make text in toolbar black
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    final settings = _settingsRepository.getSettings();
    await _notificationHelper.scheduleExerciseReminders(settings);

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
    return Stack(
      children: <Widget>[
        Scaffold(
          body: dataLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : screens[_currentIndex],
        ),
        Container(
          height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
          child: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: EyehelperColorScheme.transparent,
            flexibleSpace: ToolbarWavy(
              title: Localizer.getLocaleById(
                titles[_currentIndex],
                context,
              ),
              currentIndex: _currentIndex,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR,
            child: BottomWavy(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        )
      ],
    );
  }
}
