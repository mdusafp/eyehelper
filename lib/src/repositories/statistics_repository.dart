import 'dart:convert';
import 'dart:math';

import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:intl/intl.dart';

class StatisticsRepository {
  final FastPreferences fastPreferences;

  StatisticsRepository(this.fastPreferences);

  Future<void> addActivity(DateTime activity) async {
    if (activities.contains(activity)) return;

    await fastPreferences.prefs.setStringList(
      _keyActivitiesList,
      [...activities, activity].map((activity) => activity.millisecondsSinceEpoch.toString()).toList(),
    );
  }

  // DateTime to String to DateTime can be performance bottleneck
  // Maybe rewrite later
  List<DateTime> get activities {
    final activitiesList = (fastPreferences.prefs.getStringList(_keyActivitiesList) ?? [])
        .map((activity) => DateTime.fromMillisecondsSinceEpoch(int.parse(activity)))
        .toList();

    return activitiesList;
  }

  final String _keyActivitiesList = 'activities_list';

  /// How long one exercise takes, averaged over the set. Past days only know
  /// how many exercises were started, not which ones.
  static Duration get averageExerciseDuration {
    final total = SwiperScreenInfo.flareActorByIndex.values.fold<double>(
      0,
      (sum, info) => sum + info.duration * info.times,
    );
    return Duration(seconds: (total / SwiperScreenInfo.flareActorByIndex.length).round());
  }

  Future<HabitStatistics> loadHabitStatistics() async {
    final exercisesPerSet = HabitStatistics.exercisesPerSet;
    final counters = TodayTrainingCounters();
    // Resets the per-exercise map when the stored day is over, same as the
    // training tab does, so "done today" never shows yesterday.
    await counters.init(exercisesPerSet);

    final startsByDay = _startsByDay(counters.formatterNoHours);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    int startsOn(DateTime day) => startsByDay[day] ?? 0;
    Duration timeFor(int starts) => averageExerciseDuration * starts;

    // Streaks. Today only breaks the streak once it is over, so an incomplete
    // today falls back to counting from yesterday.
    final streakThroughToday = _streakEndingAt(today, startsByDay);
    final currentStreak =
        streakThroughToday > 0 ? streakThroughToday : _streakEndingAt(_daysAgo(today, 1), startsByDay);

    // Current week, Monday first.
    final monday = _daysAgo(today, today.weekday - 1);
    final week = List.generate(7, (i) {
      final date = DateTime(monday.year, monday.month, monday.day + i);
      return DayProgress(
        date: date,
        starts: startsOn(date),
        isToday: date == today,
        isFuture: date.isAfter(today),
      );
    });

    final thisWeekStarts = week.where((d) => !d.isFuture).fold<int>(0, (sum, d) => sum + d.starts);
    final lastMonday = _daysAgo(monday, 7);
    var lastWeekStarts = 0;
    for (var i = 0; i < 7; i++) {
      lastWeekStarts += startsOn(DateTime(lastMonday.year, lastMonday.month, lastMonday.day + i));
    }

    // Today.
    final doneMap = counters.getAll();
    final todayDone = List.generate(exercisesPerSet, (i) => doneMap[i.toString()] == true);
    var remaining = Duration.zero;
    for (var i = 0; i < exercisesPerSet; i++) {
      if (todayDone[i]) continue;
      final info = SwiperScreenInfo.flareActorByIndex[i];
      if (info != null) {
        remaining += Duration(milliseconds: (info.duration * info.times * 1000).round());
      }
    }

    // Current month.
    final monthStart = DateTime(today.year, today.month, 1);
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
    final monthStarts = List.generate(
      daysInMonth,
      (i) => startsOn(DateTime(monthStart.year, monthStart.month, i + 1)),
    );
    final monthTotal = monthStarts.fold<int>(0, (sum, v) => sum + v);

    return HabitStatistics(
      currentStreak: currentStreak,
      bestStreak: max(_bestStreak(startsByDay), currentStreak),
      week: week,
      todayDone: todayDone,
      todaySets: startsOn(today) ~/ exercisesPerSet,
      plannedSets: _plannedSetsPerDay(),
      todayRemaining: remaining,
      monthStart: monthStart,
      monthStarts: monthStarts,
      monthSets: monthTotal ~/ exercisesPerSet,
      monthTime: timeFor(monthTotal),
      thisWeekTime: timeFor(thisWeekStarts),
      lastWeekTime: timeFor(lastWeekStarts),
    );
  }

  /// Exercise starts keyed by calendar day, parsed from the same formatter the
  /// training tab writes with.
  Map<DateTime, int> _startsByDay(DateFormat formatter) {
    final raw = fastPreferences.prefs.getString(FastPreferences.dayCountersKey);
    if (raw == null) {
      return const {};
    }

    final result = <DateTime, int>{};
    final decoded = json.decode(raw) as Map<String, dynamic>;
    decoded.forEach((key, value) {
      try {
        final parsed = formatter.parse(key);
        final day = DateTime(parsed.year, parsed.month, parsed.day);
        result[day] = (result[day] ?? 0) + (value as num).toInt();
      } on FormatException {
        // Written under a different locale format — skip rather than crash.
      }
    });
    return result;
  }

  int _streakEndingAt(DateTime day, Map<DateTime, int> startsByDay) {
    var streak = 0;
    var cursor = day;
    while ((startsByDay[cursor] ?? 0) >= HabitStatistics.exercisesPerSet) {
      streak++;
      cursor = _daysAgo(cursor, 1);
    }
    return streak;
  }

  int _bestStreak(Map<DateTime, int> startsByDay) {
    final completeDays = startsByDay.entries
        .where((e) => e.value >= HabitStatistics.exercisesPerSet)
        .map((e) => e.key)
        .toList()
      ..sort();

    var best = 0;
    var run = 0;
    DateTime? previous;
    for (final day in completeDays) {
      run = previous != null && _daysAgo(day, 1) == previous ? run + 1 : 1;
      best = max(best, run);
      previous = day;
    }
    return best;
  }

  /// Reminder settings double as the daily target. Manual schedules count
  /// their reminder slots; anything unset falls back to one set a day.
  int _plannedSetsPerDay() {
    final settings = NotificationsHelper.getUpdatedSettings();
    var planned = settings.timesADay ?? 1;
    if (planned < 1) {
      planned = settings.customScheduleList?.length ?? 1;
    }
    return max(planned, 1);
  }

  /// Date-only arithmetic that ignores DST shifts.
  static DateTime _daysAgo(DateTime day, int days) => DateTime(day.year, day.month, day.day - days);
}
