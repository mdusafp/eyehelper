import 'package:meta/meta.dart';

@immutable
class DayScheduleDto {
  DayScheduleDto({
    @required this.name,
    @required this.min,
    @required this.max,
    @required this.lower,
    @required this.upper,
    @required this.isEnabled,
  });

  final String name;
  final double min;
  final double max;
  final double lower;
  final double upper;
  final bool isEnabled;
}
