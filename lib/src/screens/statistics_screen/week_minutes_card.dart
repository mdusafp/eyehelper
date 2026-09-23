import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/screens/statistics_screen/stats_card.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

/// Minutes spent on the eyes this week against last week. The delta is green
/// when it grows and quiet grey when it does not — nothing here scolds.
class WeekMinutesCard extends StatelessWidget {
  final HabitStatistics stats;

  const WeekMinutesCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final thisWeek = stats.thisWeekTime.inMinutes;
    final delta = thisWeek - stats.lastWeekTime.inMinutes;

    return StatsCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatsLabel(t.thisWeek),
                const SizedBox(height: 6),
                StatsBigNumber(value: thisWeek.toString(), unit: t.minutesForEyes, size: 32),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatsSubtext(
                t.lastWeek(time: formatDuration(context, stats.lastWeekTime)),
                color: EyehelperColorScheme.lightGrey,
                textAlign: TextAlign.right,
              ),
              if (delta != 0) ...[
                const SizedBox(height: 2),
                Text(
                  '${delta > 0 ? '+' : '−'}${delta.abs()} ${t.minutesShort}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: delta > 0
                            ? const Color(0xFF3B7D5A)
                            : EyehelperColorScheme.lightGrey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
