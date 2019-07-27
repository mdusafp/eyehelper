import 'package:flutter/material.dart';

import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';

class NotificationConfigSaver extends StatelessWidget {
  NotificationConfigSaver({
    @required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: provide text styles
    return Row(
      children: <Widget>[
        SizedBox(
          width: hv(180.0),
          height: wv(50.0),
          child: RoundCustomButton(
            child: Text(Localizer.getLocaleById('save', context)),
            onPressed: onPressed,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
