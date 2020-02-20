import 'dart:async';
import 'dart:ui';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/utils.dart';
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

    return Stack(
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Center(
                          child: Text(
                            Localizer.getLocaleById(widget.info.title, context),
                            style: textTheme.title.copyWith(color: Theme.of(context).primaryColorDark),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Center(
                          child: Text(
                            Localizer.getLocaleById(widget.info.mainText, context),
                            style: textTheme.subtitle.copyWith(color: Theme.of(context).primaryColorDark),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Text(
                          Localizer.getLocaleById(widget.info.durationText, context),
                          style: textTheme.title.copyWith(color: Theme.of(context).accentColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 10.0),
                        child: AnimatedFace(
                          info: widget.info,
                          isPaused: isFacePaused,
                          visible: isFaceVisible,
                          controller: isTrainingStarted ? this : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR + 40.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(bottom: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR + 30.0, child: getControls(context))
      ],
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
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: RoundCustomButton(
          parentSize: MediaQuery.of(context).size,
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
      if ((FastPreferences().prefs.getBool(FastPreferences.isVibrationEnabled) ?? true)) {
        Vibration.vibrate();
      }
    }

    if (widget.info.secondTextTime < relativeTime + 0.05 && widget.info.secondTextTime > relativeTime - 0.05) {
      setState(() => trainingText = Localizer.getLocaleById(widget.info.trainingSecondText, context));
      if ((FastPreferences().prefs.getBool(FastPreferences.isVibrationEnabled) ?? true)) {
        Vibration.vibrate();
      }
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
