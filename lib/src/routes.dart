import 'package:flutter/material.dart';
import 'package:eyehelper/src/screens/home_screen.dart';


class EyeHelperRoutes {
  static final home = '/';

  static Map<String, WidgetBuilder> get routes {
    return {
      EyeHelperRoutes.home: (_) => HomeScreen(),
    };
  }
}