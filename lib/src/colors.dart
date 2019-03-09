import 'package:flutter/material.dart';

class StandardStyleColors {
  static const Color activeColor = Color(0xFF509F75);
  static const Color lightGrey = Color(0xFF88949C);
  static const Color mainDark = Color(0xFF626262);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color btnTextWhite = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
}

class StandardStyleTexts {
  static TextStyle headerMain = TextStyle( fontSize: 25.0, color: StandardStyleColors.activeColor, fontWeight: FontWeight.bold );
  static TextStyle eyeScreenHeader = TextStyle( fontSize: 20.0, color: StandardStyleColors.mainDark, fontWeight: FontWeight.bold );
  static TextStyle eyeScreenMainText = TextStyle( fontSize: 18.0, color: StandardStyleColors.mainDark, fontWeight: FontWeight.normal );
  static TextStyle eyeScreenCountTxt = headerMain.copyWith( fontSize: 20 );
  static TextStyle mainBtnText = TextStyle( fontSize: 16, color: StandardStyleColors.btnTextWhite, fontWeight: FontWeight.bold, letterSpacing: 1.1 );
}


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