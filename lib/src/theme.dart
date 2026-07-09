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
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: EyehelperColorScheme.activeColor,
        secondary: EyehelperColorScheme.activeColor,
        surface: EyehelperColorScheme.backgroundWhite,
        error: EyehelperColorScheme.errorColor,
      ),
      scaffoldBackgroundColor: EyehelperColorScheme.backgroundWhite,
      primaryColor: EyehelperColorScheme.lightGrey,
      primaryColorDark: EyehelperColorScheme.mainDark,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: ScreenUtil().setSp(10.0),
          height: 1.0,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: ScreenUtil().setSp(9.0),
          height: 1.0,
          fontWeight: FontWeight.w200,
          fontFamily: fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: ScreenUtil().setSp(7.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        labelLarge: TextStyle(
          color: EyehelperColorScheme.backgroundWhite,
          fontSize: ScreenUtil().setSp(8.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: ScreenUtil().setSp(7.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: ScreenUtil().setSp(6.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: ScreenUtil().setSp(5.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displayLarge: TextStyle(
          fontSize: ScreenUtil().setSp(4.0),
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
