import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

const MAX_ITEM_SIZE = 50.0;

typedef void OnChangeFrequencyCallback(int frequency);

class NotificationFrequencyConfigurator extends StatelessWidget {
  NotificationFrequencyConfigurator({
    @required this.frequency,
    @required this.onChangeFrequency,
  });

  final int frequency;
  final OnChangeFrequencyCallback onChangeFrequency;

  int calculateFrequency(int h, int m) {
    // TODO: implement me
    return 0;
  }

  Widget _buildHourItem(BuildContext context, int index) {
    return Container(child: Text('hour'));
  }

  Widget _buildMinuteItem(BuildContext context, int index) {
    return Container(child: Text('minute'));
  }

  @override
  Widget build(BuildContext context) {
    final itemSize = wv(MAX_ITEM_SIZE);

    // TODO: provide texy styles
    final title = Text(Localizer.getLocaleById('how_often_notify', context));

    final frequencyPicker = Row();

    return Column(children: <Widget>[title, frequencyPicker]);
  }
}
