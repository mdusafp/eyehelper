import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';

typedef void OnChanged(bool value);

class ApplyToAll extends StatelessWidget {
  final bool value;
  final OnChanged onChanged;

  const ApplyToAll({
    Key key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          Localizer.getLocaleById(LocaleId.apply_to_all, context),
          style: StandardStyleTexts.display1,
          textAlign: TextAlign.center,
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
