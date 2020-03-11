import 'dart:async';

import 'package:eyehelper/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();

  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(EyeHelperApp());
  }, onError: Crashlytics.instance.recordError);
}
