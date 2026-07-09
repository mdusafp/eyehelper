
class NotificationFrequency {
  final Duration duration;

  /// Postfix for duration.
  /// Example: 2 hours.
  final String localeId;

  NotificationFrequency(this.localeId, this.duration);
}
