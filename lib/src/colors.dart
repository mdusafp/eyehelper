import 'package:flutter/material.dart';

/// TODO: move StandardStyleColors to theme
@Deprecated('Use EyehelperColorScheme')
class StandardStyleColors {
  static const Color activeColor = Color(0xFF509F75);
  static const Color lightGrey = Color(0xFF88949C);
  static const Color mainDark = Color(0xFF626262);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color btnTextWhite = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static Color black10 = Colors.black.withOpacity(0.1);
}

@Deprecated('Use Theme.of(context).textTheme')
class StandardStyleTexts {
  static TextStyle headerMain = TextStyle(
    fontSize: 25,
    color: StandardStyleColors.activeColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle counterTextStyle = headerMain.copyWith();
  static TextStyle eyeScreenHeader = TextStyle(
    fontSize: 22,
    color: StandardStyleColors.mainDark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle eyeScreenMainText = TextStyle(
    fontSize: 20,
    color: StandardStyleColors.mainDark,
    fontWeight: FontWeight.w300,
  );
  static TextStyle eyeScreenCountTxt = headerMain.copyWith(fontSize: 19);
  static TextStyle mainBtnText = TextStyle(
    fontSize: 23,
    color: StandardStyleColors.btnTextWhite,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );
  static TextStyle title = TextStyle(
    fontSize: 25,
    color: StandardStyleColors.lightGrey,
    fontWeight: FontWeight.bold,
  );
  static TextStyle display1 = TextStyle(
    fontSize: 14,
    height: 1.0,
    color: StandardStyleColors.lightGrey,
    fontWeight: FontWeight.normal,
  );
  static TextStyle display2 = TextStyle(
    fontSize: 15,
    height: 1.0,
    color: StandardStyleColors.lightGrey,
    fontWeight: FontWeight.normal,
  );
}

// TODO: extend ThemeData and add additional properties to allow smart configuration
@Deprecated('Use EyehelperTheme')
class StandardTheme {
  static ThemeData _theme = ThemeData(
    backgroundColor: StandardStyleColors.backgroundWhite,
    scaffoldBackgroundColor: StandardStyleColors.backgroundWhite,
    accentColor: StandardStyleColors.activeColor,
    primaryColor: StandardStyleColors.lightGrey,
    primaryColorDark: StandardStyleColors.mainDark,
  );

  static get theme => _theme;
}
