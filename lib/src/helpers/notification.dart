import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:typed_data';

import 'package:eyehelper/src/helpers/permission_manager.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/helpers/reminder_times.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsHelper {
  final BuildContext _context;
  Int64List _vibrationPattern = Int64List.fromList([0, 1000, 5000, 2000]);
  late FlutterLocalNotificationsPlugin _plugin;
  // Everything that talks to the plugin waits for this first.
  late final Future<bool?> _ready;
  // Meta required for Android 8.0+
  String _channelId = 'eyehelper-notifications-channel-id';
  String _channelName = 'eyehelper-notifications';
  String _channelDescription = 'Channel for excercise reminders';

  NotificationsHelper(BuildContext context) : _context = context {
    _plugin = FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _ready = _plugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static Future<bool> requestPermissions(BuildContext context) {
    return PermissionsManager.checkPermissionsWithDialog(
        context: context, group: Permission.notification, errorTitle: null, errorSubtitle: null);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _ready;
    await _plugin.cancelAll();
  }

  /// Rebuilds the schedule from the saved settings, as long as reminders are
  /// on and allowed. Run on every launch, so reminders recover after an app
  /// update, a move to another time zone or a permission granted in Settings.
  Future<void> refreshReminders() async {
    if (!getUpdatedSettings().notificationsEnabled ||
        !await PermissionsManager.checkPermissionsSilent(Permission.notification)) {
      return;
    }
    await scheduleExerciseReminders();
  }

  Future<void> scheduleExerciseReminders() async {
    NotificationSettings settings = getUpdatedSettings();
    // Read before the first await: the screen that owns the context may be
    // gone by the time the loop below runs.
    final title = _context.t.notifications.reminderTitle;
    final body = _context.t.notifications.reminderBody;
    await cancelAll();

    if (!settings.notificationsEnabled) {
      return;
    }

    if (settings.type == NotificationSettings.manualNotifType) {
      for (int i = 0; i < (settings.customScheduleList?.length ?? 0); i++) {
        logger.log('======= START $i START ======='.padLeft(20).padRight(20));

        CustomSchedule currentSchedule = settings.customScheduleList![i];
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

          if (!(settings.customScheduleList![i].cardInfo?.weekDays[schedule] ?? false) ||
              currentSchedule.cardInfo == null) {
            continue;
          }

          // compute notifications time
          int notificationTimeInMilliseconds = currentSchedule.cardInfo!.time.inMilliseconds;

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
            title,
            body,
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
          logger.log('Wrong working range for ${schedule.localeId} day');
          continue;
        }

        // get start of notifiable day to increment
        DateTime currentDay = now.add(Duration(days: scheduleIndex));
        DateTime startOfDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);

        // Evenly spaced inside the working window, none at the very start —
        // the same function the settings screen previews with. Times already
        // gone today are kept: each reminder repeats weekly, and the plugin
        // moves a past one to next week. Dropping them would leave today's
        // weekday without those reminders for good.
        List<DateTime> scheduleDates = autoReminderTimes(
          start: Duration(milliseconds: schedule.startOfWorkInMilliseconds),
          end: Duration(milliseconds: schedule.endOfWorkInMilliseconds),
          timesADay: timesADay,
        ).map((offset) => startOfDay.add(offset)).toList();

        logger.log('======= START $scheduleIndex START ======='.padLeft(20).padRight(20));
        scheduleDates.forEach((date) {
          logger.log(date.toIso8601String());
        });
        logger.log('======= END $scheduleIndex END ======='.padLeft(20).padRight(20));

        // Loop and schedule notifications
        for (final time in scheduleDates) {
          await scheduleNotification(
            (time.millisecondsSinceEpoch / 1000).floor(),
            title,
            body,
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
      channelDescription: _channelDescription,
      vibrationPattern: _vibrationPattern,
      //color: const Color.fromARGB(255, 255, 0, 0),
    );

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.Location loc = tz.getLocation(timezoneInfo.identifier);
    await _plugin
        .zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledNotificationDateTime, loc),
      notificationDetails: platformChannelSpecifics,
      // Inexact mode: exact alarms require a separate runtime permission on
      // Android 12+, and minute-level precision is not needed for reminders.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    )
        .catchError((e) {
      print(e);
    });
  }

  /// Triggered when user taps on a notification
  Future<void> onDidReceiveNotificationResponse(NotificationResponse response) async {
    debugPrint('notification payload: ' + (response.payload ?? ''));
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
          .map((i, schedule) {
            return MapEntry(i, CustomSchedule.fromMap(json.decode(schedule)));
          })
          .values
          .toList(),
      'notifType': FastPreferences().prefs.getString(FastPreferences.notificationTypeKey),
      'dailyScheduleList': FastPreferences()
          .prefs
          .getStringList(FastPreferences.dailyScheduleListKey)
          ?.asMap()
          .map((i, schedule) {
            Map<String, dynamic> map = {
              'localeId': weekList[i].shortLocale,
            };
            return MapEntry(i, DailySchedule.fromMap(map..addAll(json.decode(schedule))));
          })
          .values
          .toList(),
    };

    return NotificationSettings.fromMap(settingsMap);
  }

  static Future<void> saveSettings(NotificationSettings notificationSettings) async {
    await Future.wait([
      if (notificationSettings.type != null)
        FastPreferences().prefs.setString(
              FastPreferences.notificationTypeKey,
              notificationSettings.type!,
            )
      else
        FastPreferences().prefs.remove(
              FastPreferences.notificationTypeKey,
            ),
      FastPreferences().prefs.setInt(
            FastPreferences.timesADay,
            notificationSettings.timesADay ?? 1,
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
            (notificationSettings.customScheduleList ?? [])
                .map((d) => json.encode(d.toMap()))
                .toList(),
          ),
    ]);
  }
}

// extension _MapSkiper on Map<WeekDay, bool> {
//   List<WeekDay>? toListSkipEnabled(int? index) {
//     if (index == null) {
//       return null;
//     }

//     this.removeWhere((key, value) => !value);
//     return this.keys.skip(index).toList();
//   }

//   List<WeekDay>? toListTakeEnabled(int? index) {
//     if (index == null) {
//       return null;
//     }

//     this.removeWhere((key, value) => !value);
//     return this.keys.take(index).toList();
//   }
// }
