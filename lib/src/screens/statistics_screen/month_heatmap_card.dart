import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/screens/statistics_screen/stats_card.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// One hue, five steps: nothing, a partial set, one, two, three or more.
const _levelColors = [
  Color(0xFFF1F5F2),
  Color(0xFFB9DCC8),
  Color(0xFF8CC5A5),
  Color(0xFF63AB83),
  Color(0xFF3B7D5A),
];

const _weekdayShortKeys = [
  'schedule.mondayShort',
  'schedule.tuesdayShort',
  'schedule.wednesdayShort',
  'schedule.thursdayShort',
  'schedule.fridayShort',
  'schedule.saturdayShort',
  'schedule.sundayShort',
];

const _cellGap = 4.0;
const _rowLabelWidth = 30.0;

/// Calendar of the current month, shaded by how many sets ran each day.
class MonthHeatmapCard extends StatelessWidget {
  final HabitStatistics stats;

  const MonthHeatmapCard({super.key, required this.stats});

  static int levelFor(int starts) {
    final perSet = HabitStatistics.exercisesPerSet;
    if (starts <= 0) return 0;
    if (starts < perSet) return 1;
    if (starts < perSet * 2) return 2;
    if (starts < perSet * 3) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;
    final locale = Localizations.localeOf(context).toString();
    final monthName = DateFormat.MMMM(locale).format(stats.monthStart);
    final title = monthName.isEmpty
        ? monthName
        : monthName[0].toUpperCase() + monthName.substring(1);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final captionStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
          color: EyehelperColorScheme.lightGrey,
        );

    // Lay the month out Monday-first; leading blanks pad the first row.
    final leading = stats.monthStart.weekday - 1;
    final daysInMonth = stats.monthStarts.length;
    final rows = <List<int?>>[];
    var cursor = -leading;
    while (cursor < daysInMonth) {
      final row = <int?>[];
      for (var i = 0; i < 7; i++) {
        row.add(cursor >= 0 && cursor < daysInMonth ? cursor : null);
        cursor++;
      }
      rows.add(row);
    }

    return StatsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatsLabel(title),
              StatsSubtext(
                t.setsAndTime(n: stats.monthSets, time: formatDuration(context, stats.monthTime)),
                color: EyehelperColorScheme.lightGrey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: _rowLabelWidth),
              for (final key in _weekdayShortKeys)
                Expanded(
                  child: Text(trKey(context, key), textAlign: TextAlign.center, style: captionStyle),
                ),
            ],
          ),
          const SizedBox(height: _cellGap),
          for (final row in rows) ...[
            _WeekRow(
              row: row,
              stats: stats,
              today: today,
              captionStyle: captionStyle,
            ),
            const SizedBox(height: _cellGap),
          ],
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('0', style: captionStyle),
              const SizedBox(width: 4),
              for (final color in _levelColors) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(width: 3),
              ],
              const SizedBox(width: 1),
              Text(t.legendMax, style: captionStyle),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  final List<int?> row;
  final HabitStatistics stats;
  final DateTime today;
  final TextStyle? captionStyle;

  const _WeekRow({
    required this.row,
    required this.stats,
    required this.today,
    required this.captionStyle,
  });

  @override
  Widget build(BuildContext context) {
    final days = row.whereType<int>().toList();
    final label = days.isEmpty ? '' : '${days.first + 1}–${days.last + 1}';

    return Row(
      children: [
        SizedBox(
          width: _rowLabelWidth,
          child: Text(label, style: captionStyle, textAlign: TextAlign.left),
        ),
        for (var i = 0; i < row.length; i++) ...[
          if (i > 0) const SizedBox(width: _cellGap),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: row[i] == null ? const SizedBox.shrink() : _DayCell(dayIndex: row[i]!, stats: stats, today: today),
            ),
          ),
        ],
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final int dayIndex;
  final HabitStatistics stats;
  final DateTime today;

  const _DayCell({required this.dayIndex, required this.stats, required this.today});

  @override
  Widget build(BuildContext context) {
    final date = DateTime(stats.monthStart.year, stats.monthStart.month, dayIndex + 1);
    final isFuture = date.isAfter(today);
    final isToday = date == today;
    final level = MonthHeatmapCard.levelFor(stats.monthStarts[dayIndex]);

    return Container(
      decoration: BoxDecoration(
        color: isFuture ? _levelColors[0].withValues(alpha: 0.45) : _levelColors[level],
        borderRadius: BorderRadius.circular(4),
        border: isToday ? Border.all(color: const Color(0xFF3B7D5A), width: 2) : null,
      ),
    );
  }
}
