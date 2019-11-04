import 'dart:convert';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';

class SettingsRepository {
  final FastPreferences fastPreferences;

  const SettingsRepository(this.fastPreferences);

  NotificationSettings getSettings() {
    final settingsMap = {
      'notificationsEnabled': fastPreferences.prefs.getBool(_kNotificationsEnabled),
      'notificationFrequencyInMilliseconds': fastPreferences.prefs.getInt(_kNotificationFrequencyInMilliseconds),
      'dailyScheduleList': fastPreferences.prefs
          .getStringList(_kDailyScheduleList)
          ?.map((d) => DailySchedule.fromMap(json.decode(d)))
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
        notificationSettings.dailyScheduleList.map((d) => json.encode(d)).toList(),
      ),
    ]);
  }

  // keys
  final _kNotificationsEnabled = 'notifications_enabled';
  final _kNotificationFrequencyInMilliseconds = 'notification_frequency_in_milliseconds';
  final _kDailyScheduleList = 'daily_schedule_list';
}
