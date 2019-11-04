import 'dart:core';
import 'package:intl/intl.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyScheduleCard extends StatefulWidget {
  final String name;
  final Duration initialStartOfWork;
  final Duration initialEndOfWork;
  final bool isActive;

  const DailyScheduleCard({
    Key key,
    @required this.name,
    this.initialStartOfWork = const Duration(hours: 8, minutes: 00, seconds: 00),
    this.initialEndOfWork = const Duration(hours: 17, minutes: 00, seconds: 00),
    this.isActive = false,
  }) : super(key: key);

  @override
  DailyScheduleCardState createState() => DailyScheduleCardState();
}

DateFormat _timeFormatter = new DateFormat.Hm();

class DailyScheduleCardState extends State<DailyScheduleCard> {
  Duration _startOfWork;
  Duration _endOfWork;
  bool _isActive;

  @override
  void initState() {
    super.initState();
    _startOfWork = widget.initialStartOfWork;
    _endOfWork = widget.initialEndOfWork;
    _isActive = widget.isActive;
  }

  // TODO: use one method instead of copy paste
  void _showStartTimePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 256.0,
          child: CupertinoTimerPicker(
            initialTimerDuration: _startOfWork,
            // some bug exists with this mode
            // mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (timer) {
              setState(() {
                _startOfWork = timer;
              });
            },
          ),
        );
      },
    );
  }

  void _showEndTimePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 256.0,
          child: CupertinoTimerPicker(
            initialTimerDuration: _endOfWork,
            // some bug exists with this mode
            // mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (timer) {
              setState(() {
                _endOfWork = timer;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Switch(
          value: _isActive,
          onChanged: (value) {
            setState(() {
              _isActive = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildWorkingTime() {
    // FIXME: fix timezone offset -3
    String startText = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(_startOfWork.inMilliseconds));
    String endText = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(_endOfWork.inMilliseconds));

    return AbsorbPointer(
      absorbing: !_isActive,
      child: Row(
        children: <Widget>[
          InkWell(
            child: Text(startText),
            onTap: _showStartTimePicker,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('-'),
          ),
          InkWell(
            child: Text(endText),
            onTap: _showEndTimePicker,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16.0,
          bottom: 0.0,
          left: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: _isActive ? EyehelperColorScheme.mainDark : EyehelperColorScheme.lightGrey),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.name),
                  _buildWorkingTime(),
                ],
              ),
            ),
            _buildToggle(),
          ],
        ),
      ),
    );
  }
}
