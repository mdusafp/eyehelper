import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/reminder_times.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:flutter/widgets.dart';

/// "Mon–Fri", "Every day except Thu and Sun", "Weekdays" — whichever is
/// shortest and still exact. [selected] holds weekday indexes, Monday = 0.
String describeWeekdays(BuildContext context, Set<int> selected) {
  final t = context.t.notifications;
  if (selected.length == 7) {
    return _capitalize(t.everyDayShort);
  }
  if (selected.isEmpty) {
    return '';
  }
  const weekdays = {0, 1, 2, 3, 4};
  const weekend = {5, 6};
  if (selected.length == 5 && selected.containsAll(weekdays)) {
    return _capitalize(t.weekdaysShort);
  }
  if (selected.length == 2 && selected.containsAll(weekend)) {
    return _capitalize(t.weekendShort);
  }

  String short(int i) => trKey(context, weekList[i].shortLocale);

  // Five or six days read better as what is left out.
  if (selected.length >= 5) {
    final missing = [for (var i = 0; i < 7; i++) if (!selected.contains(i)) i];
    return t.everyDayExcept(days: _joinNatural(missing.map(short).toList(), t.daysAnd));
  }

  final sorted = selected.toList()..sort();
  final contiguous = sorted.last - sorted.first == sorted.length - 1;
  if (contiguous && sorted.length > 2) {
    return '${short(sorted.first)}–${short(sorted.last)}';
  }
  return _joinNatural(sorted.map(short).toList(), t.daysAnd);
}

/// The lines under the master switch: what is set, in words.
List<String> notificationSummary(BuildContext context, NotificationSettings settings, DateTime now) {
  final t = context.t.notifications;
  if (!settings.notificationsEnabled) {
    return [t.offShort];
  }

  final formatter = CustomTimeFormatter();

  if (settings.type == NotificationSettings.manualNotifType) {
    final active = (settings.customScheduleList ?? const <CustomSchedule>[])
        .where((s) => s.isActive && s.cardInfo != null)
        .length;
    if (active == 0) {
      return [_capitalize(t.noneScheduled)];
    }
    return [t.summaryCustom(n: active), _capitalize(_next(context, settings, now))];
  }

  final working = <int>{};
  Duration? start;
  Duration? end;
  var sameHours = true;
  for (var i = 0; i < settings.dailyScheduleList.length; i++) {
    final day = settings.dailyScheduleList[i];
    if (!day.isWorkingDay) {
      continue;
    }
    working.add(i);
    final s = Duration(milliseconds: day.startOfWorkInMilliseconds);
    final e = Duration(milliseconds: day.endOfWorkInMilliseconds);
    if (start == null) {
      start = s;
      end = e;
    } else if (s != start || e != end) {
      sameHours = false;
    }
  }
  if (working.isEmpty || start == null || end == null) {
    return [_capitalize(t.noneScheduled)];
  }

  final hours = sameHours
      ? '${formatter.formatShort(start)}–${formatter.formatShort(end)}'
      : t.hoursVary;
  return [
    '${t.summaryPerDay(n: settings.timesADay ?? 1)}, $hours',
    describeWeekdays(context, working),
  ];
}

String _next(BuildContext context, NotificationSettings settings, DateTime now) {
  final t = context.t.notifications;
  final next = nextReminder(settings, now);
  if (next == null) {
    return t.noneScheduled;
  }
  final time = CustomTimeFormatter().formatShort(Duration(hours: next.hour, minutes: next.minute));
  final today = DateTime(now.year, now.month, now.day);
  if (DateTime(next.year, next.month, next.day) == today) {
    return t.nextToday(time: time);
  }
  final day = trKey(context, weekList[next.weekday - 1].shortLocale);
  return t.nextOn(day: day, time: time);
}

/// "Thu", "Thu and Sun", "Mon, Thu and Sun".
String _joinNatural(List<String> parts, String and) {
  if (parts.length <= 1) {
    return parts.join();
  }
  return '${parts.sublist(0, parts.length - 1).join(', ')} $and ${parts.last}';
}

String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
