import 'package:flutter/material.dart';
import 'package:eyehelper/src/routes.dart';
import 'package:eyehelper/src/screens/home_screen.dart';
import 'package:eyehelper/src/screens/profile_screen.dart';


class EyeHelperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eyehelper',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        EyeHelperRoutes.home: (_) => HomeScreen(),
        EyeHelperRoutes.profile: (_) => ProfileScreen(),
      },
    );
  }
}
