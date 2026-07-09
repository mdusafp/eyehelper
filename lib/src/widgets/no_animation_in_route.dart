import 'dart:io';

import 'package:flutter/material.dart';

class NoAnimationInSlideOut extends PageRouteBuilder {
  final Widget child;

  static final Tween<Offset> _bottomUpTween = Tween<Offset>(
    begin: const Offset(0.0, 0.25),
    end: Offset.zero,
  );
  static final Animatable<double> _fastOutSlowInTween = CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  NoAnimationInSlideOut({required this.child})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
            if (animation.status == AnimationStatus.forward) {
              return child;
            } else {
              //Here are builded native dialog transition for every platform.

              var _positionAnimation = animation.drive(_bottomUpTween.chain(_fastOutSlowInTween));
              var _opacityAnimation = animation.drive(_easeInTween);

              if (Platform.isAndroid) {
                return SlideTransition(
                  position: _positionAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: child,
                  ),
                );
              }

              //if iOS
              var _animation = CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
                reverseCurve: Curves.ease.flipped,
              );
              var _offsetTween = Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              );

              return Align(
                alignment: Alignment.bottomCenter,
                child: FractionalTranslation(
                  translation: _offsetTween.evaluate(_animation),
                  child: child,
                ),
              );
            }
          },
        );
}
