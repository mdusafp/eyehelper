import 'package:flutter/material.dart';

class EyehelperColorScheme {
  static const Color activeColor = Color(0xFF509F75);
  static const Color lightGrey = Color(0xFF88949C);
  static const Color mainDark = Color(0xFF626262);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color btnTextWhite = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static Color black10 = Colors.black.withOpacity(0.1);
}

class EyehelperTheme {
  static ThemeData makeTheme() {
    return new ThemeData(
      backgroundColor: EyehelperColorScheme.backgroundWhite,
      scaffoldBackgroundColor: EyehelperColorScheme.backgroundWhite,
      accentColor: EyehelperColorScheme.activeColor,
      primaryColor: EyehelperColorScheme.lightGrey,
      primaryColorDark: EyehelperColorScheme.mainDark,
      textTheme: TextTheme(
        display1: TextStyle(
          fontSize: 32.0,
          height: 1.0,
          fontWeight: FontWeight.normal,
        ),
        display2: TextStyle(
          fontSize: 28.0,
          height: 1.0,
          fontWeight: FontWeight.normal,
        ),
        display3: TextStyle(
          fontSize: 24.0,
          height: 1.0,
          fontWeight: FontWeight.normal,
        ),
        display4: TextStyle(
          fontSize: 17.0,
          height: 1.0,
          fontWeight: FontWeight.normal,
        ),
        button: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        title: TextStyle(
          fontSize: 15.0,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        subhead: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
        ),
        body2: TextStyle(
          fontSize: 16.0,
          height: 1.5,
          fontWeight: FontWeight.normal,
        ),
        body1: TextStyle(
          fontSize: 15.0,
          height: 1.4,
          fontWeight: FontWeight.normal,
        ),
        caption: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        ),
        subtitle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.normal,
        ),
        overline: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
