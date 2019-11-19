import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsHelper {
  BuildContext _context;
  Int64List _vibrationPattern = Int64List.fromList([0, 1000, 5000, 2000]);
  FlutterLocalNotificationsPlugin _plugin;

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

    final now = DateTime.now();
    final todayIndex = now.weekday - 1;
    final todaySchedule = settings.dailyScheduleList[todayIndex];
    // array where today is the first day of week
    // i do it to setup schedules for week
    final orderedScheduleList = [
      ...settings.dailyScheduleList.skip(todayIndex),
      ...settings.dailyScheduleList.take(todayIndex),
    ];
    // setup notifications
    for (final schedule in orderedScheduleList) {
      if (!schedule.isWorkingDay) {
        continue;
      }
      // we should shift start time in case if user working right now.
      int hoursInMilliseconds = now.hour * 60 * 60 * 1000;
      int startTime = hoursInMilliseconds > todaySchedule.startOfWorkInMilliseconds
          ? hoursInMilliseconds
          : todaySchedule.startOfWorkInMilliseconds;

      // schedule reminders
      startTime += settings.notificationFrequencyInMilliseconds;
      while (startTime < todaySchedule.endOfWorkInMilliseconds) {
        final scheduleTime = now
            .subtract(Duration(
              hours: now.hour,
              minutes: now.minute,
              seconds: now.second,
              milliseconds: now.millisecond,
            ))
            .add(Duration(milliseconds: startTime));

        await scheduleNotification(
          // probably issue
          // var nextYear = DateTime.now()..add(Duration(minutes: 365 * 5 + 5));
          // var heheYear = DateTime.now()..add(Duration(minutes: 365 * 5 + 3));
          // var loloYear = DateTime.now()..add(Duration(minutes: 365 * 5 + 8));
          // print((DateTime.now().millisecondsSinceEpoch / 1000).floor()); 1574155429
          // print((nextYear.millisecondsSinceEpoch / 1000).floor()); 1574155429
          // print((heheYear.millisecondsSinceEpoch / 1000).floor()); 1574155429
          // print((loloYear.millisecondsSinceEpoch / 1000).floor()); 1574155429
          (scheduleTime.millisecondsSinceEpoch / 1000).floor(),
          'Напоминание',
          'Пора делать зарядку!',
          scheduleTime,
        );
        startTime += settings.notificationFrequencyInMilliseconds;
      }
    }
  }

  /// Schedule single notification with [title] and [body] of message in [scheduledNotificationDateTime]
  Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      icon: 'secondary_icon',
      sound: 'slow_spring_board',
      largeIcon: 'sample_large_icon',
      largeIconBitmapSource: BitmapSource.Drawable,
      vibrationPattern: _vibrationPattern,
      color: const Color.fromARGB(255, 255, 0, 0),
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
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

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push(
      _context,
      new MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future onDidRecieveLocalNotification(int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: _context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
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
