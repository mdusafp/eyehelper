import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:eyehelper/src/locale/Localizer.dart';

typedef void OnChangeFrequency(DateTime value);

class ExerciseFrequencyPicker extends StatelessWidget {
  final int value;
  final OnChangeFrequency onChangeFrequency;

  const ExerciseFrequencyPicker({
    Key key,
    this.value,
    this.onChangeFrequency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localizer.getLocaleById(LocaleId.times_per, context),
          style: textTheme.body1,
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 16),
        // TODO: customize plugin
        TimePickerSpinner(
          time: new DateTime.fromMillisecondsSinceEpoch(value),
          alignment: Alignment.topCenter,
          itemHeight: 50,
          spacing: 0,
          normalTextStyle: textTheme.body1,
          highlightedTextStyle: textTheme.body1.copyWith(color: Colors.redAccent),
          onTimeChange: onChangeFrequency,
        ),
      ],
    );
  }
}
