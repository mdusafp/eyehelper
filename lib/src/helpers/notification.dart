import 'dart:ui';
import 'dart:async';
import 'dart:developer' as logger;
import 'dart:typed_data';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsHelper {
  BuildContext _context;
  Int64List _vibrationPattern = Int64List.fromList([0, 1000, 5000, 2000]);
  FlutterLocalNotificationsPlugin _plugin;
  // Meta required for Android 8.0+
  String _channelId = 'eyehelper-notifications-channel-id';
  String _channelName = 'eyehelper-notifications';
  String _channelDescription = 'Channel for excercise reminders';

  NotificationsHelper(BuildContext context) {
    _context = context;
    _plugin = new FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidRecieveLocalNotification,
    );
    final initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _plugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<void> scheduleExerciseReminders(NotificationSettings settings) async {
    await cancelAll();

    if (!settings.notificationsEnabled) {
      return;
    }

    DateTime now = DateTime.now();
    final todayIndex = now.weekday - 1;
    // array where 7 days starts from now
    // for example today is friday
    // array: [friday, saturday, sunday, monday, tuesday, wednesday, thursday]
    final orderedScheduleList = [
      ...settings.dailyScheduleList.skip(todayIndex),
      ...settings.dailyScheduleList.take(todayIndex),
    ];

    for (int scheduleIndex = 0; scheduleIndex < orderedScheduleList.length; scheduleIndex++) {
      final schedule = orderedScheduleList[scheduleIndex];

      logger.log('$scheduleIndex. ${Localizer.getLocaleById(schedule.localeId, _context)} - ${schedule.isWorkingDay}');

      if (!schedule.isWorkingDay) {
        continue;
      }

      // compute notifications time
      int workingTimeInMilliseconds = schedule.endOfWorkInMilliseconds - schedule.startOfWorkInMilliseconds;
      int scheduleDatesLength = (workingTimeInMilliseconds / settings.notificationFrequencyInMilliseconds).floor();

      // get start of notifiable day to increment
      DateTime currentDay = now.add(Duration(days: scheduleIndex));
      DateTime startOfDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);

      // create list of expected notifications
      List<DateTime> scheduleDates = List.generate(scheduleDatesLength, (index) {
        // user shouldn't be notified when he came to work but at the end should be
        // that's why +1
        int incrementInMilliseconds = settings.notificationFrequencyInMilliseconds * (index + 1);
        int scheduleDateInMilliseconds = schedule.startOfWorkInMilliseconds + incrementInMilliseconds;
        return startOfDay.add(Duration(milliseconds: scheduleDateInMilliseconds));
      })
          // we shouldn't setup notifications before
          .where((time) => time.isAfter(now))
          .toList();

      logger.log('======= START $scheduleIndex START ======='.padLeft(20).padRight(20));
      scheduleDates.forEach((date) {
        logger.log(date.toIso8601String());
      });
      logger.log('======= END $scheduleIndex END ======='.padLeft(20).padRight(20));

      // Loop and schedule notifications
      for (final time in scheduleDates) {
        await scheduleNotification(
          (time.millisecondsSinceEpoch / 1000).floor(),
          Localizer.getLocaleById(LocaleId.notification_reminder_exercise_title, _context),
          Localizer.getLocaleById(LocaleId.notification_reminder_excercise_body, _context),
          time,
        );
      }
    }
  }

  /// Schedule single notification with [title] and [body] of message in [scheduledNotificationDateTime]
  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledNotificationDateTime) async {
    final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      icon: 'secondary_icon',
      sound: 'slow_spring_board',
      largeIcon: 'sample_large_icon',
      largeIconBitmapSource: BitmapSource.Drawable,
      vibrationPattern: _vibrationPattern,
      color: const Color.fromARGB(255, 255, 0, 0),
    );

    final iOSPlatformChannelSpecifics = new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    final platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    await _plugin.schedule(
      id,
      title,
      body,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }

  /// Triggered when user taps on a notification
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      _context,
      new MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  /// Display a dialog with the notification details, tap ok to go to another page
  Future onDidRecieveLocalNotification(int id, String title, String body, String payload) async {
    showDialog(
      context: _context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text(Localizer.getLocaleById(LocaleId.ok, context)),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
