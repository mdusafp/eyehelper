import 'dart:convert';

import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_single_page.dart';
import 'package:eyehelper/src/screens/eye_screen/swiper_pagination.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:eyehelper/src/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperMain extends StatefulWidget {
  final Function showResultCallback;

  const SwiperMain({Key key, this.showResultCallback}) : super(key: key);

  @override
  _SwiperMainState createState() => new _SwiperMainState();
}

class _SwiperMainState extends State<SwiperMain> {
  int swiperIndex = 0;

  SwiperController swiperController = SwiperController();
  TodayTrainingCounters countersHelper = TodayTrainingCounters();

  bool _isLoading = true;

  @override
  void initState() {
    countersHelper.init(SwiperScreenInfo.flareActorByIndex.length).then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }

    Widget swiper = new Swiper(
      onIndexChanged: (index) {
        setState(() => swiperIndex = index);
      },
      controller: swiperController,
      loop: false,
      pagination: new SwiperPagination(
          margin: EdgeInsets.only(bottom: 100.0),
          builder: CustomSwiperBuilder(
            color: Colors.grey,
            space: 10.0,
            size: 6.0,
            activeSize: 8.0,
            activeColor: EyehelperColorScheme.activeColor,
          )),
      itemBuilder: (BuildContext context, int index) {
        SwiperScreenInfo info = SwiperScreenInfo.flareActorByIndex[index];

        return EyeSinglePage(
            info: info,
            controller: swiperController,
            startBtnCallback: () => _processStart(index),
            finishBtnCallback: _processFinish);
      },
      itemCount: SwiperScreenInfo.flareActorByIndex.length,
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Material(color: Colors.white, child: new Container(child: Stack(children: <Widget>[swiper]))),
    );
  }

  _processStart(index) async {
    var preferences = FastPreferences().prefs;

    String dayCountersJson = preferences.getString(FastPreferences.dayCountersKey);
    Map<String, dynamic> dayCountersMap;
    if (dayCountersJson == null) {
      dayCountersMap = {};
    } else {
      dayCountersMap = (json.decode(dayCountersJson) as Map<String, dynamic>);
    }

    dayCountersMap[countersHelper.todayFormattedNoHours] =
        (dayCountersMap[countersHelper.todayFormattedNoHours] ?? 0) + 1;
    dayCountersMap.removeWhere((key, value) =>
        countersHelper.dateTimeNow.difference(countersHelper.formatterNoHours.parse(key)).abs() >
        Duration(days: 365).abs());
    await preferences.setString(FastPreferences.dayCountersKey, json.encode(dayCountersMap));

    await countersHelper.setPassed(index);

    print('counters = $dayCountersMap');
  }

  _processFinish() async {
    var preferences = FastPreferences().prefs;

    if (await countersHelper.checkFinishedAll() && !preferences.getBool(FastPreferences.finishScreenShowedKey)) {
      widget.showResultCallback();
      await preferences.setBool(FastPreferences.finishScreenShowedKey, true);
    } else {
      swiperController.next();
    }
  }
}
