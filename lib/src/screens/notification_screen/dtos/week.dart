import 'package:eyehelper/src/helpers/hashcode_utils.dart';

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
  final String shortLocale;
  final String fullLocale;

  const WeekDay({required this.weekDay, required this.shortLocale, required this.fullLocale});

  WeekDay.byEnum(this.weekDay)
      : shortLocale = shortLocaleByEnum[weekDay] ?? 'schedule.mondayShort',
        fullLocale = fullLocaleByEnum[weekDay] ?? 'schedule.monday';

  static Map<WeekDay, bool> parseValueMap(Map<String, dynamic> map) {
    Map<WeekDay, bool> result = {};
    map.keys.forEach((item) {
      result[WeekDay.byEnum(toEnum(item))] = map[item];
    });
    return result;
  }

  static Map<String, bool> createValueMap(Map<WeekDay, bool> map) {
    Map<String, bool> result = {};
    map.keys.forEach((item) {
      result[item.weekDay.toString()] = map[item] ?? false;
    });
    return result;
  }

  static WeekDaysEnum toEnum(String value) {
    switch (value) {
      case "WeekDaysEnum.monday":
        return WeekDaysEnum.monday;
      case "WeekDaysEnum.tuesday":
        return WeekDaysEnum.tuesday;
      case "WeekDaysEnum.wednesday":
        return WeekDaysEnum.wednesday;
      case "WeekDaysEnum.thursday":
        return WeekDaysEnum.thursday;
      case "WeekDaysEnum.friday":
        return WeekDaysEnum.friday;
      case "WeekDaysEnum.saturday":
        return WeekDaysEnum.saturday;
      case "WeekDaysEnum.sunday":
        return WeekDaysEnum.sunday;
      default:
        return WeekDaysEnum.monday;
    }
  }

  bool operator ==(o) => o is WeekDay && weekDay == o.weekDay;
  int get hashCode => hash2(weekDay.hashCode, shortLocale.hashCode);
}

const Map<WeekDaysEnum, String> shortLocaleByEnum = {
  WeekDaysEnum.monday: 'schedule.mondayShort',
  WeekDaysEnum.tuesday: 'schedule.tuesdayShort',
  WeekDaysEnum.thursday: 'schedule.thursdayShort',
  WeekDaysEnum.wednesday: 'schedule.wednesdayShort',
  WeekDaysEnum.friday: 'schedule.fridayShort',
  WeekDaysEnum.saturday: 'schedule.saturdayShort',
  WeekDaysEnum.sunday: 'schedule.sundayShort',
};

const Map<WeekDaysEnum, String> fullLocaleByEnum = {
  WeekDaysEnum.monday: 'schedule.monday',
  WeekDaysEnum.tuesday: 'schedule.tuesday',
  WeekDaysEnum.thursday: 'schedule.thursday',
  WeekDaysEnum.wednesday: 'schedule.wednesday',
  WeekDaysEnum.friday: 'schedule.friday',
  WeekDaysEnum.saturday: 'schedule.saturday',
  WeekDaysEnum.sunday: 'schedule.sunday',
};

const List<WeekDay> weekList = [
  const WeekDay(
      weekDay: WeekDaysEnum.monday,
      shortLocale: 'schedule.mondayShort',
      fullLocale: 'schedule.monday'),
  const WeekDay(
      weekDay: WeekDaysEnum.tuesday,
      shortLocale: 'schedule.tuesdayShort',
      fullLocale: 'schedule.tuesday'),
  const WeekDay(
      weekDay: WeekDaysEnum.wednesday,
      shortLocale: 'schedule.wednesdayShort',
      fullLocale: 'schedule.wednesday'),
  const WeekDay(
      weekDay: WeekDaysEnum.thursday,
      shortLocale: 'schedule.thursdayShort',
      fullLocale: 'schedule.thursday'),
  const WeekDay(
      weekDay: WeekDaysEnum.friday,
      shortLocale: 'schedule.fridayShort',
      fullLocale: 'schedule.friday'),
  const WeekDay(
      weekDay: WeekDaysEnum.saturday,
      shortLocale: 'schedule.saturdayShort',
      fullLocale: 'schedule.saturday'),
  const WeekDay(
      weekDay: WeekDaysEnum.sunday,
      shortLocale: 'schedule.sundayShort',
      fullLocale: 'schedule.sunday'),
];
