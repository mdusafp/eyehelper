import 'dart:convert';

import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/working_hours.dart';

// one day in milliseconds
const DEFAULT_NOTIFICATION_FREQUENCY = 1000 * 60 * 60 * 24;

// we can't add default list because of localizer which needs context
const List<WorkingHours> DEFAULT_SCHEDULE = [];

class NotificationSettings {
  static String _notificationSettingsKey = 'notification_settings';

  bool notificationsOn;
  int notificationFrequency;
  List<WorkingHours> schedule;

  NotificationSettings({
    this.notificationsOn = false,
    this.notificationFrequency = DEFAULT_NOTIFICATION_FREQUENCY,
    this.schedule = DEFAULT_SCHEDULE,
  });

  NotificationSettings.fromMap(Map<String, dynamic> map) {
    notificationsOn = map['notificationsOn'] ?? false;
    notificationFrequency = map['notificationFrequency'] ?? DEFAULT_NOTIFICATION_FREQUENCY;
    schedule = List.from((map['schedule'] ?? []).map((s) => WorkingHours.fromMap(s)));
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationsOn': notificationsOn,
      'notificationFrequency': notificationFrequency,
      'schedule': List.from(schedule.map((s) => s.toMap())),
    };
  }

  static NotificationSettings getSettings() {
    if (FastPreferences().prefs == null) {
      throw new Exception('Shared preferences not initialized yet.');
    }

    String source = FastPreferences().prefs.getString(_notificationSettingsKey);
    Map<String, dynamic> notificationSettingsMap;
    try {
      notificationSettingsMap = json.decode(source);
    } catch (err) {
      notificationSettingsMap = {};
    }

    return NotificationSettings.fromMap(notificationSettingsMap);
  }

  Future<bool> setSettings(NotificationSettings notificationSettings) async {
    if (FastPreferences().prefs == null) {
      throw new Exception('Shared preferences not initialized yet.');
    }

    return FastPreferences().prefs.setString(
          _notificationSettingsKey,
          json.encode(notificationSettings.toMap()),
        );
  }
}
