import 'package:intl/intl.dart';

class CustomTimeFormatter {

  DateFormat _timeFormatter = new DateFormat.Hm();

  String format(Duration duration, {bool isEndOfDay = false}){
    return duration >= Duration(days: 1) && isEndOfDay
      ? "24:00" 
      : _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
      duration.inMilliseconds,
      isUtc: true,
    ));
  }

  Duration parse(String str){
    if (str == "24:00"){
      return Duration(days: 1);
    }

    return Duration(
      hours: _timeFormatter.parse(str, true).hour
    );
  }
}