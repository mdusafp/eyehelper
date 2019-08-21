import 'package:eyehelper/src/colors.dart';
import 'package:flutter/material.dart';

class RoundControlButton extends StatelessWidget {
  final Function callback;
  final String imagePath;
  static final double BTN_DIAMETER = 50.0;

  const RoundControlButton({
    Key key,
    @required this.callback,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 50.0,
        child: InkWell(
          splashColor: StandardStyleColors.black10,
          highlightColor: StandardStyleColors.black10,
          customBorder: CircleBorder(),
          onTap: () => callback(),
          child: Center(
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BTN_DIAMETER),
                border: Border.all(
                  color: StandardStyleColors.activeColor,
                  width: 5,
                ),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 20.0,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
