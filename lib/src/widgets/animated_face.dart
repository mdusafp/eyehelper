import 'package:eyehelper/src/anim/sprite_actor.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:flutter/material.dart';

/// The exercise face — the sprite animation, square, [size] on a side.
class AnimatedFace extends StatelessWidget {
  final SwiperScreenInfo info;
  final SpriteController? controller;
  final bool isPaused;
  final double size;

  const AnimatedFace({
    super.key,
    required this.info,
    required this.controller,
    this.isPaused = false,
    this.size = 176,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SpriteActor(
        sheet: info.sprites,
        controller: controller,
        isPaused: isPaused,
        animation: info.animationName,
      ),
    );
  }
}
