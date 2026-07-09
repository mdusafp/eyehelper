library firebase_analytics;

import 'dart:collection';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import './analytics.dart';

export './analytics.dart' show Analytics, HttpAnalytics;

class AppAnalytics with HttpAnalytics, Analytics {
  FirebaseAnalytics? _analytics;
  HashMap<String, List<EventListener>>? _triggers;

  static final AppAnalytics _singleton = new AppAnalytics._internal();

  factory AppAnalytics() {
    return _singleton;
  }

  AppAnalytics._internal() {
    _analytics = FirebaseAnalytics.instance;
    _triggers = HashMap<String, List<EventListener>>();
  }

  @override
  void reportApiError({exception, Map<String, dynamic>? context}) {
    try {
      FirebaseCrashlytics.instance.recordError(exception, null, reason: context);
    } catch (e) {
      print("Unable to report error to Crashlytics ${e.toString()}");
    }
  }

  @override
  void sendEvent(String eventName, {Map<String, dynamic>? params, int? multiplicate}) {
    if (_analytics != null) {
      _analytics!.logEvent(name: eventName, parameters: params ?? {});
    }
    if (_triggers!.containsKey(eventName)) {
      for (EventListener listener in _triggers![eventName]!) {
        listener.onEvent(eventName, multiplicate: multiplicate);
      }
    }
  }

  void addListener(String eventName, EventListener listener) {
    if (!_triggers!.containsKey(eventName) || _triggers![eventName] == null) {
      _triggers![eventName] = <EventListener>[];
    }
    _triggers![eventName]!.add(listener);
  }

  void removeListener(String eventName, EventListener listener) {
    if (_triggers!.containsKey(eventName)) {
      _triggers![eventName]?.remove(listener);
    }
  }

  void removeListenerForAllEvents(EventListener listener) {
    _triggers!.forEach((eventName, listeners) {
      _triggers![eventName]?.remove(listener);
    });
  }
}

abstract class EventListener {
  void onEvent(String eventName, {int? multiplicate});
}
