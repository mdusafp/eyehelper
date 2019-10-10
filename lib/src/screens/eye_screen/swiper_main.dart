import 'dart:convert';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_single_page.dart';
import 'package:eyehelper/src/screens/eye_screen/swiper_pagination.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'finish_training_screen.dart';

class SwiperMain extends StatefulWidget {

  final Function showResultCallback;

  const SwiperMain({Key key, this.showResultCallback}) : super(key: key);

  @override
  _SwiperMainState createState() => new _SwiperMainState();

}

class _SwiperMainState extends State<SwiperMain> {

  int swiperIndex = 0;

  SwiperController swiperController = SwiperController();
  DateTime dateTimeNow;
  DateFormat formatter;
  String formatted;
  TodayTrainingCounters countersHelper = TodayTrainingCounters();

  bool _isLoading = true;

  @override
  void initState() {
    
    countersHelper.init(SwiperScreenInfo.flareActorByIndex.length).then((_){
      setState(() {
        _isLoading = false;
      });
    });

    dateTimeNow = DateTime.now();
    formatter = new DateFormat('yyyy-MM-dd');
    formatted = formatter.format(dateTimeNow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    Widget swiper = new Swiper(
      onIndexChanged: (index) {
        setState(() => swiperIndex = index);
      },
      controller: swiperController,
      loop:false,
      pagination: new SwiperPagination(
          margin: EdgeInsets.only(bottom: 100.0),
          builder: CustomSwiperBuilder(
              color: Colors.grey,
              space: 10.0,
              size: 6.0,
              activeSize: 8.0,
              activeColor: StandardStyleColors.activeColor
          )
      ),
      itemBuilder: (BuildContext context, int index) {
        SwiperScreenInfo info = SwiperScreenInfo.flareActorByIndex[index];

        return EyeSinglePage(
          info: info, 
          controller: swiperController, 
          startBtnCallback: () => _processStart(index),
          finishBtnCallback: _processFinish
        );
          
      },
      itemCount: SwiperScreenInfo.flareActorByIndex.length,
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Material(
        color: Colors.white,
          child: new Container(
              child: Stack(
                  children: <Widget>[
                    swiper
                  ]
              )
          )
      ),
    );
  }



  _processStart(index) async {            
    var preferences = FastPreferences().prefs;

    String dayCountersJson = preferences.getString('day_counters');
    Map<String, dynamic> dayCountersMap;
    if (dayCountersJson == null){
      dayCountersMap = {};
    } else {
      dayCountersMap = (json.decode(dayCountersJson) as Map<String, dynamic>);
    }
    
    dayCountersMap[formatted] = (dayCountersMap[formatted] ?? 0) + 1;
    dayCountersMap.removeWhere((key, value) => 
      dateTimeNow.difference(formatter.parse(key)).abs() > Duration(days: 365).abs());
    await preferences.setString('day_counters', json.encode(dayCountersMap));

    await countersHelper.setPassed(index);

    print('counters = $dayCountersMap');
  }

  _processFinish() async {
    var preferences = FastPreferences().prefs;

    if (await countersHelper.checkFinishedAll() && 
      !preferences.getBool('finish_screen_showed')){

      widget.showResultCallback();
        await preferences.setBool('finish_screen_showed', true);
        
    } else {
      swiperController.next();
    }
  }
}


