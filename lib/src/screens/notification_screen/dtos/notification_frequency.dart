import 'package:eyehelper/src/locale/ru.dart';

class NotificationFrequency {
  final Duration duration;

  /// Postfix for duration.
  /// Example: 2 hours.
  final LocaleId localeId;

  NotificationFrequency(this.localeId, this.duration);
}
