import 'dart:async';
import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vibration/vibration.dart';

import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/screen_control_buttons.dart';
import 'package:eyehelper/src/widgets/animated_face.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';

class EyeSinglePage extends StatefulWidget {
  final SwiperScreenInfo info;
  final SwiperController controller;
  final Function startBtnCallback;
  final Function finishBtnCallback;

  const EyeSinglePage({
    Key key,
    @required this.info,
    @required this.controller,
    @required this.startBtnCallback,
    @required this.finishBtnCallback,
  }) : super(key: key);

  @override
  _EyeSinglePageState createState() => _EyeSinglePageState();
}

class _EyeSinglePageState extends State<EyeSinglePage> implements FlareController {
  bool isFacePaused = false;
  bool isFaceVisible = true;
  bool isTrainingStarted = false;

  ActorAnimation _face;
  double _faceAmount = 1.0;
  double _speed = 1.0;
  double _faceTime = 0.0;

  int _counter = 0;
  Timer counterTimer;

  String trainingText = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
              child: Text(
                Localizer.getLocaleById(widget.info.title, context),
                style: textTheme.title,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                Localizer.getLocaleById(widget.info.mainText, context),
                style: textTheme.subtitle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AnimatedFace(
                info: widget.info,
                isPaused: isFacePaused,
                visible: isFaceVisible,
                controller: isTrainingStarted ? this : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                Localizer.getLocaleById(widget.info.durationText, context),
                textAlign: TextAlign.center,
              ),
            ),
            getControls(context),
          ],
        ),
      ),
    );
  }

  getControls(BuildContext context) {
    if (isTrainingStarted) {
      return ScreenControlButtons(
        stopped: !isTrainingStarted,
        paused: isFacePaused,
        text: trainingText,
        finishCallback: _finishCallback,
        pauseResumeCallback: () {
          setState(() => isFacePaused = !isFacePaused);
        },
        callbackStartFace: () {
          setState(() {
            isFaceVisible = true;
          });
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      height: 40.0,
      child: RoundCustomButton(
        onPressed: () {
          setState(() {
            isFaceVisible = false;
            isTrainingStarted = true;
          });
          widget.startBtnCallback();
        },
        child: Text(
          Localizer.getLocaleById(LocaleId.begin_btn_txt, context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  _finishCallback() {
    setState(() {
      isTrainingStarted = false;
    });
    widget.finishBtnCallback();
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _faceTime += elapsed * _speed;
    double relativeTime = _faceTime % _face.duration;
    _face.apply(relativeTime, artboard, _faceAmount);

    if (widget.info.firstTextTime < relativeTime + 0.05 && widget.info.firstTextTime > relativeTime - 0.05) {
      setState(() => trainingText = Localizer.getLocaleById(widget.info.trainingFirstText, context));
      Vibration.vibrate();
    }

    if (widget.info.secondTextTime < relativeTime + 0.05 && widget.info.secondTextTime > relativeTime - 0.05) {
      setState(() => trainingText = Localizer.getLocaleById(widget.info.trainingSecondText, context));
      Vibration.vibrate();
    }

    if (relativeTime >= widget.info.duration - 0.02 && counterTimer == null) {
      counterTimer = Timer(Duration(milliseconds: 300), () {
        counterTimer.cancel();
        counterTimer = null;
      });

      _counter += 1;

      print('counter = $_counter');

      if (_counter >= widget.info.times) {
        _counter = 0;
        _finishCallback();
        print('finished');
      }
    }
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _face = artboard.getAnimation(widget.info.trainingAnimationName);
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  ValueNotifier<bool> isActive;
}
