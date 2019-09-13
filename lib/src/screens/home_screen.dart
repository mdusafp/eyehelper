import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_screen.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_screen.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  NotificationsHelper notificationHelper;

  @override
  initState() {
    super.initState();
    notificationHelper = NotificationsHelper(context);
  }

  Map titles = {
    INDEX_STATISTICS_SCREEN: 'statistic',
    INDEX_EYE_SCREEN: 'excercises',
    INDEX_NOTIFICATIONS_SCREEN: 'notifications'
  };

  Map screens = {
    INDEX_STATISTICS_SCREEN: StatisticsScreen(),
    INDEX_EYE_SCREEN: EyeScreen(),
    INDEX_NOTIFICATIONS_SCREEN: NotificationScreen(),
  };

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = adaptiveUtils
      ..init(context); //height and width of design

    return Stack(
      children: <Widget>[
        Scaffold(
          body: screens[_currentIndex],
        ),
        Container(
          height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
          child: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: StandardStyleColors.transparent,
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
          child: BottomWavy(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index == INDEX_NOTIFICATIONS_SCREEN) {
                notificationHelper.scheduleNotification();
              }
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
        )
      ],
    );
  }
}
