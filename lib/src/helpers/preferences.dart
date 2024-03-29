import 'dart:async';
import 'dart:io';
import 'package:eyehelper/src/helpers/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FastPreferences {
  static String allDayTrainingMapKey = 'all_day_training_map';
  static String allDayTrainingExpirationDateKey = 'all_day_training_expiration_date';
  static String dayCountersKey = 'day_counters';
  static String finishScreenShowedKey = 'finish_screen_showed';
  static String todayTrainingDateKey = 'today_training_date';
  static String todayTrainingMapKey = 'today_training_map';
  static String isVibrationEnabled = 'is_vibration_enabled';
  static String wasOnboardingShown = 'was_onboardingShown';
  // use this instead of settings repository
  static String isNotificationEnabled = 'is_notification_enabled';
  static String notificationTypeKey = 'notification_type';
  static String dailyScheduleListKey = 'daily_schedule_list';
  static String customScheduleListKey = 'custom_schedule_list';
  static String timesADay = 'times_a_day';
  static String userLikedApp = 'user_liked_app';
  static String userAppRating = 'user_app_rating';
  static String userRatedTheAppTime = 'user_rated_app_last_time';
  static String wasOpened = 'first_time_opened';

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    final wasOpened = prefs.getBool(FastPreferences.wasOpened) ?? false;
    if (!wasOpened) {
      AppAnalytics().sendEvent(
        FastPreferences.wasOpened,
        params: {
          'platform': Platform.isIOS ? 'iOS' : 'Android',
        },
      );
      prefs.setBool(FastPreferences.wasOpened, true);
    }
    print("prefs inited");
  }

  static final FastPreferences _singleton = FastPreferences._internal();

  bool get isInited => prefs != null;

  factory FastPreferences() {
    return _singleton;
  }

  FastPreferences._internal();
}
