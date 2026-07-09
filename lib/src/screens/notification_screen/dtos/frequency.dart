
enum FrequencyType { onceADay, twiceADay, threeADay, manual }

class Frequency {
  final FrequencyType type;
  final String title;
  final int timesADay;

  const Frequency({required this.type, required this.title, required this.timesADay});
}

const List<Frequency> frequencies = [
  Frequency(type: FrequencyType.onceADay, title: 'frequency.onceADay', timesADay: 1),
  Frequency(type: FrequencyType.twiceADay, title: 'frequency.twiceADay', timesADay: 2),
  Frequency(type: FrequencyType.threeADay, title: 'frequency.threeADay', timesADay: 3),
  Frequency(type: FrequencyType.manual, title: 'frequency.manualSettings', timesADay: -1),
];
