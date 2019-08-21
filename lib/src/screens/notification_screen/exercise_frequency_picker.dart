import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Localizer.getLocaleById('times_per', context),
          style: StandardStyleTexts.display1,
          textAlign: TextAlign.center,
        ),
        SizedBox(width: hv(16)),
        // TODO: customize plugin
        TimePickerSpinner(
          time: new DateTime.fromMillisecondsSinceEpoch(value),
          alignment: Alignment.topCenter,
          itemHeight: 50,
          spacing: 0,
          normalTextStyle: StandardStyleTexts.display1,
          highlightedTextStyle: StandardStyleTexts.headerMain,
          onTimeChange: onChangeFrequency,
        ),
      ],
    );
  }
}
