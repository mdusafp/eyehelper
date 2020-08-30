import 'package:eyehelper/src/helpers/hashcode_utils.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';

enum WeekDaysEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class WeekDay {
  final WeekDaysEnum weekDay;
  final LocaleId shortLocale;
  final LocaleId fullLocale;

  const WeekDay({this.weekDay, this.shortLocale, this.fullLocale});

  WeekDay.byEnum(this.weekDay) :
    shortLocale = shortLocaleByEnum[weekDay],
    fullLocale = fullLocaleByEnum[weekDay];

  static Map<WeekDay, bool> parseValueMap(Map<String, dynamic> map) {
    Map<WeekDay, bool> result = {};
    map.keys.forEach((item){
      result[WeekDay.byEnum(toEnum(item))] = map[item];
    });
    return result;
  }

  static Map<String, bool> createValueMap(Map<WeekDay, bool> map) {
    Map<String, bool> result = {};
    map.keys.forEach((item){
      result[item.weekDay.toString()] = map[item];
    });
    return result;
  }

  static WeekDaysEnum toEnum(String value){
    switch (value){
      case "monday": return WeekDaysEnum.monday;
      case "tuesday": return WeekDaysEnum.tuesday;
      case "wednesday": return WeekDaysEnum.wednesday;
      case "thursday": return WeekDaysEnum.thursday;
      case "friday": return WeekDaysEnum.friday;
      case "saturday": return WeekDaysEnum.saturday;
      case "sunday": return WeekDaysEnum.sunday;
      default: return WeekDaysEnum.monday;
    }
  }

  bool operator ==(o) => o is WeekDay && weekDay == o.weekDay;
  int get hashCode => hash2(weekDay.hashCode, shortLocale.hashCode);
}

const Map<WeekDaysEnum, LocaleId> shortLocaleByEnum = {
  WeekDaysEnum.monday : LocaleId.monday_short,
  WeekDaysEnum.tuesday : LocaleId.tuesday_short,
  WeekDaysEnum.thursday : LocaleId.thursday_short,
  WeekDaysEnum.wednesday : LocaleId.wednesday_short,
  WeekDaysEnum.friday : LocaleId.friday_short,
  WeekDaysEnum.saturday : LocaleId.saturday_short,
  WeekDaysEnum.sunday : LocaleId.sunday_short,
};

const Map<WeekDaysEnum, LocaleId> fullLocaleByEnum = {
  WeekDaysEnum.monday : LocaleId.monday,
  WeekDaysEnum.tuesday : LocaleId.tuesday,
  WeekDaysEnum.thursday : LocaleId.thursday,
  WeekDaysEnum.wednesday : LocaleId.wednesday,
  WeekDaysEnum.friday : LocaleId.friday,
  WeekDaysEnum.saturday : LocaleId.saturday,
  WeekDaysEnum.sunday : LocaleId.sunday,
};

const List<WeekDay> weekList = [
  const WeekDay(weekDay: WeekDaysEnum.monday, shortLocale: LocaleId.monday_short, fullLocale: LocaleId.monday),
  const WeekDay(weekDay: WeekDaysEnum.tuesday, shortLocale: LocaleId.tuesday_short, fullLocale: LocaleId.tuesday),
  const WeekDay(weekDay: WeekDaysEnum.wednesday, shortLocale: LocaleId.wednesday_short, fullLocale: LocaleId.wednesday),
  const WeekDay(weekDay: WeekDaysEnum.thursday, shortLocale: LocaleId.thursday_short, fullLocale: LocaleId.thursday),
  const WeekDay(weekDay: WeekDaysEnum.friday, shortLocale: LocaleId.friday_short, fullLocale: LocaleId.friday),
  const WeekDay(weekDay: WeekDaysEnum.saturday, shortLocale: LocaleId.saturday_short, fullLocale: LocaleId.saturday),
  const WeekDay(weekDay: WeekDaysEnum.sunday, shortLocale: LocaleId.sunday_short, fullLocale: LocaleId.sunday),
];
