import 'package:eyehelper/src/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Custom raised button

class RoundCustomButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Function onPressed;
  final BoxShadow shadow;

  const RoundCustomButton({
    Key key,
    @required this.child,
    this.shadow = const BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0.0, 3.0),
      blurRadius: 6.0,
    ),
    this.width = double.infinity,
    this.height = 50.0,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: StandartStyle.activeColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          shadow
        ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
            onTap: onPressed,
            customBorder: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            child: Center(
              child: child,
            )),
      ),
    );
  }
}