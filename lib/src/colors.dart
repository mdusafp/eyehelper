import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:flutter/material.dart';

class StandardStyleColors {
  static const Color activeColor = Color(0xFF509F75);
  static const Color lightGrey = Color(0xFF88949C);
  static const Color mainDark = Color(0xFF626262);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color btnTextWhite = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static Color black10 = Colors.black.withOpacity(0.1);
}

class StandardStyleTexts {
  static TextStyle headerMain = TextStyle( fontSize: 25, color: StandardStyleColors.activeColor, fontWeight: FontWeight.bold );
  static TextStyle counterTextStyle = headerMain.copyWith();
  static TextStyle eyeScreenHeader = TextStyle( fontSize: 19, color: StandardStyleColors.mainDark, fontWeight: FontWeight.bold );
  static TextStyle eyeScreenMainText = TextStyle( fontSize: 17, color: StandardStyleColors.mainDark, fontWeight: FontWeight.w600 );
  static TextStyle eyeScreenCountTxt = headerMain.copyWith( fontSize: 19 );
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