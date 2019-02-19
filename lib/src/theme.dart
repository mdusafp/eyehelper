import 'package:flutter/material.dart';
import 'package:eyehelper/src/constants.dart';


class EyeHelperTheme {
  static ThemeData get theme {
    return ThemeData.light()
      .copyWith(
        accentColor: const Color(PRIMARY_COLOR),
        primaryColor: const Color(PRIMARY_COLOR),
        scaffoldBackgroundColor: const Color(SECONDARY_COLOR),
      );
  }
}
