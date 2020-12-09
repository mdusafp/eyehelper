import 'dart:async';
import 'dart:convert';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/repositories/statistics_repository.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_card.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_value.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

const SPACING = 16.0;

enum CardType { week, day }

const Map<int, CardType> cardTypes = {
  0: CardType.week,
  1: CardType.day,
};

class Statistics {
  final String exercisePerMonth;
  final String skippedDays;
  final List<Tuple2<int, double>> weekStats;
  final List<Tuple2<int, double>> dayStats;

  Statistics({
    @required int exercisePerMonth,
    @required int skippedDays,
    @required List<Tuple2<int, double>> weekStats,
    @required List<Tuple2<int, double>> dayStats,
  })  : this.exercisePerMonth = exercisePerMonth.toString(),
        this.skippedDays = skippedDays.toString(),
        this.weekStats = weekStats,
        this.dayStats = dayStats;
}

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatisticsRepository _statisticsRepository;

  @override
  initState() {
    super.initState();
    _statisticsRepository = new StatisticsRepository(FastPreferences());
  }

  Future<Statistics> fetchStatistics() async {
    SharedPreferences preferences = FastPreferences().prefs;

    String temp = preferences.getString(FastPreferences.allDayTrainingMapKey);
    Map<String, dynamic> todayStat = temp == null ? null : json.decode(temp);

    List<Tuple2<int, double>> todayCastedStat = [];
    if (todayStat != null) {
      for (int i = 0; i < SwiperScreenInfo.flareActorByIndex.length; i++) {
        int value = todayStat[i.toString()];
        todayCastedStat.add(Tuple2<int, double>(i, (value ?? 0).toDouble()));
      }
    }

    List<Tuple2<int, double>> weekStat = [];
    int monthCount = 0;

    String dayCountersJson = preferences.getString(FastPreferences.dayCountersKey);
    if (dayCountersJson != null) {
      Map<String, dynamic> dayCountersMap = json.decode(dayCountersJson);

      DateTime time = DateTime.now();
      DateTime mondayTemp = time.add(Duration(days: -(time.weekday - 1)));
      DateTime monday = DateTime(mondayTemp.year, mondayTemp.month, mondayTemp.day);

      for (int i = 0; i < 7; i++) {
        DateTime currDay = monday.add(Duration(days: i));
        String currDayStr = TodayTrainingCounters().formatterNoHours.format(currDay);
        weekStat.add(Tuple2<int, double>(i, ((dayCountersMap[currDayStr] ?? 0) as int).toDouble()));
      }

      dayCountersMap.forEach((key, value) {
        try {
          if (value != 0 &&
              TodayTrainingCounters().formatterNoHours.parse(key)?.month == time.month &&
              TodayTrainingCounters().formatterNoHours.parse(key)?.year == time.year) {
            monthCount += value;
          }
        } catch (e) {
          print(e);
        }
      });
    }

    return Statistics(
      exercisePerMonth: monthCount,
      skippedDays: _statisticsRepository.skippedDays,
      weekStats: weekStat,
      dayStats: todayCastedStat,
    );
  }

  @override
  Widget build(BuildContext context) {
    Crashlytics.instance.crash();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchStatistics(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              } else {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR + 10, bottom: 16.0),
                      child: AspectRatio(
                        aspectRatio: Utils().IS_SMALL_DEVICE ? 1.15 : 1.17,
                        child: Swiper(
                          scale: 0.9,
                          index: 0,
                          loop: false,
                          viewportFraction: 0.8,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: StatisticCard(
                                type: cardTypes[index],
                                barWidth: 8.0,
                                barHeight: 0.0, // make background transparent
                                barActiveColor: Theme.of(context).accentColor.withOpacity(.65),
                                coordsList: cardTypes[index] == CardType.week
                                    ? snapshot.data.weekStats
                                    : snapshot.data.dayStats,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        Localizer.getLocaleById(LocaleId.exercise_frequency_per_day, context),
                        style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).primaryColorDark),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StatisticValue(
                              label: Localizer.getLocaleById(LocaleId.exercise_per_month, context),
                              value: snapshot.data.exercisePerMonth.toString(),
                            ),
                            StatisticValue(
                              label: Localizer.getLocaleById(LocaleId.skipped_days, context),
                              value: snapshot.data.skippedDays.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
