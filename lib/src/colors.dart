import 'package:flutter/material.dart';

class StandardStyleColors {
  static Color activeColor = Color(0xFF509F75);
  static Color lightGrey = Color(0xFF88949C);
  static Color mainDark = Color(0xFF626262);
  static Color backgroundWhite = Color(0xFFFFFFFF);
  static Color btnTextWhite = Color(0xFFFFFFFF);

  static Color transparent = Colors.transparent;
}

class StandardStyleTexts {
  static TextStyle headerMain = TextStyle( fontSize: 25.0, color: StandardStyleColors.activeColor, fontWeight: FontWeight.bold );
  static TextStyle eyeScreenHeader = TextStyle( fontSize: 20.0, color: StandardStyleColors.mainDark, fontWeight: FontWeight.bold );
  static TextStyle eyeScreenMainText = TextStyle( fontSize: 18.0, color: StandardStyleColors.mainDark, fontWeight: FontWeight.normal );
  static TextStyle eyeScreenCountTxt = headerMain.copyWith( fontSize: 20 );
  static TextStyle mainBtnText = TextStyle( fontSize: 16, color: StandardStyleColors.btnTextWhite, fontWeight: FontWeight.bold, letterSpacing: 1.1 );
}