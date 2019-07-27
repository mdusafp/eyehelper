import 'package:shared_preferences/shared_preferences.dart';

class PersistentStore {
  ///
  /// Instantiation of the SharedPreferences library
  ///

  ///
  /// Key for notification enabled property
  ///
  static final String _kNotificationEnabled = 'notificationsEnabled';

  ///
  /// Key for apply all property
  ///
  static final String _kApplyAll = 'applyAll';

  ///
  /// Key for week schedule property
  ///
  static final String _kWeekSchedule = 'weekSchedule';

  ///
  /// Key for notification frequency
  ///
  static final String _kNotificationFrequency = 'notificationFrequency';

  ///
  /// Getter that returns if user enable notifications
  ///
  static Future<bool> get notificationEnabled async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kNotificationEnabled) ?? false;
  }

  ///
  /// Setter that change state of enable notifications
  ///
  static Future<bool> setNotificationEnabled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kNotificationEnabled, value);
  }

  ///
  /// Getter that returns if user apply notification to all days in the week
  ///
  static Future<bool> get applyAll async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kApplyAll) ?? false;
  }

  ///
  /// Setter that change state of apply all
  ///
  static Future<bool> setApplyAll(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kApplyAll, value);
  }

  ///
  /// Getter that returns list of encoded day schedule data
  ///
  static Future<List<String>> get weekSchedule async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kWeekSchedule) ?? [];
  }

  ///
  /// Setter that change state of encoded week schedule
  ///
  static Future<bool> setWeekSchedule(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_kWeekSchedule, value);
  }

  ///
  /// Getter that returns frequency for periodic notifications
  ///
  static Future<int> get notificationFrequency async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kNotificationFrequency) ?? 0;
  }

  ///
  /// Setter that change state of notification frequency
  ///
  static Future<bool> setNotificationFrequency(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_kNotificationFrequency, value);
  }
}
