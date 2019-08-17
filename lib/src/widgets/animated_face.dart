import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class AnimatedFace extends StatelessWidget{

  SwiperScreenInfo info;
  FlareController controller;
  bool isPaused;
  bool visible;



  AnimatedFace({Key key, this.info, this.isPaused = false, this.visible = true, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160.0,
        width: 160.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(info.fakeImgName, alignment: Alignment.center),
            visible ? FlareActor(
              info.flareName,
              controller: controller,
              isPaused: isPaused,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: info.animationName,
            ) : Container()
          ],
        )
    );
  }


}
