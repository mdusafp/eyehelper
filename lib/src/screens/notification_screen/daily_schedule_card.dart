import 'dart:core';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// callback to update parent data (without setState to don't rerender whole widget tree)
typedef void OnChange(bool isWorkingDay, Duration startOfWork, Duration endOfWork);

// TODO: provide error handler (start date can't be later than end date)
class DailyScheduleCard extends StatefulWidget {
  final String name;
  final Duration initialStartOfWork;
  final Duration initialEndOfWork;
  final bool isActive;
  final OnChange onChange;

  const DailyScheduleCard({
    Key key,
    @required this.name,
    @required this.onChange,
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
              widget.onChange(_isActive, _startOfWork, _endOfWork);
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
              widget.onChange(_isActive, _startOfWork, _endOfWork);
            },
          ),
        );
      },
    );
  }

  Widget _buildToggle() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Switch(
            activeColor: Theme.of(context).backgroundColor,
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });
              widget.onChange(_isActive, _startOfWork, _endOfWork);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingTime() {
    ThemeData themeData = Theme.of(context);

    // The reason to put isUtc true to fix the bug when modal display utc values
    // widget display in local date
    String startText = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
      _startOfWork.inMilliseconds,
      isUtc: true,
    ));
    String endText = _timeFormatter.format(DateTime.fromMillisecondsSinceEpoch(
      _endOfWork.inMilliseconds,
      isUtc: true,
    ));

    return AbsorbPointer(
      absorbing: !_isActive,
      child: DefaultTextStyle(
        style: themeData.textTheme.display1.copyWith(
          color: _isActive ? themeData.backgroundColor.withOpacity(.65) : themeData.backgroundColor.withOpacity(.4),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(Localizer.getLocaleById(LocaleId.from, context)),
            ),
            InkWell(
              child: Text(startText),
              onTap: _showStartTimePicker,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(Localizer.getLocaleById(LocaleId.to, context)),
            ),
            InkWell(
              child: Text(endText),
              onTap: _showEndTimePicker,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    HSLColor activeCardColor = HSLColor.fromColor(themeData.accentColor);
    HSLColor inactiveCardColor = HSLColor.fromColor(themeData.primaryColor);

    final activeGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [activeCardColor.withLightness(.5).toColor(), activeCardColor.withLightness(.4).toColor()],
    );

    final inactiveGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [inactiveCardColor.withLightness(.5).toColor(), inactiveCardColor.withLightness(.4).toColor()],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: _isActive ? activeGradient : inactiveGradient,
        boxShadow: [
          const BoxShadow(
            color: Color(0x55000000),
            offset: Offset(0.0, 6.0),
            blurRadius: 8.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: DefaultTextStyle(
          style: themeData.textTheme.body1.copyWith(
            color: _isActive ? themeData.backgroundColor : themeData.backgroundColor.withOpacity(.65),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  height: 64.0,
                  width: 64.0,
                  child: Center(
                    child: Text(
                      widget.name.toUpperCase(),
                      style: themeData.textTheme.title.copyWith(
                        color: _isActive ? themeData.accentColor : themeData.primaryColor,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    color: themeData.backgroundColor,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(Localizer.getLocaleById(_isActive ? LocaleId.working_time : LocaleId.weekend, context)),
                  ),
                  if (_isActive) _buildWorkingTime(),
                ],
              ),
              _buildToggle(),
            ],
          ),
        ),
      ),
    );
  }
}
