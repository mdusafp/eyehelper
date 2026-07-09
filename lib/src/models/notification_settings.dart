import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';

const _defaultStartOfWorkInMilliseconds = 1000 * 60 * 60 * 8;
const _defaultEndOfWorkInMilliseconds = 1000 * 60 * 60 * 16;
const _defaultIsWorkingDay = false;

class DailySchedule {
  LocaleId localeId;
  int startOfWorkInMilliseconds = _defaultStartOfWorkInMilliseconds;
  int endOfWorkInMilliseconds = _defaultEndOfWorkInMilliseconds;
  bool isWorkingDay = _defaultIsWorkingDay;

  DailySchedule({
    this.startOfWorkInMilliseconds = _defaultStartOfWorkInMilliseconds,
    this.endOfWorkInMilliseconds = _defaultEndOfWorkInMilliseconds,
    this.isWorkingDay = _defaultIsWorkingDay,
    required this.localeId,
  });

  DailySchedule.fromMap(Map<String, dynamic> map) : localeId = LocaleId.one_day {
    localeId = map['localeId'];
    startOfWorkInMilliseconds =
        map['startOfWorkInMilliseconds'] ?? _defaultStartOfWorkInMilliseconds;
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
  TimeCardInfo? cardInfo;
  bool isActive;

  CustomSchedule({
    this.cardInfo,
    this.isActive = true,
  });

  CustomSchedule.fromMap(Map<String, dynamic> map) : isActive = false {
    isActive = map['isActive'];
    cardInfo = TimeCardInfo.fromMap(map['cardInfo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'cardInfo': cardInfo?.toMap(),
      'isActive': isActive,
    };
  }
}

const _defaultNotificationsEnabled = false;
//const _defaultNotificationFrequencyInMilliseconds = Duration.millisecondsPerHour * 1;
const _defaultTimesADay = 1;
List<DailySchedule> _defaultDailyScheduleList = weekList
    .asMap()
    // set working day in weekdays
    .map((i, weekDay) =>
        MapEntry(i, new DailySchedule(localeId: weekDay.shortLocale, isWorkingDay: i < 5)))
    .values
    .toList();

List<CustomSchedule> _defaultManualScheduleList = [
  CustomSchedule(cardInfo: TimeCardInfo.defaultCard13),
  CustomSchedule(cardInfo: TimeCardInfo.defaultCard17),
];

class NotificationSettings {
  static const String autoNotifType = "Auto";
  static const String manualNotifType = "Manual";

  bool notificationsEnabled = _defaultNotificationsEnabled;
  //int notificationFrequencyInMilliseconds;
  List<DailySchedule> dailyScheduleList;
  List<CustomSchedule>? customScheduleList;
  String? type;
  int? timesADay;

  NotificationSettings({
    this.notificationsEnabled = _defaultNotificationsEnabled,
    //this.notificationFrequencyInMilliseconds,
    this.dailyScheduleList = const <DailySchedule>[],
    this.customScheduleList,
    this.timesADay,
    this.type,
  });

  static NotificationSettings fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      notificationsEnabled: map['notificationsEnabled'] ?? _defaultNotificationsEnabled,
      dailyScheduleList: map['dailyScheduleList'] ?? _defaultDailyScheduleList,
      customScheduleList: map['customScheduleList'] ?? _defaultManualScheduleList,
      type: map['notifType'] ?? autoNotifType,
      timesADay: map['timesADay'] ?? _defaultTimesADay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationsEnabled': notificationsEnabled,
      //'notificationFrequencyInMilliseconds': notificationFrequencyInMilliseconds,
      'dailyScheduleList': List.from(dailyScheduleList.map((d) => d.toMap())),
      'customScheduleList':
          customScheduleList == null ? null : List.from(customScheduleList!.map((d) => d.toMap())),
      'notifType': type,
      'timesADay': timesADay,
    };
  }
}
