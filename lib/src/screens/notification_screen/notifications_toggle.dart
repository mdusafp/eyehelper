import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/locale/Localizer.dart';

typedef void OnChanged(bool value);

class NotificationsToggle extends StatelessWidget {
  final bool value;
  final OnChanged onChange;

  const NotificationsToggle({
    Key key,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localizer.getLocaleById(LocaleId.notifications_on, context),
          style: Theme.of(context).textTheme.body1,
          textAlign: TextAlign.center,
        ),
        Switch(
          value: value,
          onChanged: onChange,
        ),
      ],
    );
  }
}
