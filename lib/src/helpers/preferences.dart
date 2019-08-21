import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eyehelper/src/models/notification_settings.dart';

class SharedPreferencesHelper {
  SharedPreferences _instance;

  String _notificationSettingsKey = 'notification_settings';

  Future<SharedPreferences> init() async {
    if (_instance == null) {
      _instance = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<NotificationSettings> getSettings() async {
    if (_instance == null) {
      throw new Exception('Shared preferences not initialized yet.');
    }

    String source = _instance.getString(_notificationSettingsKey);
    Map<String, dynamic> notificationSettingsMap;
    try {
      notificationSettingsMap = json.decode(source);
    } catch (err) {
      notificationSettingsMap = {};
    }

    return NotificationSettings.fromMap(notificationSettingsMap);
  }

  Future<bool> setSettings(NotificationSettings notificationSettings) async {
    if (_instance == null) {
      throw new Exception('Shared preferences not initialized yet.');
    }

    return _instance.setString(
      _notificationSettingsKey,
      json.encode(notificationSettings.toMap()),
    );
  }
}
