import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';

class TimeCardInfo {
  final Duration time;
  final Map<WeekDay, bool> weekDays;

  const TimeCardInfo(this.time, this.weekDays);

  factory TimeCardInfo.fromMap(Map<String, dynamic> map) {
    return TimeCardInfo(
      CustomTimeFormatter().parse(map['time']),
      WeekDay.parseValueMap(map['weekDays']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': CustomTimeFormatter().format(time),
      'weekDays': WeekDay.createValueMap(weekDays),
    };
  }

  static get defaultCard13 => TimeCardInfo(Duration(hours: 13), {
        WeekDay.byEnum(WeekDaysEnum.monday): true,
        WeekDay.byEnum(WeekDaysEnum.tuesday): true,
        WeekDay.byEnum(WeekDaysEnum.wednesday): true,
        WeekDay.byEnum(WeekDaysEnum.thursday): true,
        WeekDay.byEnum(WeekDaysEnum.friday): true,
        WeekDay.byEnum(WeekDaysEnum.saturday): false,
        WeekDay.byEnum(WeekDaysEnum.sunday): false,
      });

  static get defaultCard17 => TimeCardInfo(Duration(hours: 17), {
        WeekDay.byEnum(WeekDaysEnum.monday): true,
        WeekDay.byEnum(WeekDaysEnum.tuesday): true,
        WeekDay.byEnum(WeekDaysEnum.wednesday): true,
        WeekDay.byEnum(WeekDaysEnum.thursday): true,
        WeekDay.byEnum(WeekDaysEnum.friday): true,
        WeekDay.byEnum(WeekDaysEnum.saturday): false,
        WeekDay.byEnum(WeekDaysEnum.sunday): false,
      });
}
