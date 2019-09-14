import 'dart:async';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';

const SPACING = 16.0;

class StatisticCard extends StatefulWidget {
  final double barWidth;
  final double barHeight;
  final Color barActiveColor;
  final List<Tuple2<int, double>> coordsList;

  const StatisticCard({
    Key key,
    @required this.barWidth,
    @required this.barHeight,
    @required this.barActiveColor,
    @required this.coordsList,
  }) : super(key: key);

  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  StreamController<BarTouchResponse> controller;
  List<BarChartGroupData> barChartGroupData;
  double maxY;

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

    List<Tuple2<int, double>> sortedCoordsList = List.from(widget.coordsList);
    sortedCoordsList.sort((a, b) => a.item2.compareTo(b.item2));
    maxY = sortedCoordsList.reversed?.first?.item2;

    barChartGroupData = widget.coordsList
        .map((coords) => makeGroupData(coords.item1, coords.item2))
        .toList();
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
      int index = touchedSpot.spot.x.toInt();
      String times = Localizer.getLocaleById('times', context);

      return TooltipItem(
        '${tooltips[index]}\n${touchedSpot.spot.y.toInt()} $times',
        StandardStyleTexts.display1.copyWith(color: Colors.white),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SPACING / 2),
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
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(SPACING)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: SPACING / 2,
                    right: SPACING,
                    top: SPACING,
                  ),
                  child: FlChart(
                    chart: BarChart(
                      BarChartData(
                        barGroups: barChartGroupData ?? [],
                        barTouchData: BarTouchData(
                          touchTooltipData: TouchTooltipData(
                            tooltipBgColor: StandardStyleColors.lightGrey,
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

  String getLeftTitles(double value) {
    final steps = [0, maxY ~/ 2, maxY.toInt()]; // start, middle, end
    return steps.contains(value.toInt()) ? value.toInt().toString() : '';
  }

  String getBottomTitles(double value) {
    List<String> bottomTitles = [
      'monday_short',
      'tuesday_short',
      'wednesday_short',
      'thursday_short',
      'friday_short',
      'saturday_short',
      'sunday_short',
    ].map((title) => Localizer.getLocaleById(title, context)).toList();

    return bottomTitles.elementAt(value.toInt());
  }
}
