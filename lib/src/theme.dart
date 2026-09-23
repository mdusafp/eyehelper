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

  /// Sizes are logical points, the same on every device. Flutter already
  /// scales them with the system text size; nothing here should scale with
  /// the screen.
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
      textTheme: const TextTheme(
        // Screen titles.
        titleLarge: TextStyle(
          fontSize: 24,
          height: 1.0,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        // Light-weight subtitles and, via copyWith, the big figures.
        titleSmall: TextStyle(
          fontSize: 20,
          height: 1.0,
          fontWeight: FontWeight.w200,
          fontFamily: fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          height: 1.0,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        // Buttons.
        labelLarge: TextStyle(
          color: EyehelperColorScheme.backgroundWhite,
          fontSize: 16,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 14,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 11,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
        displayLarge: TextStyle(
          fontSize: 10,
          height: 1.0,
          fontWeight: FontWeight.normal,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
