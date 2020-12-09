import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'dart:developer' as logger;
import 'dart:typed_data';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/home_screen.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
    final initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _plugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<void> scheduleExerciseReminders() async {
    NotificationSettings settings = getUpdatedSettings();
    await cancelAll();

    if (!settings.notificationsEnabled) {
      return;
    }

    if (settings.type == NotificationSettings.manualNotifType) {
      for (int i = 0; i < settings.customScheduleList.length; i++) {
        logger.log('======= START $i START ======='.padLeft(20).padRight(20));

        CustomSchedule currentSchedule = settings.customScheduleList[i];
        if (!currentSchedule.isActive) {
          continue;
        }

        DateTime now = DateTime.now();
        final todayIndex = now.weekday - 1;
        // array where 7 days starts from now
        // for example today is friday
        // array: [friday, saturday, sunday, monday, tuesday, wednesday, thursday]
        final orderedScheduleList = [
          ...weekList.skip(todayIndex),
          ...weekList.take(todayIndex),
        ];

        for (int scheduleIndex = 0; scheduleIndex < orderedScheduleList.length; scheduleIndex++) {
          final schedule = orderedScheduleList[scheduleIndex];

          if (!(settings.customScheduleList[i].cardInfo.weekDays[schedule] ?? false)) {
            continue;
          }

          // compute notifications time
          int notificationTimeInMilliseconds = currentSchedule.cardInfo.time.inMilliseconds;

          //(workingTimeInMilliseconds / settings.notificationFrequencyInMilliseconds).floor();

          // get start of notifiable day to increment
          DateTime currentDay = now.add(Duration(days: scheduleIndex));
          DateTime startOfDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);

          DateTime notificationTime =
              startOfDay.add(Duration(milliseconds: notificationTimeInMilliseconds));

          logger.log(notificationTime.toIso8601String());

          //TODO: Check today.

          // Schedule notifications
          await scheduleNotification(
            (notificationTime.millisecondsSinceEpoch / 1000).floor(),
            Localizer.getLocaleById(LocaleId.notification_reminder_exercise_title, _context),
            Localizer.getLocaleById(LocaleId.notification_reminder_excercise_body, _context),
            notificationTime,
          ).catchError((e) {
            print(e);
          });
        }

        logger.log('======= END $i END ======='.padLeft(20).padRight(20));

        // for (int day = 0; day < currentSchedule.cardInfo.weekDays.length; day++) {
        //   DateTime currentDay = DateTime.now();
        //   DateTime startOfDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);
        // }
      }
      return;
    }

    if (settings.type == NotificationSettings.autoNotifType) {
      DateTime now = DateTime.now();
      final todayIndex = now.weekday - 1;
      // array where 7 days starts from now
      // for example today is friday
      // array: [friday, saturday, sunday, monday, tuesday, wednesday, thursday]
      final orderedScheduleList = [
        ...settings.dailyScheduleList.skip(todayIndex),
        ...settings.dailyScheduleList.take(todayIndex),
      ];

      int timesADay = settings.timesADay ?? 1;

      for (int scheduleIndex = 0; scheduleIndex < orderedScheduleList.length; scheduleIndex++) {
        final schedule = orderedScheduleList[scheduleIndex];

        if (!schedule.isWorkingDay) {
          continue;
        }

        if (schedule.endOfWorkInMilliseconds <= schedule.startOfWorkInMilliseconds) {
          logger.log(
              'Wrong working range for ${Localizer.getLocaleById(schedule.localeId, _context)} day');
          continue;
        }

        // compute notifications time
        int workingTimeInMilliseconds =
            schedule.endOfWorkInMilliseconds - schedule.startOfWorkInMilliseconds;
        int frequencyInMilliseconds = (workingTimeInMilliseconds / (timesADay + 1)).floor();

        int scheduleDatesLength = timesADay;
        //(workingTimeInMilliseconds / settings.notificationFrequencyInMilliseconds).floor();

        // get start of notifiable day to increment
        DateTime currentDay = now.add(Duration(days: scheduleIndex));
        DateTime startOfDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);

        // create list of expected notifications
        List<DateTime> scheduleDates = List.generate(scheduleDatesLength, (index) {
          // user shouldn't be notified when he came to work but at the end should be
          // that's why +1
          int incrementInMilliseconds = frequencyInMilliseconds * (index + 1);
          int scheduleDateInMilliseconds =
              schedule.startOfWorkInMilliseconds + incrementInMilliseconds;
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
  }

  /// Schedule single notification with [title] and [body] of message in [scheduledNotificationDateTime]
  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledNotificationDateTime) async {
    final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      vibrationPattern: _vibrationPattern,
      color: const Color.fromARGB(255, 255, 0, 0),
    );

    final iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    final platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    tz.Location loc = tz.getLocation(await FlutterNativeTimezone.getLocalTimezone());
    await _plugin
        .zonedSchedule(id, title, body, tz.TZDateTime.from(scheduledNotificationDateTime, loc),
            platformChannelSpecifics,
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            scheduledNotificationRepeatFrequency: ScheduledNotificationRepeatFrequency.weekly)
        .catchError((e) {
      print(e);
    });
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

  static NotificationSettings getUpdatedSettings() {
    var list = FastPreferences().prefs.getStringList(FastPreferences.customScheduleListKey);

    final settingsMap = {
      /// [notificationsEnabled] is deprecated use fast prefs instead
      'notificationsEnabled':
          FastPreferences().prefs.getBool(FastPreferences.isNotificationEnabled),
      // 'notificationFrequencyInMilliseconds': FastPreferences().prefs.getInt(
      //       FastPreferences.notificationFrequencyInMillisecondsKey,
      //     ),
      'timesADay': FastPreferences().prefs.getInt(FastPreferences.timesADay),
      'customScheduleList': FastPreferences()
          .prefs
          .getStringList(FastPreferences.customScheduleListKey)
          ?.asMap()
          ?.map((i, schedule) {
            return MapEntry(i, CustomSchedule.fromMap(json.decode(schedule)));
          })
          ?.values
          ?.toList(),
      'notifType': FastPreferences().prefs.getString(FastPreferences.notificationTypeKey),
      'dailyScheduleList': FastPreferences()
          .prefs
          .getStringList(FastPreferences.dailyScheduleListKey)
          ?.asMap()
          ?.map((i, schedule) {
            Map<String, dynamic> map = {
              'localeId': weekList[i].shortLocale,
            };
            return MapEntry(i, DailySchedule.fromMap(map..addAll(json.decode(schedule))));
          })
          ?.values
          ?.toList(),
    };

    return NotificationSettings.fromMap(settingsMap);
  }

  static Future<void> saveSettings(NotificationSettings notificationSettings) async {
    await Future.wait([
      FastPreferences().prefs.setString(
            FastPreferences.notificationTypeKey,
            notificationSettings.type,
          ),
      FastPreferences().prefs.setInt(
            FastPreferences.timesADay,
            notificationSettings.timesADay,
          ),
      FastPreferences().prefs.setBool(
            FastPreferences.isNotificationEnabled,
            notificationSettings.notificationsEnabled,
          ),
      FastPreferences().prefs.setStringList(
            FastPreferences.dailyScheduleListKey,
            notificationSettings.dailyScheduleList.map((d) => json.encode(d.toMap())).toList(),
          ),
      FastPreferences().prefs.setStringList(
            FastPreferences.customScheduleListKey,
            notificationSettings.customScheduleList.map((d) => json.encode(d.toMap())).toList(),
          ),
    ]);
  }
}

extension _MapSkiper on Map<WeekDay, bool> {
  List<WeekDay> toListSkipEnabled(int index) {
    if (this == null || index == null) {
      return null;
    }

    this.removeWhere((key, value) => !value);
    return this.keys.skip(index);
  }

  List<WeekDay> toListTakeEnabled(int index) {
    if (this == null || index == null) {
      return null;
    }

    this.removeWhere((key, value) => !value);
    return this.keys.take(index);
  }
}
