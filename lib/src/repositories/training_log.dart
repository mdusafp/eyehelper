import 'package:eyehelper/src/helpers/preferences.dart';

class TrainingLogEntry {
  final DateTime at;
  final int exerciseIndex;

  const TrainingLogEntry({required this.at, required this.exerciseIndex});
}

/// Append-only record of every exercise start.
///
/// The day counters only know *how many* exercises ran per day. This log also
/// keeps *which* one and *when*, which is what time-of-day and per-exercise
/// statistics will need. Nothing reads it yet; it starts filling now so those
/// views have history by the time they ship.
class TrainingLog {
  static const String _key = 'training_log';
  static const Duration _retention = Duration(days: 365);

  Future<void> append(int exerciseIndex) async {
    final prefs = FastPreferences().prefs;
    final now = DateTime.now();
    final cutoff = now.subtract(_retention).millisecondsSinceEpoch;

    final kept = (prefs.getStringList(_key) ?? const [])
        .where((raw) => (_parse(raw)?.at.millisecondsSinceEpoch ?? 0) >= cutoff)
        .toList();
    kept.add('${now.millisecondsSinceEpoch}:$exerciseIndex');

    await prefs.setStringList(_key, kept);
  }

  List<TrainingLogEntry> get entries {
    final raw = FastPreferences().prefs.getStringList(_key) ?? const [];
    return raw.map(_parse).whereType<TrainingLogEntry>().toList();
  }

  TrainingLogEntry? _parse(String raw) {
    final parts = raw.split(':');
    if (parts.length != 2) {
      return null;
    }
    final ts = int.tryParse(parts[0]);
    final index = int.tryParse(parts[1]);
    if (ts == null || index == null) {
      return null;
    }
    return TrainingLogEntry(at: DateTime.fromMillisecondsSinceEpoch(ts), exerciseIndex: index);
  }
}
