import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/statistics_screen/stats_card.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

/// One icon per exercise, in the order of the training tab.
const _exerciseIcons = [
  Icons.swap_vert,
  Icons.swap_horiz,
  Icons.visibility_off_outlined,
  Icons.remove_red_eye_outlined,
  Icons.center_focus_strong_outlined,
  Icons.back_hand_outlined,
];

/// Six chips for today's exercises, plus what is left to finish the set.
class TodayCard extends StatelessWidget {
  final HabitStatistics stats;

  const TodayCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final t = context.t.statistics;

    final leftNames = <String>[];
    for (var i = 0; i < stats.todayDone.length; i++) {
      final info = SwiperScreenInfo.flareActorByIndex[i];
      if (!stats.todayDone[i] && info != null) {
        leftNames.add(trKey(context, info.title));
      }
    }

    return StatsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatsLabel(t.today),
              StatsSubtext(
                t.setsOfPlan(n: stats.plannedSets, done: stats.todaySets),
                color: EyehelperColorScheme.lightGrey,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var i = 0; i < stats.todayDone.length; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(child: _ExerciseChip(index: i, done: stats.todayDone[i])),
              ],
            ],
          ),
          const SizedBox(height: 10),
          StatsSubtext(
            stats.todayAllDone
                ? t.allDone
                : t.remaining(
                    names: leftNames.join(', '),
                    time: formatDuration(context, stats.todayRemaining),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseChip extends StatelessWidget {
  final int index;
  final bool done;

  const _ExerciseChip({required this.index, required this.done});

  @override
  Widget build(BuildContext context) {
    final icon = index < _exerciseIcons.length ? _exerciseIcons[index] : Icons.remove_red_eye;
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE3F1E9) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: done ? EyehelperColorScheme.activeColor : const Color(0xFFE6ECE8),
          width: 1.5,
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: done ? const Color(0xFF3B7D5A) : EyehelperColorScheme.lightGrey,
      ),
    );
  }
}
