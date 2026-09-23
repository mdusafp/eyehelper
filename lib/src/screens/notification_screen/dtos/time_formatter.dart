import 'package:intl/intl.dart';

class CustomTimeFormatter {
  DateFormat _timeFormatter = new DateFormat.Hm();

  String format(Duration duration, {bool isEndOfDay = false}) {
    return duration >= Duration(days: 1) && isEndOfDay
        ? "24:00"
        : _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
            duration.inMilliseconds,
            isUtc: true,
          ));
  }

  /// "9:00" rather than "09:00" — for labels, never for storage.
  String formatShort(Duration duration) {
    if (duration >= const Duration(days: 1)) {
      return '24:00';
    }
    final minutes = duration.inMinutes % 60;
    return '${duration.inHours}:${minutes.toString().padLeft(2, '0')}';
  }

  Duration parse(String str, {bool withMinutes = false}) {
    if (str == "24:00") {
      return Duration(days: 1);
    }

    return Duration(
      hours: _timeFormatter.parse(str, true).hour,
      minutes: withMinutes ? _timeFormatter.parse(str, true).minute : 0,
    );
  }
}
