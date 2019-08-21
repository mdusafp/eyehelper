import 'package:eyehelper/src/models/working_hours.dart';

// one day in milliseconds
const DEFAULT_NOTIFICATION_FREQUENCY = 1000 * 60 * 60 * 24;

// we can't add default list because of localizer which needs context
const List<WorkingHours> DEFAULT_SCHEDULE = [];

class NotificationSettings {
  bool applyToAll;
  bool notificationsOn;
  int notificationFrequency;
  List<WorkingHours> schedule;

  NotificationSettings({
    this.applyToAll = false,
    this.notificationsOn = false,
    this.notificationFrequency = DEFAULT_NOTIFICATION_FREQUENCY,
    this.schedule = DEFAULT_SCHEDULE,
  });

  NotificationSettings.fromMap(Map<String, dynamic> map) {
    applyToAll = map['applyToAll'] ?? false;
    notificationsOn = map['notificationsOn'] ?? false;
    notificationFrequency =
        map['notificationFrequency'] ?? DEFAULT_NOTIFICATION_FREQUENCY;
    schedule =
        List.from((map['schedule'] ?? []).map((s) => WorkingHours.fromMap(s)));
  }

  Map<String, dynamic> toMap() {
    return {
      'applyToAll': applyToAll,
      'notificationsOn': notificationsOn,
      'notificationFrequency': notificationFrequency,
      'schedule': List.from(schedule.map((s) => s.toMap())),
    };
  }
}
