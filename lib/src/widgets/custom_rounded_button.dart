import 'dart:math';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom raised button
class RoundCustomButton extends StatelessWidget {
  final Size parentSize;
  final Widget child;
  final double? width;
  final double heightAbs;
  final Function onPressed;
  final BoxShadow shadow;

  const RoundCustomButton({
    Key? key,
    required this.parentSize,
    required this.child,
    this.shadow = const BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0.0, 3.0),
      blurRadius: 6.0,
    ),
    this.width,
    this.heightAbs = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? min(240.0, parentSize.width),
      height: this.heightAbs,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [shadow],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(),
          customBorder: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class FlatRoundCustomButton extends StatelessWidget {
  final Size parentSize;
  final Widget child;
  final double? width;
  final double heightAbs;
  final Function onPressed;
  final Color? color;

  const FlatRoundCustomButton({
    Key? key,
    required this.parentSize,
    required this.child,
    this.width,
    this.color,
    this.heightAbs = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? min(240.0, parentSize.width),
      height: this.heightAbs,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          width: 1.5,
          color: color ?? Theme.of(context).accentColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(),
          customBorder: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
