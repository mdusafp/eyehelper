import 'package:flutter/material.dart';

import 'package:eyehelper/src/locale/Localizer.dart';

typedef void OnToggleEnabledCallback(bool value);
typedef void OnToggleApplyToAllCallback(bool value);

class NotificationMetaConfigurator extends StatelessWidget {
  NotificationMetaConfigurator({
    @required this.isEnabled,
    @required this.isAppliedToAll,
    @required this.onToggleEnabled,
    @required this.onToggleToApplyAll,
  });

  final bool isEnabled;
  final bool isAppliedToAll;
  final OnToggleEnabledCallback onToggleEnabled;
  final OnToggleApplyToAllCallback onToggleToApplyAll;

  @override
  Widget build(BuildContext context) {
    // TODO: provide text styles
    final notificationsEnabled = Row(
      children: <Widget>[
        Text(Localizer.getLocaleById('notifications_enabled', context)),
        Switch(value: isEnabled, onChanged: onToggleEnabled),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );

    final selectTimeText = Text(
      Localizer.getLocaleById('select_working_period', context),
      textAlign: TextAlign.center,
    );

    final applyToAll = Row(
      children: <Widget>[
        Text(Localizer.getLocaleById('apply_to_all', context)),
        Checkbox(value: isAppliedToAll, onChanged: onToggleToApplyAll),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );

    return Column(
      children: <Widget>[
        notificationsEnabled,
        selectTimeText,
        applyToAll,
      ],
    );
  }
}
