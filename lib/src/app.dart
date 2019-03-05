import 'package:flutter/material.dart';
import 'package:eyehelper/src/routes.dart';
import 'package:flutter/services.dart';


class EyeHelperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return MaterialApp(
      title: 'Eyehelper',
      debugShowCheckedModeBanner: false,
      routes: EyeHelperRoutes.routes,
    );
  }
}
