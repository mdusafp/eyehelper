import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/routes.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EyeHelperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // FIXME: make toolbar black
    return MaterialApp(
      title: 'Eyehelper',
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: EyehelperTheme.makeTheme(),
      supportedLocales: Localizer.supportedLangs,
      debugShowCheckedModeBanner: false,
      routes: EyeHelperRoutes.routes,
    );
  }
}
