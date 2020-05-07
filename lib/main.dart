import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:eyehelper/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();

  Crashlytics.instance.enableInDevMode = !kReleaseMode;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(EyeHelperApp());
  }, onError: Crashlytics.instance.recordError);
}
