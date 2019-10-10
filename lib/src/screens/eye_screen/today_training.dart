import 'dart:convert';

import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class TodayTrainingCounters {
  static final TodayTrainingCounters _singleton = TodayTrainingCounters._internal();

  factory TodayTrainingCounters() {
    return _singleton;
  }

  DateTime dateTimeNow;
  DateFormat formatter;
  String todayFormatted;
  Map<String, dynamic> runtimeMap = {};

  TodayTrainingCounters._internal(){
    _resetDateTime();
  }

  _resetDateTime(){
    dateTimeNow = DateTime.now();
    formatter = new DateFormat.yMd().add_jm();
    todayFormatted = formatter.format(dateTimeNow);
  }

  Future<void> init(int screensCount) async {
    _resetDateTime();

    SharedPreferences prefs = FastPreferences().prefs;

    String date = prefs.getString('today_training_date') ?? todayFormatted;
    DateTime time = formatter.parse(date);
    print('kek time = ' + time.toString());

    if (time.difference(dateTimeNow).abs() > Duration(hours: 1).abs()){
      await prefs.remove('today_training_map');
    }

    String todayTrainingJson = prefs.getString('today_training_map');

    Map<String, dynamic> todayTrainingMap;
    if (todayTrainingJson == null || todayTrainingJson == 'null'){
      todayTrainingMap = {};
      for (int i = 0; i < screensCount; i++){
        todayTrainingMap[i.toString()] = false;
      }
      await prefs.setString('today_training_date', todayFormatted);
      await prefs.setBool('finish_screen_showed', false);
    } else {
      todayTrainingMap = json.decode(todayTrainingJson) as Map<String, dynamic>;
    }
    
    runtimeMap = todayTrainingMap;
    
    await prefs.setString('today_training_map', json.encode(todayTrainingMap));

    //await Future.delayed(Duration(seconds: 1));

    print('initted = ' + todayFormatted + ' time and ' + todayTrainingMap.toString() + ' json = ' + todayTrainingJson.toString());
  }

  bool getPassed(int index) {
    _resetDateTime();

    return runtimeMap[index.toString()] ?? false;
    // SharedPreferences prefs = FastPreferences().prefs;

    // String todayTrainingJson = prefs.getString('today_training_map');
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

    // String todayTrainingJson = prefs.getString('today_training_map');
    // if (todayTrainingJson == null){
    //   return null;
    // }

    // var todayTrainingMap = (json.decode(todayTrainingJson) as Map<String, dynamic>);
    // return todayTrainingMap;
  }

  setPassed(int index) async {
    _resetDateTime();

    SharedPreferences prefs = FastPreferences().prefs;

    String todayTrainingJson = prefs.getString('today_training_map');
    Map<String, dynamic> todayTrainingMap;
    if (todayTrainingJson == null){
      todayTrainingMap = {};
    } else {
      todayTrainingMap = (json.decode(todayTrainingJson) as Map<String, dynamic>);
    }

    todayTrainingMap[index.toString()] = true;

    runtimeMap = todayTrainingMap;
    
    await prefs.setString('today_training_map', json.encode(todayTrainingMap));

    print('$index ${todayTrainingMap.toString()}');
  }


  Future<bool> checkFinishedAll() async {
    _resetDateTime();

    Map<String, dynamic> goneToday = getAll();
    if (goneToday == null || goneToday.keys.isEmpty){
      return false;
    }

    for(int i = 0; i < goneToday.keys.length; i++){
      if (!(goneToday[i.toString()]?? false)){
        return false;
      }
    }

    return true;
  }
}