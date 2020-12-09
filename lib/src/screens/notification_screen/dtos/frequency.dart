import 'package:eyehelper/src/locale/ru.dart';

enum FrequencyType{
  onceADay,
  twiceADay,
  threeADay,
  manual
}

class Frequency {
  final FrequencyType type;
  final LocaleId title;
  final int timesADay;

  const Frequency({this.type, this.title, this.timesADay});
}

const List<Frequency> frequencies = [
  Frequency(type: FrequencyType.onceADay, title: LocaleId.onceADay, timesADay: 1),
  Frequency(type: FrequencyType.twiceADay, title: LocaleId.twiceADay, timesADay: 2),
  Frequency(type: FrequencyType.threeADay, title: LocaleId.threeADay, timesADay: 3),
  Frequency(type: FrequencyType.manual, title: LocaleId.manualSettings, timesADay: -1),
];