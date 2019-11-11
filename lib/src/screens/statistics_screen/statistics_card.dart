import 'dart:async';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/statistics_screen/statistics_screen.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';

// TODO: use constants from theme
const SPACING = 16.0;

class StatisticCard extends StatefulWidget {
  final CardType type;
  final double barWidth;
  final double barHeight;
  final Color barActiveColor;
  final List<Tuple2<int, double>> coordsList;

  const StatisticCard({
    Key key,
    @required this.type,
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
    if (widget.coordsList != null && widget.coordsList.isNotEmpty) {
      List<Tuple2<int, double>> sortedCoordsList = List.from(widget.coordsList);
      sortedCoordsList.sort((a, b) => a.item2.compareTo(b.item2));
      maxY = sortedCoordsList.reversed?.first?.item2;

      barChartGroupData = widget.coordsList.map((coords) => makeGroupData(coords.item1, coords.item2)).toList();
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SPACING / 2),
      ),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.only(
          top: SPACING,
          right: SPACING,
        ),
        width: double.infinity,
        child: sum <= 0 ? _getNoDataView() : Column(
          children: <Widget>[
            Text(
              _getTitle(),
              style: Theme.of(context).textTheme.display2.copyWith(
                color: Theme.of(context).primaryColorDark
              ),
            ),
            AspectRatio(
              aspectRatio: 1.05,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(SPACING)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: SPACING / 2,
                    top: SPACING,
                  ),
                  child: FlChart(
                    chart: BarChart(
                      BarChartData(
                        barGroups: barChartGroupData ?? [],
                        barTouchData: BarTouchData(
                          enabled: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            textStyle: Theme.of(context).textTheme.display1,
                            margin: SPACING,
                            getTitles: getBottomTitles,
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: Theme.of(context).textTheme.display1,
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
              )
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
    List<String> bottomTitles;

    switch (widget.type) {
      case CardType.week:
        bottomTitles = [
          LocaleId.monday_short,
          LocaleId.tuesday_short,
          LocaleId.wednesday_short,
          LocaleId.thursday_short,
          LocaleId.friday_short,
          LocaleId.saturday_short,
          LocaleId.sunday_short,
        ].map((title) => Localizer.getLocaleById(title, context)).toList();
        break;
      case CardType.day:
        bottomTitles = [
          ' 1',
          ' 2',
          ' 3',
          ' 4',
          ' 5',
          ' 6',
        ].map((title) => Localizer.getLocaleById(LocaleId.excercise_short, context) + title).toList();
        break;
    }

    return bottomTitles.elementAt(value.toInt());
  }

  String _getTitle() {
    if (widget.type == null) {
      return '';
    }

    LocaleId result;

    switch (widget.type) {
      case CardType.week:
        result = LocaleId.current_week;
        break;
      case CardType.day:
        result = LocaleId.current_day;
        break;
    }

    if (result == null) {
      return '';
    }

    return Localizer.getLocaleById(result, context);
  }

  _getNoDataView() {
    return Center(
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
              _getTitle(),
              style: Theme.of(context).textTheme.display2.copyWith(
                color: Theme.of(context).primaryColor
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
              Localizer.getLocaleById(LocaleId.not_enough_data, context),
              style: Theme.of(context).textTheme.display2.copyWith(
                color: Theme.of(context).primaryColor
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
