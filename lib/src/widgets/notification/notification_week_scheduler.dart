import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/dtos/day_schedule_dto.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';

const DAY_SCHEDULE_HEIGHT = 100;

typedef void OnToggleEnabledCallback(int index, bool value);
typedef void OnChangeDayScheduleCallback(int index, double lower, double upper);

class NotificationWeekScheduler extends StatelessWidget {
  NotificationWeekScheduler({
    @required this.weekSchedule,
    @required this.onToggleEnabled,
    @required this.onChangeDaySchedule,
  });

  final List<DayScheduleDto> weekSchedule;
  final OnToggleEnabledCallback onToggleEnabled;
  final OnChangeDayScheduleCallback onChangeDaySchedule;

  String _valueIndicatorFormatter(int index, double value) =>
      '${value.toInt()}:00';

  Widget _buildDaySchedule(BuildContext context, int index) {
    final daySchedule = this.weekSchedule[index];

    final dayName = Text(Localizer.getLocaleById(daySchedule.name, context));

    final dayScheduleSlider = Expanded(
      child: AbsorbPointer(
        absorbing: daySchedule.isEnabled,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: StandardStyleColors.activeColor,
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: RangeSlider(
            min: daySchedule.min,
            max: daySchedule.max,
            divisions: 24,
            showValueIndicator: true,
            lowerValue: daySchedule.lower,
            upperValue: daySchedule.upper,
            valueIndicatorFormatter: _valueIndicatorFormatter,
            onChanged: (double lower, double upper) {
              onChangeDaySchedule(index, lower, upper);
            },
          ),
        ),
      ),
    );

    final dayScheduleEnabled = Switch(
      value: daySchedule.isEnabled,
      onChanged: (value) => onToggleEnabled(index, value),
    );

    return Container(
      margin: EdgeInsets.only(bottom: wv(10.0)),
      padding: EdgeInsets.only(
        top: wv(10.0),
        right: hv(10.0),
        bottom: wv(10.0),
        left: hv(20.0),
      ),
      decoration: BoxDecoration(
        color: StandardStyleColors.backgroundWhite,
        borderRadius: BorderRadius.circular(wv(35.0)),
        boxShadow: [
          BoxShadow(
            color: StandardStyleColors.boxShadow,
            blurRadius: 10,
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          dayName,
          VerticalDivider(),
          dayScheduleSlider,
          VerticalDivider(),
          dayScheduleEnabled,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weekSchedule.length,
      itemExtent: wv(DAY_SCHEDULE_HEIGHT),
      itemBuilder: _buildDaySchedule,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
