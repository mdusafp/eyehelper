import 'package:eyehelper/src/locale/ru.dart';
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
      'localeId': localeId,
      'startOfWorkInMilliseconds': startOfWorkInMilliseconds,
      'endOfWorkInMilliseconds': endOfWorkInMilliseconds,
      'isWorkingDay': isWorkingDay,
    };
  }
}

const List<LocaleId> _week = [
  LocaleId.monday,
  LocaleId.tuesday,
  LocaleId.wednesday,
  LocaleId.thursday,
  LocaleId.friday,
  LocaleId.saturday,
  LocaleId.sunday,
];

const _defaultNotificationsEnabled = false;
const _defaultNotificationFrequencyInMilliseconds = 0;
List<DailySchedule> _defaultDailyScheduleList = _week
    .asMap()
    // set working day in weekdays
    .map((i, localeId) => MapEntry(i, new DailySchedule(localeId: localeId, isWorkingDay: i < 5)))
    .values
    .toList();

class NotificationSettings {
  bool notificationsEnabled;
  int notificationFrequencyInMilliseconds;
  List<DailySchedule> dailyScheduleList;

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
