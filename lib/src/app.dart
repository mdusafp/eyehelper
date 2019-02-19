import 'package:flutter/material.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/routes.dart';


class EyeHelperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eyehelper',
      debugShowCheckedModeBanner: false,
      theme: EyeHelperTheme.theme,
      routes: EyeHelperRoutes.routes,
    );
  }
}
