import 'package:eyehelper/src/utils.dart';
import 'package:flutter/material.dart';

class EyehelperColorScheme {
  static const Color activeColor = Color(0xff509f75);
  static const Color lightGrey = Color(0xFF88949C);
  static const Color mainDark = Color(0xFF626262);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color btnTextWhite = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFFFCC00);
  static const Color transparent = Colors.transparent;
  static Color black10 = Colors.black.withOpacity(0.1);
}

class EyehelperTheme {
  static const String fontFamily = 'FiraSans';

  static ThemeData makeTheme() {
    return new ThemeData(
      brightness: Brightness.light,
      backgroundColor: EyehelperColorScheme.backgroundWhite,
      scaffoldBackgroundColor: EyehelperColorScheme.backgroundWhite,
      accentColor: EyehelperColorScheme.activeColor,
      primaryColor: EyehelperColorScheme.lightGrey,
      primaryColorDark: EyehelperColorScheme.mainDark,
      accentColorBrightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: ScreenUtil().setSp(10.0),
          height: 1.0,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        subtitle2: TextStyle(
          fontSize: ScreenUtil().setSp(9.0),
          height: 1.0,
          fontWeight: FontWeight.w200,
          fontFamily: fontFamily,
        ),
        headline5: TextStyle(
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        bodyText2: TextStyle(
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        bodyText1: TextStyle(
          fontSize: ScreenUtil().setSp(7.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        button: TextStyle(
          color: EyehelperColorScheme.backgroundWhite,
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline4: TextStyle(
          fontSize: ScreenUtil().setSp(7.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline3: TextStyle(
          fontSize: ScreenUtil().setSp(6.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline2: TextStyle(
          fontSize: ScreenUtil().setSp(5.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headline1: TextStyle(
          fontSize: ScreenUtil().setSp(4.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
