import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

class SwiperScreenInfo{

  final String flareName;
  final String animationName;
  final String fakeImgName;
  final LocaleId title;
  final LocaleId mainText;
  final LocaleId durationText;
  final LocaleId trainingFirstText;
  final LocaleId trainingSecondText;
  final List<double> vibrations;
  final double duration;
  final double firstTextTime;
  final double secondTextTime;
  final String trainingAnimationName;
  final int times;

  const SwiperScreenInfo({
    @required this.flareName,
    @required this.animationName,
    @required this.fakeImgName,
    @required this.title,
    @required this.mainText,
    @required this.durationText,
    @required this.vibrations,
    @required this.duration,
    @required this.firstTextTime,
    @required this.secondTextTime,
    @required this.trainingAnimationName,
    @required this.times,
    @required this.trainingFirstText,
    @required this.trainingSecondText,
  });


  //App configuration
  static const Map<int, SwiperScreenInfo> flareActorByIndex = {
    0: SwiperScreenInfo(
      vibrations: [
        0.67,
        3.67,
        5.33,
        8.33
      ],
      duration: 9.0,
      times: 3,
      trainingAnimationName: 'trainingTopBot',
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastTopBot',
      fakeImgName: 'assets/firstImageFace1.png',
      title: LocaleId.vertical_movements,
      mainText: LocaleId.turn_eyes_up_down,
      durationText: LocaleId.retry_three_times,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.watch_up,
      secondTextTime: 4.5,
      trainingSecondText: LocaleId.watch_down,
    ),
    1: SwiperScreenInfo(
      vibrations: [
        0.67,
        3.67,
        5.33,
        8.33
      ],
      duration: 9.0,
      times: 3,
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastLeftRight',
      trainingAnimationName: 'trainingLeftRight',
      fakeImgName: 'assets/firstImageFace1.png',
      title: LocaleId.horizontal_movements,
      mainText: LocaleId.turn_eyes_left_right,
      durationText: LocaleId.retry_three_times,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.watch_left,
      secondTextTime: 4.5,
      trainingSecondText: LocaleId.watch_right,
    ),
    2: SwiperScreenInfo(
      vibrations: [
        0.0,
        10.0,
      ],
      duration: 18.0,
      times: 3,
      flareName: 'assets/screwUpFast.flr',
      animationName: 'screwUp',
      trainingAnimationName: 'trainingScrewUp',
      fakeImgName: 'assets/firstImageFace3.png',
      title: LocaleId.screw_up_movements,
      mainText: LocaleId.screw_up_your_eyes,
      durationText: LocaleId.retry_three_times,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.screw_up,
      secondTextTime: 10.0,
      trainingSecondText: LocaleId.relax_eyes,
    ),
    3: SwiperScreenInfo(
      vibrations: [
        0.0,
        0.167
      ],
      duration: 0.33,
      times: 25,
      flareName: 'assets/blinkingFast.flr',
      animationName: 'blinkingFast',
      trainingAnimationName: 'trainingBlinking',
      fakeImgName: 'assets/firstImageFace4.png',
      title: LocaleId.blinking_movements,
      mainText: LocaleId.blink_fast_20_times,
      durationText: LocaleId.retry_twenty_five_time,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.fast_blink,
      secondTextTime: 0.167,
      trainingSecondText: LocaleId.fast_blink,
    ),
    4: SwiperScreenInfo(
      vibrations: [
        0.0,
        10.0
      ],
      duration: 20.0,
      times: 3,
      flareName: 'assets/farSeingFast.flr',
      animationName: 'farSeeing',
      trainingAnimationName: 'trainingFarSeeing',
      fakeImgName: 'assets/firstImageFace5.png',
      title: LocaleId.focus_movements,
      mainText: LocaleId.focus_for_10_sec,
      durationText: LocaleId.retry_three_times,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.watch_far,
      secondTextTime: 10.0,
      trainingSecondText: LocaleId.watch_near,
    ),
    5: SwiperScreenInfo(
      vibrations: [
        0.0,
        9.0,
      ],
      duration: 25.0,
      times: 3,
      flareName: 'assets/palmingFast.flr',
      animationName: 'palming',
      trainingAnimationName: 'trainingPalming',
      fakeImgName: 'assets/firstImageFace6.png',
      title: LocaleId.palming_movements,
      mainText: LocaleId.rub_hands_and_attach_to_eyes,
      durationText: LocaleId.retry_three_times,
      firstTextTime: 0.0,
      trainingFirstText: LocaleId.rub_hands,
      secondTextTime: 9.0,
      trainingSecondText: LocaleId.apply_to_eyes,
    ),
  };

}