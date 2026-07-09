import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:eyehelper/firebase_options.dart';
import 'package:eyehelper/src/app.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // Preferences are read synchronously all over the UI, so they must be
    // ready before the first frame.
    await FastPreferences().init();

    ErrorWidget.builder = (FlutterErrorDetails details) => Container();

    tz.initializeTimeZones();

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(EyeHelperApp());
  }, (error, stack) {
    print(error);
    print(stack);
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
  });
}
