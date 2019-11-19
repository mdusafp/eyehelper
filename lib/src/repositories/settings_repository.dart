import 'dart:convert';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';

class SettingsRepository {
  final FastPreferences fastPreferences;

  const SettingsRepository(this.fastPreferences);

  NotificationSettings getSettings() {
    final settingsMap = {
      /// [notificationsEnabled] is deprecated use fast prefs instead
      'notificationsEnabled': fastPreferences.prefs.getBool(_kNotificationsEnabled),
      'notificationFrequencyInMilliseconds': fastPreferences.prefs.getInt(_kNotificationFrequencyInMilliseconds),
      'dailyScheduleList': fastPreferences.prefs
          .getStringList(_kDailyScheduleList)
          ?.asMap()
          ?.map((i, schedule) {
            Map<String, dynamic> map = {
              'localeId': week[i],
            };
            return MapEntry(i, DailySchedule.fromMap(map..addAll(json.decode(schedule))));
          })
          ?.values
          ?.toList(),
    };

    return NotificationSettings.fromMap(settingsMap);
  }

  Future<void> saveSettings(NotificationSettings notificationSettings) async {
    await Future.wait([
      fastPreferences.prefs.setBool(_kNotificationsEnabled, notificationSettings.notificationsEnabled),
      fastPreferences.prefs.setInt(
        _kNotificationFrequencyInMilliseconds,
        notificationSettings.notificationFrequencyInMilliseconds,
      ),
      fastPreferences.prefs.setStringList(
        _kDailyScheduleList,
        notificationSettings.dailyScheduleList.map((d) => json.encode(d.toMap())).toList(),
      ),
    ]);
  }

  // keys
  final _kNotificationsEnabled = 'is_notification_enabled';
  final _kNotificationFrequencyInMilliseconds = 'notification_frequency_in_milliseconds';
  final _kDailyScheduleList = 'daily_schedule_list';
}
