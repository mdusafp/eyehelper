import 'dart:ui';
import 'package:eyehelper/i18n/strings.g.dart';
import 'package:eyehelper/src/routes.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/utils.dart';
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

    Utils().init(window);

    return MaterialApp(
      title: 'Eye Helper',
      locale: TranslationProvider.of(context).flutterLocale,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocaleUtils.supportedLocales,
      theme: EyehelperTheme.makeTheme(),
      debugShowCheckedModeBanner: false,
      routes: EyeHelperRoutes.routes,
    );
  }
}
