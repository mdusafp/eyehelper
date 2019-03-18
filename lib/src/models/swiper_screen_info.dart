import 'package:flutter/material.dart';

class SwiperScreenInfo{

  final String flareName;
  final String animationName;
  final String fakeImgName;
  final String title;
  final String mainText;
  final String durationText;

  const SwiperScreenInfo({
    @required this.flareName,
    @required this.animationName,
    @required this.fakeImgName,
    @required this.title,
    @required this.mainText,
    @required this.durationText
  });


  static const Map<int, SwiperScreenInfo> flareActorByIndex = {
    0: SwiperScreenInfo(
        flareName: 'assets/lrtbFaceFast.flr',
        animationName: 'fastTopBot',
        fakeImgName: 'assets/firstImageFace1.png',
        title: 'vertical_movements',
        mainText: 'turn_eyes_up_down',
        durationText: 'retry_three_times'
    ),
    1: SwiperScreenInfo(
        flareName: 'assets/lrtbFaceFast.flr',
        animationName: 'fastLeftRight',
        fakeImgName: 'assets/firstImageFace1.png',
        title: 'horizontal_movements',
        mainText: 'turn_eyes_left_right',
        durationText: 'retry_three_times'
    ),
    2: SwiperScreenInfo(
        flareName: 'assets/screwUpFast.flr',
        animationName: 'screwUp',
        fakeImgName: 'assets/firstImageFace3.png',
        title: 'screw_up_movements',
        mainText: 'screw_up_your_eyes',
        durationText: 'retry_three_times'
    ),
    3: SwiperScreenInfo(
        flareName: 'assets/blinkingFast.flr',
        animationName: 'blinkingFast',
        fakeImgName: 'assets/firstImageFace4.png',
        title: 'blinking_movements',
        mainText: 'blink_fast_20_times',
        durationText: 'retry_one_time'
    ),
    4: SwiperScreenInfo(
        flareName: 'assets/farSeingFast.flr',
        animationName: 'farSeeing',
        fakeImgName: 'assets/firstImageFace5.png',
        title: 'focus_movements',
        mainText: 'focus_for_10_sec',
        durationText: 'retry_three_times'
    ),
    5: SwiperScreenInfo(
        flareName: 'assets/palmingFast.flr',
        animationName: 'palming',
        fakeImgName: 'assets/firstImageFace6.png',
        title: 'palming_movements',
        mainText: 'rub_hands_and_attach_to_eyes',
        durationText: 'retry_three_times'
    ),
  };

}