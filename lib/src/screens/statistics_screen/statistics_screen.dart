import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';

const SPACING = 16.0;

class StatisticValue extends StatelessWidget {
  final String label;
  final String value;

  const StatisticValue({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: StandardStyleTexts.title.copyWith(
            color: StandardStyleColors.activeColor,
          ),
        ),
        Text(label, style: StandardStyleTexts.display2),
      ],
    );
  }
}

class StatisticCard extends StatefulWidget {
  final double barWidth;
  final double barHeight;
  final Color barActiveColor;

  const StatisticCard(
      {Key key, this.barWidth, this.barHeight, this.barActiveColor})
      : super(key: key);

  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  StreamController<BarTouchResponse> controller;

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          color: widget.barActiveColor,
          width: widget.barWidth,
          isRound: true,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: widget.barHeight,
            color: StandardStyleColors.mainDark,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    controller = new StreamController();
    controller.stream.distinct().listen((BarTouchResponse response) {});
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  List<TooltipItem> getTooltipItems(List<TouchedSpot> touchedSpots) {
    List<String> tooltips = [
      Localizer.getLocaleById('monday', context),
      Localizer.getLocaleById('tuesday', context),
      Localizer.getLocaleById('wednesday', context),
      Localizer.getLocaleById('thursday', context),
      Localizer.getLocaleById('friday', context),
      Localizer.getLocaleById('saturday', context),
      Localizer.getLocaleById('sunday', context),
    ];

    return touchedSpots.map((touchedSpot) {
      final index = touchedSpot.spot.x.toInt();
      return TooltipItem(
        '${tooltips[index]}\n${touchedSpot.spot.y}',
        StandardStyleTexts.display1.copyWith(color: Colors.white),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SPACING),
      ),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(SPACING / 2),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Text(
              Localizer.getLocaleById('current_week', context),
              style: StandardStyleTexts.display1,
            ),
            SizedBox(height: SPACING / 2),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(SPACING)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(SPACING),
                  child: FlChart(
                    chart: BarChart(
                      BarChartData(
                        barGroups: [
                          makeGroupData(0, 5),
                          makeGroupData(1, 6.5),
                          makeGroupData(2, 5),
                          makeGroupData(3, 7.5),
                          makeGroupData(4, 9),
                          makeGroupData(5, 11.5),
                          makeGroupData(6, 6.5),
                        ],
                        barTouchData: BarTouchData(
                          touchTooltipData: TouchTooltipData(
                            tooltipBgColor: Colors.blueGrey,
                            getTooltipItems: getTooltipItems,
                          ),
                          touchResponseSink: controller.sink,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            textStyle: StandardStyleTexts.display1,
                            margin: SPACING,
                            getTitles: getBottomTitles,
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: StandardStyleTexts.display1,
                            margin: SPACING,
                            getTitles: getLeftTitles,
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        // barGroups: showingBarGroups,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getLeftTitles(value) {
    if (value == 0) {
      return '1';
    } else if (value == 10) {
      return '5';
    } else if (value == 19) {
      return '10';
    } else {
      return '';
    }
  }

  String getBottomTitles(double value) {
    List<String> bottomTitles = [
      Localizer.getLocaleById('monday', context),
      Localizer.getLocaleById('tuesday', context),
      Localizer.getLocaleById('wednesday', context),
      Localizer.getLocaleById('thursday', context),
      Localizer.getLocaleById('friday', context),
      Localizer.getLocaleById('saturday', context),
      Localizer.getLocaleById('sunday', context),
    ];

    return bottomTitles[value.toInt()];
  }
}

class Statistics {
  final String exercisePerMonth;
  final String responsesOnPush;

  Statistics(int exercisePerMonth, int responsesOnPush)
      : this.exercisePerMonth = exercisePerMonth.toString(),
        this.responsesOnPush = '$responsesOnPush%';
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
    return Future.value(new Statistics(25, 73));
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
                  // offset header
                  SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
                  SizedBox(height: SPACING),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: SPACING),
                    child: StatisticCard(
                      barWidth: 10.0,
                      barHeight: 20.0,
                      barActiveColor: StandardStyleColors.activeColor,
                    ),
                  ),
                  SizedBox(height: SPACING),
                  Text(
                    Localizer.getLocaleById(
                      'exercise_frequency_per_day',
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
                          'exercise_per_month',
                          context,
                        ),
                        value: snapshot.data.exercisePerMonth.toString(),
                      ),
                      StatisticValue(
                        label: Localizer.getLocaleById(
                          'responses_on_push',
                          context,
                        ),
                        value: snapshot.data.responsesOnPush.toString(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: wv(PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR * 1.5),
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
