import 'dart:async';

import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

// TODO: use constants from theme
const SPACING = 16.0;

class StatisticCard extends StatefulWidget {
  final CardType? type;
  final double barWidth;
  final double barHeight;
  final Color barActiveColor;
  final List<Tuple2<int, double>>? coordsList;

  const StatisticCard({
    super.key,
    required this.type,
    required this.barWidth,
    required this.barHeight,
    required this.barActiveColor,
    required this.coordsList,
  });

  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  late StreamController<BarTouchResponse> controller;
  late double maxY;

  List<BarChartGroupData>? barChartGroupData;

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: widget.barActiveColor,
          width: widget.barWidth,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.barHeight,
            color: EyehelperColorScheme.mainDark,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    controller = StreamController();
    controller.stream.distinct().listen((BarTouchResponse response) {});
    if (widget.coordsList != null && widget.coordsList!.isNotEmpty) {
      List<Tuple2<int, double>> sortedCoordsList = List.from(widget.coordsList!);
      sortedCoordsList.sort((a, b) => a.item2.compareTo(b.item2));
      maxY = sortedCoordsList.reversed.first.item2;

      barChartGroupData =
          widget.coordsList!.map((coords) => makeGroupData(coords.item1, coords.item2)).toList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    double sum = 0.0;
    widget.coordsList?.forEach((item) {
      sum += item.item2;
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(
          top: SPACING,
          right: SPACING,
        ),
        width: double.infinity,
        child: sum <= 0 ? _getNoDataView() : _getStatsView(context),
      ),
    );
  }

  Widget _getStatsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            _getTitle(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
          AspectRatio(
            aspectRatio: 1.06,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(SPACING)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: SPACING,
                  right: SPACING / 2,
                ),
                child: BarChart(
                  BarChartData(
                    barGroups: barChartGroupData ?? [],
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) => Padding(
                            padding: const EdgeInsets.only(top: SPACING / 2),
                            child: Text(getBottomTitles(value), style: _titlesStyle(context)),
                          ),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 36,
                          getTitlesWidget: (value, meta) =>
                              Text(getLeftTitles(value), style: _titlesStyle(context)),
                        ),
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
        ],
      ),
    );
  }

  TextStyle? _titlesStyle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall?.copyWith(
          color: Theme.of(context).primaryColorDark,
        );
  }

  String getLeftTitles(double value) {
    final steps = [0, maxY ~/ 2, maxY.toInt()]; // start, middle, end
    return steps.contains(value.toInt()) ? value.toInt().toString() : '';
  }

  String getBottomTitles(double value) {
    List<String> bottomTitles;
    if (widget.type == null) {
      return '';
    }

    switch (widget.type!) {
      case CardType.week:
        bottomTitles = [
          'schedule.mondayShort',
          'schedule.tuesdayShort',
          'schedule.wednesdayShort',
          'schedule.thursdayShort',
          'schedule.fridayShort',
          'schedule.saturdayShort',
          'schedule.sundayShort',
        ].map((title) => trKey(context, title)).toList();
        break;
      case CardType.day:
        bottomTitles = [
          ' 1',
          ' 2',
          ' 3',
          ' 4',
          ' 5',
          ' 6',
        ]
            .map((title) => context.t.schedule.exerciseShort + title)
            .toList();
        break;
    }

    return bottomTitles.elementAt(value.toInt());
  }

  String _getTitle() {
    if (widget.type == null) {
      return '';
    }

    String result;

    switch (widget.type!) {
      case CardType.week:
        result = 'statistics.currentWeek';
        break;
      case CardType.day:
        result = 'statistics.currentDay';
        break;
    }

    return trKey(context, result);
  }

  Center _getNoDataView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _getTitle(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65.0),
            child: Image.asset(
              'assets/sad_face.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
            child: Text(
              context.t.statistics.notEnoughData,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
