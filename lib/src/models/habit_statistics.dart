import 'package:eyehelper/src/models/swiper_screen_info.dart';

/// One day's worth of exercise starts, as the streak and week views see it.
class DayProgress {
  final DateTime date;
  final int starts;
  final bool isToday;
  final bool isFuture;

  const DayProgress({
    required this.date,
    required this.starts,
    required this.isToday,
    required this.isFuture,
  });

  /// A full set was started — every exercise at least once.
  bool get isComplete => starts >= HabitStatistics.exercisesPerSet;

  bool get isPartial => starts > 0 && !isComplete;
}

/// Everything the statistics tab shows, computed once per visit.
///
/// History only records how many exercises were *started* per day, not which
/// ones, so durations over past days use the average exercise length.
class HabitStatistics {
  /// Exercises in one full set; a day counts toward the streak once this many
  /// have been started.
  static int get exercisesPerSet => SwiperScreenInfo.flareActorByIndex.length;

  final int currentStreak;
  final int bestStreak;

  /// Monday through Sunday of the current week.
  final List<DayProgress> week;

  /// Which of the six exercises were finished today, by exercise index.
  final List<bool> todayDone;
  final int todaySets;

  /// Sets per day the user asked to be reminded about.
  final int plannedSets;

  /// Time left to finish today's set.
  final Duration todayRemaining;

  final DateTime monthStart;

  /// Starts per day of the current month; index 0 is the 1st.
  final List<int> monthStarts;
  final int monthSets;
  final Duration monthTime;

  final Duration thisWeekTime;
  final Duration lastWeekTime;

  const HabitStatistics({
    required this.currentStreak,
    required this.bestStreak,
    required this.week,
    required this.todayDone,
    required this.todaySets,
    required this.plannedSets,
    required this.todayRemaining,
    required this.monthStart,
    required this.monthStarts,
    required this.monthSets,
    required this.monthTime,
    required this.thisWeekTime,
    required this.lastWeekTime,
  });

  bool get todayAllDone => todayDone.every((done) => done);
}
