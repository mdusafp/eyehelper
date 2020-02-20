import 'package:eyehelper/src/helpers/preferences.dart';

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

  int get skippedDays {
    switch (activities.length) {
      case 0:
      case 1:
        return 0;
      default:
        final last = activities.last;
        final secondToLast = activities[activities.length - 2];
        return last.difference(secondToLast).inDays - 1;
    }
  }

  String _keyActivitiesList = 'activities_list';
}
