import 'dart:convert';

import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayTrainingCounters {
  static final TodayTrainingCounters _singleton = TodayTrainingCounters._internal();

  factory TodayTrainingCounters() {
    return _singleton;
  }

  DateTime dateTimeNow = DateTime.now();
  DateFormat formatter = new DateFormat.yMd().add_jm();
  DateFormat formatterNoHours = new DateFormat.yMd();
  String todayFormatted = '';
  String todayFormattedNoHours = '';
  Map<String, dynamic> runtimeMap = {};

  TodayTrainingCounters._internal() {
    _resetDateTime();
  }

  _resetDateTime() {
    dateTimeNow = DateTime.now();
    formatter = new DateFormat.yMd().add_jm();
    formatterNoHours = new DateFormat.yMd();
    todayFormatted = formatter.format(dateTimeNow);
    todayFormattedNoHours = formatterNoHours.format(dateTimeNow);
  }

  Future<void> init(int screensCount) async {
    _resetDateTime();

    SharedPreferences prefs = FastPreferences().prefs;

    String date = prefs.getString(FastPreferences.todayTrainingDateKey) ?? todayFormatted;
    DateTime time = formatter.parse(date);

    if (time.difference(dateTimeNow).abs() > Duration(hours: 1).abs()) {
      await prefs.remove(FastPreferences.todayTrainingMapKey);
    }

    String? todayTrainingJson = prefs.getString(FastPreferences.todayTrainingMapKey);

    Map<String, dynamic> todayTrainingMap;
    if (todayTrainingJson == 'null' || todayTrainingJson == null) {
      todayTrainingMap = {};
      for (int i = 0; i < screensCount; i++) {
        todayTrainingMap[i.toString()] = false;
      }
      await prefs.setString(FastPreferences.todayTrainingDateKey, todayFormatted);
      await prefs.setBool(FastPreferences.finishScreenShowedKey, false);
    } else {
      todayTrainingMap = json.decode(todayTrainingJson) as Map<String, dynamic>;
    }

    runtimeMap = todayTrainingMap;

    await prefs.setString(FastPreferences.todayTrainingMapKey, json.encode(todayTrainingMap));

    //await Future.delayed(Duration(seconds: 1));

    print('initted = ' +
        todayFormatted +
        ' time and ' +
        todayTrainingMap.toString() +
        ' json = ' +
        todayTrainingJson.toString());
  }

  bool getPassed(int index) {
    _resetDateTime();

    return runtimeMap[index.toString()] ?? false;
    // SharedPreferences prefs = FastPreferences().prefs;

    // String todayTrainingJson = prefs.getString(FastPreferences.todayTrainingMapKey);
    // if (todayTrainingJson == null){
    //   return false;
    // }
    // var todayTrainingMap = (json.decode(todayTrainingJson) as Map<String, dynamic>);
    // if (todayTrainingMap == null){
    //   return false;
    // }
    // return todayTrainingMap[index] ?? false;
  }

  Map<String, dynamic> getAll() {
    _resetDateTime();

    return runtimeMap;
    // SharedPreferences prefs = FastPreferences().prefs;

    // String todayTrainingJson = prefs.getString(FastPreferences.todayTrainingMapKey);
    // if (todayTrainingJson == null){
    //   return null;
    // }

    // var todayTrainingMap = (json.decode(todayTrainingJson) as Map<String, dynamic>);
    // return todayTrainingMap;
  }

  setPassed(int index) async {
    _resetDateTime();

    SharedPreferences prefs = FastPreferences().prefs;

    String? todayTrainingJson = prefs.getString(FastPreferences.todayTrainingMapKey);
    Map<String, dynamic> todayTrainingMap;
    if (todayTrainingJson == null) {
      todayTrainingMap = {};
    } else {
      todayTrainingMap = (json.decode(todayTrainingJson) as Map<String, dynamic>);
    }

    todayTrainingMap[index.toString()] = true;

    runtimeMap = todayTrainingMap;

    await prefs.setString(FastPreferences.todayTrainingMapKey, json.encode(todayTrainingMap));

    print('$index ${todayTrainingMap.toString()}');

    /////////////////////////

    String? allDayTrainingJson = prefs.getString(FastPreferences.allDayTrainingMapKey);

    String? lastDate = prefs.getString(FastPreferences.allDayTrainingExpirationDateKey);

    if (lastDate != todayFormattedNoHours) {
      allDayTrainingJson = null;
    }

    Map<String, dynamic> allDayTrainingMap;
    if (allDayTrainingJson == null) {
      allDayTrainingMap = {};
      await prefs.setString(FastPreferences.allDayTrainingExpirationDateKey, todayFormattedNoHours);
    } else {
      allDayTrainingMap = (json.decode(allDayTrainingJson) as Map<String, dynamic>);
    }

    allDayTrainingMap[index.toString()] = (allDayTrainingMap[index.toString()] ?? 0) + 1;

    await prefs.setString(FastPreferences.allDayTrainingMapKey, json.encode(allDayTrainingMap));

    print('all day training map = ${allDayTrainingMap.toString()}');
  }

  Future<bool> checkFinishedAll() async {
    _resetDateTime();

    Map<String, dynamic> goneToday = getAll();
    if (goneToday.keys.isEmpty) {
      return false;
    }

    for (int i = 0; i < goneToday.keys.length; i++) {
      if (!(goneToday[i.toString()] ?? false)) {
        return false;
      }
    }

    return true;
  }
}
