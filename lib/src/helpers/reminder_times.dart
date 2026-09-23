import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';

/// When the automatic schedule fires inside one working day.
///
/// Reminders are spread evenly through the window with none at the very
/// start: `start + k · (end − start) / (n + 1)` for k = 1…n. The scheduler and
/// the settings screen both use this, so what is previewed is what fires.
List<Duration> autoReminderTimes({
  required Duration start,
  required Duration end,
  required int timesADay,
}) {
  if (timesADay < 1 || end <= start) {
    return const [];
  }
  final step = (end - start).inMilliseconds ~/ (timesADay + 1);
  return List.generate(timesADay, (k) => start + Duration(milliseconds: step * (k + 1)));
}

/// Every time the current settings fire on [day], as offsets from midnight,
/// sorted. Empty when nothing is due that day.
List<Duration> reminderTimesOn(NotificationSettings settings, DateTime day) {
  final dayIndex = day.weekday - 1;

  if (settings.type == NotificationSettings.manualNotifType) {
    final weekDay = weekList[dayIndex];
    final times = <Duration>[];
    for (final schedule in settings.customScheduleList ?? const <CustomSchedule>[]) {
      final info = schedule.cardInfo;
      if (schedule.isActive && info != null && (info.weekDays[weekDay] ?? false)) {
        times.add(info.time);
      }
    }
    return times..sort();
  }

  if (dayIndex >= settings.dailyScheduleList.length) {
    return const [];
  }
  final schedule = settings.dailyScheduleList[dayIndex];
  if (!schedule.isWorkingDay) {
    return const [];
  }
  return autoReminderTimes(
    start: Duration(milliseconds: schedule.startOfWorkInMilliseconds),
    end: Duration(milliseconds: schedule.endOfWorkInMilliseconds),
    timesADay: settings.timesADay ?? 1,
  );
}

/// The first reminder strictly after [now] within the coming week, or null
/// when the settings never fire.
DateTime? nextReminder(NotificationSettings settings, DateTime now) {
  for (var offset = 0; offset < 7; offset++) {
    final day = DateTime(now.year, now.month, now.day + offset);
    for (final time in reminderTimesOn(settings, day)) {
      final at = day.add(time);
      if (at.isAfter(now)) {
        return at;
      }
    }
  }
  return null;
}
