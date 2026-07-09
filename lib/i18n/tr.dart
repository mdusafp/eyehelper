import 'package:flutter/widgets.dart';

import 'strings.g.dart';

export 'strings.g.dart';

/// Resolves a translation stored as a flat key path
/// (e.g. `'exercises.verticalMovements'`) into the localized string.
///
/// Used for keys that are held as data on models (exercise names, weekday
/// names, frequency labels) and translated at render time.
String trKey(BuildContext context, String key) => context.t[key] as String;
