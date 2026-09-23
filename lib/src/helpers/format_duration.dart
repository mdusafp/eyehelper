import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/widgets.dart';

/// "2 h 39 min" / "31 min" / "2 min 15 s"; seconds only appear under ten
/// minutes, where they still mean something.
String formatDuration(BuildContext context, Duration duration) {
  final t = context.t.statistics;
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;

  if (hours > 0) {
    return '$hours ${t.hoursShort} $minutes ${t.minutesShort}';
  }
  if (minutes >= 10 || (minutes > 0 && seconds == 0)) {
    return '$minutes ${t.minutesShort}';
  }
  if (minutes > 0) {
    return '$minutes ${t.minutesShort} $seconds ${t.secondsShort}';
  }
  return '$seconds ${t.secondsShort}';
}
