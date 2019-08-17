import 'dart:async';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/screen_control_buttons.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/animated_face.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:eyehelper/src/widgets/round_control_button.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vibration/vibration.dart';

class EyeSinglePage extends StatefulWidget {

  final SwiperScreenInfo info;
  final SwiperController controller;
  final Function callbackBtnPressed;

  const EyeSinglePage({Key key, @required this.info, @required this.controller, @required this.callbackBtnPressed}) : super(key: key);

  @override
  _EyeSinglePageState createState() => _EyeSinglePageState();
}

class _EyeSinglePageState extends State<EyeSinglePage> implements FlareController{

  bool isFacePaused = false;
  bool isFaceVisible = true;
  bool isTrainingStarted = false;

  ActorAnimation _face;
  double _faceAmount = 1.0;
  double _speed = 1.0;
  double _faceTime = 0.0;

  Timer timer;

  String trainingText = '';

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: wv(10.0), right: wv(10.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: hv(110.0),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: hv(18.0), bottom: hv(6.0), left: wv(20.0), right: wv(20.0)),
                        child: Center(
                            child: Text(
                                Localizer.getLocaleById(widget.info.title, context),
                                style: StandardStyleTexts.eyeScreenHeader,
                                textAlign: TextAlign.center)
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: hv(6.0), bottom: hv(6.0), left: wv(20.0), right: wv(20.0)),
                        child: Center(
                          child: Text(
                              Localizer.getLocaleById(widget.info.mainText, context),
                              style: StandardStyleTexts.eyeScreenMainText,
                              textAlign: TextAlign.center),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: hv(6.0), bottom: hv(6.0), left: wv(20.0), right: wv(20.0)),
                        child: Text(Localizer.getLocaleById(widget.info.durationText, context), style: StandardStyleTexts.eyeScreenCountTxt, textAlign: TextAlign.center),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: hv(6.0), bottom: hv(10.0)),
                        child: AnimatedFace(info: widget.info, isPaused: isFacePaused, visible: isFaceVisible, controller: isTrainingStarted ? this : null)
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: hv(10.0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: hv(160.0),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: wv(130.0),
          child: getControls(context)
        )
      ],
    );
  }


  getControls(BuildContext context){


    if (isTrainingStarted){
      return ScreenControlButtons(
        stopped: !isTrainingStarted,
        paused: isFacePaused,
        text: trainingText,
        finishCallback: (){
          setState(() {
            isTrainingStarted = false;
          });
          widget.controller.next();
        },
        pauseResumeCallback: (){
          setState(() => isFacePaused = !isFacePaused);
        },
        callbackStartFace: (){
          setState(() {
            isFaceVisible = true;
          });
        },
      );
    }

    return Container(
        padding: EdgeInsets.only(left: 70, right: 70),
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: RoundCustomButton(
          onPressed: (){
            setState(() {
              isFaceVisible = false;
              isTrainingStarted = true;
            });
          },
          child: Text(Localizer.getLocaleById('begin_btn_txt', context), style: StandardStyleTexts.mainBtnText),
        )
    );

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

