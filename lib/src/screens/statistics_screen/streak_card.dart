import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/screens/statistics_screen/stats_card.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

const _weekdayShortKeys = [
  'schedule.mondayShort',
  'schedule.tuesdayShort',
  'schedule.wednesdayShort',
  'schedule.thursdayShort',
  'schedule.fridayShort',
  'schedule.saturdayShort',
  'schedule.sundayShort',
];

/// Current streak, best streak, and a dot per day of this week.
class StreakCard extends StatelessWidget {
  final HabitStatistics stats;

  const StreakCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final completedThisWeek = stats.week.where((d) => d.isComplete).length;

    return StatsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatsLabel(t.streak),
                    const SizedBox(height: 6),
                    StatsBigNumber(
                      value: stats.currentStreak.toString(),
                      unit: t.daysInARow(n: stats.currentStreak),
                    ),
                    const SizedBox(height: 4),
                    StatsSubtext(
                      stats.bestStreak > 0
                          ? t.bestStreak(days: t.days(n: stats.bestStreak))
                          : t.noStreakYet,
                      color: EyehelperColorScheme.lightGrey,
                    ),
                  ],
                ),
              ),
              _WeekRing(progress: completedThisWeek / stats.week.length),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final day in stats.week)
                Expanded(
                  child: Column(
                    children: [
                      _DayDot(day: day),
                      const SizedBox(height: 4),
                      Text(
                        trKey(context, _weekdayShortKeys[day.date.weekday - 1]),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: EyehelperColorScheme.lightGrey,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeekRing extends StatelessWidget {
  final double progress;

  const _WeekRing({required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            strokeCap: StrokeCap.round,
            backgroundColor: const Color(0xFFF1F5F2),
            valueColor: const AlwaysStoppedAnimation(EyehelperColorScheme.activeColor),
          ),
          const Icon(
            Icons.remove_red_eye_outlined,
            size: 20,
            color: Color(0xFF3B7D5A),
          ),
        ],
      ),
    );
  }
}

/// Filled — full set that day; half — started but not finished; ring — today.
class _DayDot extends StatelessWidget {
  static const double _size = 26;

  final DayProgress day;

  const _DayDot({required this.day});

  @override
  Widget build(BuildContext context) {
    const accent = EyehelperColorScheme.activeColor;
    const idle = Color(0xFFE6ECE8);

    Widget dot;
    if (day.isComplete) {
      dot = Container(
        width: _size,
        height: _size,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: accent),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      );
    } else if (day.isPartial) {
      dot = SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.5,
                child: Container(
                  width: _size,
                  height: _size,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: accent),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accent, width: 2),
              ),
            ),
          ],
        ),
      );
    } else {
      dot = Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: idle, width: 2),
        ),
      );
    }

    if (!day.isToday) {
      return dot;
    }
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: accent, width: 2),
      ),
      child: dot,
    );
  }
}
