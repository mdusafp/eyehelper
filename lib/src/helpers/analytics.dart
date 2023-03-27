library analytics;

import 'package:eyehelper/src/helpers/firebase_analytics.dart';

/// [Analytics] interface
mixin Analytics {
  void sendEvent(String eventName, {Map<String, dynamic> params, int multiplicate});
}

/// [HttpAnalytics] interface
mixin HttpAnalytics {
  void reportApiError({dynamic exception, Map<String, dynamic> context});
}

class AnalyticsHelper {
  static void sendEvent(String eventName, {Map<String, dynamic>? params}) {
    try {
      final analytics = AppAnalytics();
      analytics.sendEvent(eventName, params: params ?? {});
    } catch (e) {
      print(e.toString());
    }
  }
}
