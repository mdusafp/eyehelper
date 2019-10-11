import 'dart:async';
import 'dart:convert';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
 
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_value.dart';

const SPACING = 16.0;

enum CardType{
  week,
  day
}

const Map<int, CardType> cardTypes = {
  0: CardType.week,
  1: CardType.day,
};

class Statistics {
  final String exercisePerMonth;
  final String responsesOnPush;
  final List<Tuple2<int, double>> weekStats;
  final List<Tuple2<int, double>> dayStats;

  Statistics({
      @required int exercisePerMonth, 
      @required int responsesOnPush,
      @required List<Tuple2<int, double>> weekStats,
      @required List<Tuple2<int, double>> dayStats,
  })
      : this.exercisePerMonth = exercisePerMonth.toString(),
        this.responsesOnPush = '$responsesOnPush%',
        this.weekStats = weekStats,
        this.dayStats = dayStats;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Statistics> fetchStatistics() async {
    SharedPreferences preferences = FastPreferences().prefs;
    
    String temp = preferences.getString(FastPreferences.allDayTrainingMapKey);
    Map<String, dynamic> todayStat = temp == null ? null
      : json.decode(temp);

    List<Tuple2<int, double>> todayCastedStat = [];
    if (todayStat != null) {
      for (int i = 0; i < SwiperScreenInfo.flareActorByIndex.length; i++){
        int value = todayStat[i.toString()];
        todayCastedStat.add(
          Tuple2<int, double>(i, (value ?? 0).toDouble())
        );
      }
    }

    List<Tuple2<int, double>> weekStat = [];
    int monthCount = 0;
    
    String dayCountersJson = preferences.getString(FastPreferences.dayCountersKey);
    if (dayCountersJson != null){
      Map<String, dynamic> dayCountersMap = json.decode(dayCountersJson);

      DateTime time = DateTime.now();
      DateTime mondayTemp = time.add(Duration(days: -(time.weekday - 1)));
      DateTime monday = DateTime(mondayTemp.year, mondayTemp.month, mondayTemp.day);

      for (int i = 0; i < 7; i++){
        DateTime currDay = monday.add(Duration(days: i));
        String currDayStr = TodayTrainingCounters().formatterNoHours.format(currDay);
        weekStat.add(
          Tuple2<int, double>(i, ((dayCountersMap[currDayStr] ?? 0) as int).toDouble())
        );
      }

      

      dayCountersMap.forEach((key, value){
        try{
          if (value != 0 && 
            TodayTrainingCounters().formatterNoHours
              .parse(key)?.month == time.month &&
            TodayTrainingCounters().formatterNoHours
              .parse(key)?.year == time.year){
            monthCount += value;
          }
        } catch (e){
          print(e);
        }
      });
    }

    
    int notifCounters;
    int allNotifs = preferences.getInt(FastPreferences.notificationsShowedKey);
    int openedNotifs = preferences.getInt(FastPreferences.notificationsOpenedKey);

    if (allNotifs == null || allNotifs == 0 || openedNotifs == null){
      notifCounters = 0;
    } else {
      notifCounters = (openedNotifs / allNotifs * 100).toInt();
    }

    return Statistics(
      exercisePerMonth: monthCount, 
      responsesOnPush: notifCounters, 
      weekStats: weekStat,
      dayStats: todayCastedStat
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchStatistics(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
                  SizedBox(height: SPACING * 2),
                  AspectRatio(
                    aspectRatio: 1.17,
                    child: Container(
                      //height: 300,
                      child: Swiper(
                        scale: 0.8,
                        index: 0,
                        loop: false,
                        viewportFraction: 0.8,
                        itemCount: 2,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: StatisticCard(
                              type: cardTypes[index],
                              barWidth: 12.0,
                              barHeight: 0.0, // make background transparent
                              barActiveColor: StandardStyleColors.activeColor,
                              coordsList: cardTypes[index] == CardType.week 
                                ? snapshot.data.weekStats
                                : snapshot.data.dayStats
                                  
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: SPACING * 2),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      Localizer.getLocaleById(
                        LocaleId.exercise_frequency_per_day,
                        context,
                      ),
                      style: StandardStyleTexts.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: SPACING),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        StatisticValue(
                          label: Localizer.getLocaleById(
                            LocaleId.exercise_per_month,
                            context,
                          ),
                          value: snapshot.data.exercisePerMonth.toString(),
                        ),
                        StatisticValue(
                          label: Localizer.getLocaleById(
                            LocaleId.responses_on_push,
                            context,
                          ),
                          value: snapshot.data.responsesOnPush.toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR * 1.5,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
