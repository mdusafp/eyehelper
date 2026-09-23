import 'package:eyehelper/src/anim/face_sprites.g.dart';
import 'package:eyehelper/src/anim/sprite_sheet.dart';

class SwiperScreenInfo {
  final SpriteSheet sprites;
  final String animationName;
  final String fakeImgName;
  final String title;
  final String mainText;
  final String trainingFirstText;
  final String trainingSecondText;
  final List<double> vibrations;
  final double duration;
  final double firstTextTime;
  final double secondTextTime;
  final String trainingAnimationName;
  final int times;

  const SwiperScreenInfo({
    required this.sprites,
    required this.animationName,
    required this.fakeImgName,
    required this.title,
    required this.mainText,
    required this.vibrations,
    required this.duration,
    required this.firstTextTime,
    required this.secondTextTime,
    required this.trainingAnimationName,
    required this.times,
    required this.trainingFirstText,
    required this.trainingSecondText,
  });

  //App configuration
  static const Map<int, SwiperScreenInfo> flareActorByIndex = {
    0: SwiperScreenInfo(
      vibrations: [0.67, 3.67, 5.33, 8.33],
      duration: 9.0,
      times: 3,
      trainingAnimationName: 'trainingTopBot',
      sprites: lrtbFaceSprites,
      animationName: 'fastTopBot',
      fakeImgName: 'assets/firstImageFace1.png',
      title: 'exercises.verticalMovements',
      mainText: 'exercises.turnEyesUpDown',
      firstTextTime: 0.0,
      trainingFirstText: 'training.watchUp',
      secondTextTime: 4.5,
      trainingSecondText: 'training.watchDown',
    ),
    1: SwiperScreenInfo(
      vibrations: [0.67, 3.67, 5.33, 8.33],
      duration: 9.0,
      times: 3,
      sprites: lrtbFaceSprites,
      animationName: 'fastLeftRight',
      trainingAnimationName: 'trainingLeftRight',
      fakeImgName: 'assets/firstImageFace1.png',
      title: 'exercises.horizontalMovements',
      mainText: 'exercises.turnEyesLeftRight',
      firstTextTime: 0.0,
      trainingFirstText: 'training.watchLeft',
      secondTextTime: 4.5,
      trainingSecondText: 'training.watchRight',
    ),
    2: SwiperScreenInfo(
      vibrations: [
        0.0,
        10.0,
      ],
      duration: 18.0,
      times: 3,
      sprites: screwUpSprites,
      animationName: 'screwUp',
      trainingAnimationName: 'trainingScrewUp',
      fakeImgName: 'assets/firstImageFace3.png',
      title: 'exercises.screwUpMovements',
      mainText: 'exercises.screwUpYourEyes',
      firstTextTime: 0.0,
      trainingFirstText: 'training.screwUp',
      secondTextTime: 10.0,
      trainingSecondText: 'training.relaxEyes',
    ),
    3: SwiperScreenInfo(
      vibrations: [0.0, 8.0],
      // Eight seconds of blinking, four of rest — three rounds like the rest.
      duration: 12.0,
      times: 3,
      sprites: blinkingSprites,
      animationName: 'blinkingFast',
      trainingAnimationName: 'trainingBlinking',
      fakeImgName: 'assets/firstImageFace4.png',
      title: 'exercises.blinkingMovements',
      mainText: 'exercises.blinkFast',
      firstTextTime: 0.0,
      trainingFirstText: 'training.fastBlink',
      secondTextTime: 8.0,
      trainingSecondText: 'training.relaxEyes',
    ),
    4: SwiperScreenInfo(
      vibrations: [0.0, 10.0],
      duration: 20.0,
      times: 3,
      sprites: farSeeingSprites,
      animationName: 'farSeeing',
      trainingAnimationName: 'trainingFarSeeing',
      fakeImgName: 'assets/firstImageFace5.png',
      title: 'exercises.focusMovements',
      mainText: 'exercises.focusFor10Sec',
      firstTextTime: 0.0,
      trainingFirstText: 'training.watchFar',
      secondTextTime: 10.0,
      trainingSecondText: 'training.watchNear',
    ),
    5: SwiperScreenInfo(
      vibrations: [
        0.0,
        9.0,
      ],
      duration: 25.0,
      times: 3,
      sprites: palmingSprites,
      animationName: 'palming',
      trainingAnimationName: 'trainingPalming',
      fakeImgName: 'assets/firstImageFace6.png',
      title: 'exercises.palmingMovements',
      mainText: 'exercises.rubHandsAndAttach',
      firstTextTime: 0.0,
      trainingFirstText: 'training.rubHands',
      secondTextTime: 9.0,
      trainingSecondText: 'training.applyToEyes',
    ),
  };
}
