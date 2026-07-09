import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Platform-adaptive switch: iOS-style [CupertinoSwitch] on Apple platforms,
/// Material 3 [Switch] elsewhere. The app theme itself stays on Material 2,
/// so M3 is enabled locally just for the switch.
class AdaptiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  /// Track color when the switch is on. Defaults to the platform accent.
  final Color? activeColor;

  const AdaptiveSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
      );
    }
    return Theme(
      data: ThemeData.from(
        colorScheme: Theme.of(context).colorScheme,
        useMaterial3: true,
      ),
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
      ),
    );
  }
}
