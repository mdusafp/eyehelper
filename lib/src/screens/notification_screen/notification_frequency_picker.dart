import 'package:flutter/cupertino.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

typedef void OnChange(Duration frequency);

class NotificationFrequencyPicker extends StatefulWidget {
  final Duration initialFrequency;
  final OnChange onChange;

  const NotificationFrequencyPicker({Key key, @required this.initialFrequency, @required this.onChange})
      : super(key: key);

  @override
  NotificationFrequencyPickerState createState() => NotificationFrequencyPickerState();
}

class NotificationFrequencyPickerState extends State<NotificationFrequencyPicker> {
  Duration _frequency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Localizer.getLocaleById(LocaleId.exercise_frequency, context),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.display2.copyWith(
            color: Theme.of(context).primaryColorDark
          ),
        ),
        Container(
          height: 128.0,
          child: CupertinoTimerPicker(
            initialTimerDuration: widget.initialFrequency,
            // some bug exists with this mode
            // mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (timer) {
              setState(() {
                _frequency = timer;
              });
              widget.onChange(_frequency);
            },
          ),
        ),
      ],
    );
  }
}
