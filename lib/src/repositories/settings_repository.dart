import 'dart:convert';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';

class SettingsRepository {
  final FastPreferences fastPreferences;

  const SettingsRepository(this.fastPreferences);

  NotificationSettings getSettings() {
    final settingsMap = {
      /// [notificationsEnabled] is deprecated use fast prefs instead
      'notificationsEnabled': FastPreferences().prefs.getBool(FastPreferences.isNotificationEnabled),
      'notificationFrequencyInMilliseconds': FastPreferences().prefs.getInt(
        FastPreferences.notificationFrequencyInMillisecondsKey,),
      'dailyScheduleList': FastPreferences().prefs
          .getStringList(FastPreferences.dailyScheduleListKey)
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
      FastPreferences().prefs.setBool(FastPreferences.isNotificationEnabled, notificationSettings.notificationsEnabled),
      FastPreferences().prefs.setInt(
        FastPreferences.notificationFrequencyInMillisecondsKey,
        notificationSettings.notificationFrequencyInMilliseconds,
      ),
      FastPreferences().prefs.setStringList(
        FastPreferences.dailyScheduleListKey,
        notificationSettings.dailyScheduleList.map((d) => json.encode(d.toMap())).toList(),
      ),
    ]);
  }
}
