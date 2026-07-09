import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

class AnimatedFace extends StatelessWidget {
  final SwiperScreenInfo info;
  final FlareController? controller;
  final bool isPaused;
  final bool visible;

  AnimatedFace({
    Key? key,
    required this.info,
    this.isPaused = false,
    this.visible = true,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        height: 160.0 * (Utils().IS_SMALL_DEVICE ? 3 / 4 : 1),
        width: 160.0 * (Utils().IS_SMALL_DEVICE ? 3 / 4 : 1),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(info.fakeImgName, alignment: Alignment.center),
            visible
                ? FlareActor(
                    info.flareName,
                    controller: controller,
                    isPaused: isPaused,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: info.animationName,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
