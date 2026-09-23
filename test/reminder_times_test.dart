import 'package:eyehelper/src/helpers/reminder_times.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:flutter_test/flutter_test.dart';

DailySchedule _day({required bool working, int start = 9, int end = 18}) => DailySchedule(
      localeId: 'schedule.monday',
      isWorkingDay: working,
      startOfWorkInMilliseconds: Duration(hours: start).inMilliseconds,
      endOfWorkInMilliseconds: Duration(hours: end).inMilliseconds,
    );

void main() {
  group('autoReminderTimes', () {
    test('spreads reminders evenly with none at the start', () {
      final times = autoReminderTimes(
        start: const Duration(hours: 9),
        end: const Duration(hours: 18),
        timesADay: 2,
      );
      expect(times, [const Duration(hours: 12), const Duration(hours: 15)]);
    });

    test('one reminder lands in the middle of the window', () {
      final times = autoReminderTimes(
        start: const Duration(hours: 8),
        end: const Duration(hours: 16),
        timesADay: 1,
      );
      expect(times, [const Duration(hours: 12)]);
    });

    test('is empty for an inverted window or zero reminders', () {
      expect(
        autoReminderTimes(start: const Duration(hours: 18), end: const Duration(hours: 9), timesADay: 2),
        isEmpty,
      );
      expect(
        autoReminderTimes(start: const Duration(hours: 9), end: const Duration(hours: 18), timesADay: 0),
        isEmpty,
      );
    });
  });

  group('reminderTimesOn / nextReminder', () {
    // Wednesday, 23 September 2026.
    final wednesday = DateTime(2026, 9, 23, 13, 30);

    test('auto mode skips days off and finds the next slot', () {
      final settings = NotificationSettings(
        notificationsEnabled: true,
        type: NotificationSettings.autoNotifType,
        timesADay: 2,
        dailyScheduleList: [
          _day(working: true), // Mon
          _day(working: true), // Tue
          _day(working: false), // Wed — day off
          _day(working: true, start: 10, end: 16), // Thu
          _day(working: true),
          _day(working: false),
          _day(working: false),
        ],
      );

      expect(reminderTimesOn(settings, wednesday), isEmpty);
      // Thursday 10–16 with two reminders: 12:00 and 14:00.
      expect(nextReminder(settings, wednesday), DateTime(2026, 9, 24, 12));
    });

    test('manual mode honours weekday flags and active state', () {
      final settings = NotificationSettings(
        notificationsEnabled: true,
        type: NotificationSettings.manualNotifType,
        timesADay: -1,
        dailyScheduleList: const [],
        customScheduleList: [
          CustomSchedule(cardInfo: TimeCardInfo.defaultCard13, isActive: true),
          CustomSchedule(cardInfo: TimeCardInfo.defaultCard17, isActive: false),
          CustomSchedule(
            cardInfo: TimeCardInfo(const Duration(hours: 11, minutes: 30), {
              for (final d in weekList) d: d.weekDay == WeekDaysEnum.saturday,
            }),
            isActive: true,
          ),
        ],
      );

      // 13:00 already passed on Wednesday 13:30; 17:00 is inactive.
      expect(reminderTimesOn(settings, wednesday), [const Duration(hours: 13)]);
      expect(nextReminder(settings, wednesday), DateTime(2026, 9, 24, 13));
    });

    test('returns null when nothing ever fires', () {
      final settings = NotificationSettings(
        notificationsEnabled: true,
        type: NotificationSettings.autoNotifType,
        timesADay: 2,
        dailyScheduleList: List.generate(7, (_) => _day(working: false)),
      );
      expect(nextReminder(settings, wednesday), isNull);
    });
  });
}
