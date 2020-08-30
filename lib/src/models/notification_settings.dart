import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:flutter/material.dart';

const _defaultStartOfWorkInMilliseconds = 1000 * 60 * 60 * 8;
const _defaultEndOfWorkInMilliseconds = 1000 * 60 * 60 * 16;
const _defaultIsWorkingDay = false;

class DailySchedule {
  LocaleId localeId;
  int startOfWorkInMilliseconds;
  int endOfWorkInMilliseconds;
  bool isWorkingDay;

  DailySchedule({
    this.startOfWorkInMilliseconds = _defaultStartOfWorkInMilliseconds,
    this.endOfWorkInMilliseconds = _defaultEndOfWorkInMilliseconds,
    this.isWorkingDay = _defaultIsWorkingDay,
    @required this.localeId,
  });

  DailySchedule.fromMap(Map<String, dynamic> map) {
    localeId = map['localeId'];
    startOfWorkInMilliseconds = map['startOfWorkInMilliseconds'] ?? _defaultStartOfWorkInMilliseconds;
    endOfWorkInMilliseconds = map['endOfWorkInMilliseconds'] ?? _defaultEndOfWorkInMilliseconds;
    isWorkingDay = map['isWorkingDay'] ?? _defaultIsWorkingDay;
  }

  Map<String, dynamic> toMap() {
    return {
      // can't restore enum value from shared preference
      // reveal it from index
      // 'localeId': localeId,
      'startOfWorkInMilliseconds': startOfWorkInMilliseconds,
      'endOfWorkInMilliseconds': endOfWorkInMilliseconds,
      'isWorkingDay': isWorkingDay,
    };
  }
}

class CustomSchedule {
  TimeCardInfo cardInfo;
  bool isActive;

  CustomSchedule({
    this.cardInfo,
    this.isActive = true,
  });

  CustomSchedule.fromMap(Map<String, dynamic> map) {
    isActive = map['isActive'];
    cardInfo = TimeCardInfo.fromMap(map['cardInfo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'cardInfo': cardInfo.toMap(),
      'isActive': isActive,
    };
  }
}


const _defaultNotificationsEnabled = false;
const _defaultNotificationFrequencyInMilliseconds = Duration.millisecondsPerHour * 1;
List<DailySchedule> _defaultDailyScheduleList = weekList
    .asMap()
    // set working day in weekdays
    .map((i, weekDay) => MapEntry(i, new DailySchedule(localeId: weekDay.shortLocale, isWorkingDay: i < 5)))
    .values
    .toList();

class NotificationSettings {
  bool notificationsEnabled;
  int notificationFrequencyInMilliseconds;
  List<DailySchedule> dailyScheduleList;
  List<CustomSchedule> customScheduleList;

  NotificationSettings({
    this.notificationsEnabled,
    this.notificationFrequencyInMilliseconds,
    this.dailyScheduleList,
  });

  NotificationSettings.fromMap(Map<String, dynamic> map) {
    notificationsEnabled = map['notificationsEnabled'] ?? _defaultNotificationsEnabled;
    notificationFrequencyInMilliseconds =
        map['notificationFrequencyInMilliseconds'] ?? _defaultNotificationFrequencyInMilliseconds;
    dailyScheduleList = map['dailyScheduleList'] ?? _defaultDailyScheduleList;
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'notificationFrequencyInMilliseconds': notificationFrequencyInMilliseconds,
      'dailyScheduleList': List.from(dailyScheduleList.map((d) => d.toMap())),
    };
  }
}
