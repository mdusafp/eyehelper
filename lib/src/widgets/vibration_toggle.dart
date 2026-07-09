import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Toggles the vibration-during-exercise preference.
class VibrationToggle extends StatefulWidget {
  const VibrationToggle({Key? key}) : super(key: key);

  @override
  State<VibrationToggle> createState() => _VibrationToggleState();
}

class _VibrationToggleState extends State<VibrationToggle> {
  @override
  Widget build(BuildContext context) {
    final prefs = FastPreferences().prefs;
    final enabled = prefs.getBool(FastPreferences.isVibrationEnabled) ?? true;

    return GlassIconButton(
      size: 40,
      icon: Icon(
        Icons.vibration,
        color: enabled
            ? Theme.of(context).colorScheme.secondary
            : EyehelperColorScheme.mainDark,
      ),
      onPressed: () async {
        await prefs.setBool(FastPreferences.isVibrationEnabled, !enabled);
        setState(() {});
      },
    );
  }
}
