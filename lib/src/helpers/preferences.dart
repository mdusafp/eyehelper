import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class FastPreferences {
  static String allDayTrainingMapKey = 'all_day_training_map';
  static String allDayTrainingExpirationDateKey = 'all_day_training_expiration_date';
  static String dayCountersKey = 'day_counters';
  static String finishScreenShowedKey = 'finish_screen_showed';
  static String todayTrainingDateKey = 'today_training_date';
  static String todayTrainingMapKey = 'today_training_map';
  static String isVibrationEnabled = 'is_vibration_enabled';
  // use this instead of settings repository
  static String isNotificationEnabled = 'is_notification_enabled';
  static String notificationFrequencyInMillisecondsKey = 'notification_frequency_in_milliseconds';
  static String dailyScheduleListKey = 'daily_schedule_list';

  SharedPreferences prefs;

  Future<void> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      print("prefs inited");
    }
  }

  static final FastPreferences _singleton = FastPreferences._internal();

  bool get isInited => prefs != null;

  factory FastPreferences() {
    return _singleton;
  }

  FastPreferences._internal();
}
