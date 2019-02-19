import 'package:flutter/material.dart';
import 'package:eyehelper/src/screens/auth_screen.dart';
import 'package:eyehelper/src/screens/home_screen.dart';
import 'package:eyehelper/src/screens/profile_screen.dart';


class EyeHelperRoutes {
  static final home = '/';
  static final auth = '/auth';
  static final profile = '/profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      EyeHelperRoutes.home: (_) => HomeScreen(),
      EyeHelperRoutes.auth: (_) => AuthScreen(),
      EyeHelperRoutes.profile: (_) => ProfileScreen(),
    };
  }
}