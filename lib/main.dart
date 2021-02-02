import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:eyehelper/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ErrorWidget.builder = (FlutterErrorDetails details) => Container();

  tz.initializeTimeZones();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(EyeHelperApp());
  }, onError: (error, stack) {
    print(error);
    print(stack);
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
  });
}
