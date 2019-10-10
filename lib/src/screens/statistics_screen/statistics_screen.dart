import 'dart:async';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_card.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
 
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_value.dart';

const SPACING = 16.0;

class Statistics {
  final String exercisePerMonth;
  final String responsesOnPush;
  final List<Tuple2<int, double>> coordsList;

  Statistics(int exercisePerMonth, int responsesOnPush,
      List<Tuple2<int, double>> coordsList)
      : this.exercisePerMonth = exercisePerMonth.toString(),
        this.responsesOnPush = '$responsesOnPush%',
        this.coordsList = coordsList;
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
    return Future.value(new Statistics(25, 73, [
      Tuple2<int, double>(0, 5),
      Tuple2<int, double>(1, 6),
      Tuple2<int, double>(2, 15),
      Tuple2<int, double>(3, 12),
      Tuple2<int, double>(4, 9),
      Tuple2<int, double>(5, 10),
      Tuple2<int, double>(6, 6),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchStatistics(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
                  SizedBox(height: SPACING),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: SPACING),
                    child: StatisticCard(
                      barWidth: 12.0,
                      barHeight: 0.0, // make background transparent
                      barActiveColor: StandardStyleColors.activeColor,
                      coordsList: snapshot.data.coordsList,
                    ),
                  ),
                  SizedBox(height: SPACING),
                  Text(
                    Localizer.getLocaleById(
                      LocaleId.exercise_frequency_per_day,
                      context,
                    ),
                    style: StandardStyleTexts.title,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SPACING),
                  Row(
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
