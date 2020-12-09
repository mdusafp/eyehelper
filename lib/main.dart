import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:eyehelper/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  
  tz.initializeTimeZones();
  Crashlytics.instance.enableInDevMode = !kReleaseMode;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(EyeHelperApp());
  }, onError: (error, stack) {
    print(error);
    print(stack);
    Crashlytics.instance.recordError(error, stack);
  });
}
