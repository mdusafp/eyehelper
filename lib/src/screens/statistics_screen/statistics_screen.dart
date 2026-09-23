import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/habit_statistics.dart';
import 'package:eyehelper/src/repositories/statistics_repository.dart';
import 'package:eyehelper/src/screens/statistics_screen/month_heatmap_card.dart';
import 'package:eyehelper/src/screens/statistics_screen/stats_card.dart';
import 'package:eyehelper/src/screens/statistics_screen/streak_card.dart';
import 'package:eyehelper/src/screens/statistics_screen/today_card.dart';
import 'package:eyehelper/src/screens/statistics_screen/week_minutes_card.dart';
import 'package:eyehelper/src/widgets/ad_banner.dart';
import 'package:eyehelper/src/widgets/app_bar_blur.dart';
import 'package:flutter/material.dart';

/// Streak, today's set, the month calendar, and minutes week over week.
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // The tab host rebuilds this screen on every visit, so loading once per
  // State is enough to pick up whatever was trained in between.
  late final Future<HabitStatistics> _stats =
      StatisticsRepository(FastPreferences()).loadHabitStatistics();

  @override
  Widget build(BuildContext context) {
    // The glass scaffold lets the body run under both bars; leave room for
    // the app bar above and the tab bar below.
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final padding = EdgeInsets.fromLTRB(
      16,
      viewPadding.top + kGlassAppBarHeight + 12,
      16,
      viewPadding.bottom + 60 + 16,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBarBlur(
        child: FutureBuilder<HabitStatistics>(
          future: _stats,
          builder: (context, snapshot) {
            final stats = snapshot.data;
            if (stats == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: padding,
              child: Column(
                children: [
                  StreakCard(stats: stats),
                  const SizedBox(height: 12),
                  TodayCard(stats: stats),
                  const SizedBox(height: 12),
                  // After the two cards people read on every visit, before
                  // the two they scroll down to browse. Framed like a card
                  // and padded inside it so the creative stays uncropped.
                  // Takes no space at all until an ad is actually there.
                  AdBanner(
                    placement: 'statistics',
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: statsCardDecoration,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  MonthHeatmapCard(stats: stats),
                  const SizedBox(height: 12),
                  WeekMinutesCard(stats: stats),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
