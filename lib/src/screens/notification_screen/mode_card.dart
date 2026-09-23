import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/reminder_times.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/today_timeline.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';

/// Mode segment, reminders-per-day chips and today's timeline.
class ModeCard extends StatelessWidget {
  final bool manual;
  final int timesADay;
  final DailySchedule? today;
  final DateTime now;
  final ValueChanged<bool> onModeChanged;
  final ValueChanged<int> onTimesChanged;

  const ModeCard({
    super.key,
    required this.manual,
    required this.timesADay,
    required this.today,
    required this.now,
    required this.onModeChanged,
    required this.onTimesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final weekday = trKey(context, weekList[now.weekday - 1].fullLocale);
    // Russian keeps weekday names lower-case mid-sentence; English does not.
    final todayLabel = t.todayIs(
      day: Localizations.localeOf(context).languageCode == 'ru' ? weekday.toLowerCase() : weekday,
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModeSegment(manual: manual, onChanged: onModeChanged),
          if (!manual) ...[
            const SizedBox(height: 16),
            AppCardLabel(t.remindersPerDay),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final n in const [1, 2, 3]) ...[
                  if (n > 1) const SizedBox(width: 8),
                  Expanded(
                    child: _Chip(
                      label: '$n',
                      selected: timesADay == n,
                      onTap: () => onTimesChanged(n),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            AppCardLabel(todayLabel),
            const SizedBox(height: 4),
            _today(context),
          ],
        ],
      ),
    );
  }

  Widget _today(BuildContext context) {
    final schedule = today;
    if (schedule == null || !schedule.isWorkingDay) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: AppCardSubtext(
          context.t.notifications.todayDayOff,
          color: EyehelperColorScheme.lightGrey,
        ),
      );
    }
    final start = Duration(milliseconds: schedule.startOfWorkInMilliseconds);
    final end = Duration(milliseconds: schedule.endOfWorkInMilliseconds);
    return TodayTimeline(
      start: start,
      end: end,
      times: autoReminderTimes(start: start, end: end, timesADay: timesADay),
      now: Duration(hours: now.hour, minutes: now.minute),
    );
  }
}

/// Two-way toggle with a sliding thumb. Hand-rolled because Cupertino's
/// version pins its corner radius, and this one has to match the cards.
class _ModeSegment extends StatelessWidget {
  static const double _radius = 16;
  static const double _inset = 4;
  static const double _height = 44;

  final bool manual;
  final ValueChanged<bool> onChanged;

  const _ModeSegment({required this.manual, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;

    Widget item(String label, bool selected, VoidCallback onTap) => Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: appText(
                  14.5,
                  weight: FontWeight.w600,
                  color: selected ? appAccentDeep : EyehelperColorScheme.mainDark,
                ),
                child: Text(label),
              ),
            ),
          ),
        );

    return Container(
      height: _height,
      padding: const EdgeInsets.all(_inset),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3EF),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: manual ? Alignment.centerRight : Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_radius - _inset),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              item(t.modeAuto, !manual, () => onChanged(false)),
              item(t.modeManual, manual, () => onChanged(true)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? EyehelperColorScheme.activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: selected ? EyehelperColorScheme.activeColor : appHairline,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: appText(
            16,
            weight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? Colors.white : EyehelperColorScheme.mainDark,
          ),
        ),
      ),
    );
  }
}
