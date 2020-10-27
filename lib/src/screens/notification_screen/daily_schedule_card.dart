import 'dart:core';
import 'dart:math' as math;
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/custom_time_picker.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/theme.dart';

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
  final bool showError;
  final OnChange onChange;

  const DailyScheduleCard({
    Key key,
    @required this.name,
    @required this.onChange,
    this.initialStartOfWork = const Duration(hours: 8, minutes: 00, seconds: 00),
    this.initialEndOfWork = const Duration(hours: 17, minutes: 00, seconds: 00),
    this.isActive = false,
    this.showError = false,
  }) : super(key: key);

  @override
  DailyScheduleCardState createState() => DailyScheduleCardState();
}

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

  void _showIntervalTimePicker() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Container(
          height: 256.0,
          child: IntervalPicker(
            endDuration: _endOfWork,
            startDuration: _startOfWork,
            onChanged: (start, end) {
              setState(() {
                _endOfWork = end;
                _startOfWork = start;
              });
            },
          ),
        );
      },
    );
    widget.onChange(_isActive, _startOfWork, _endOfWork);
  }

  Widget _buildToggle() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IgnorePointer(
            child: Switch(
              activeColor: Theme.of(context).backgroundColor,
              value: _isActive,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingTime() {
    ThemeData themeData = Theme.of(context);

    // The reason to put isUtc true to fix the bug when modal display utc values
    // widget display in local date
    String startText = CustomTimeFormatter().format(_startOfWork);
    String endText = CustomTimeFormatter().format(_endOfWork, isEndOfDay: true);

    return AbsorbPointer(
      absorbing: !_isActive,
      child: DefaultTextStyle(
        style: themeData.textTheme.display1.copyWith(
          color: _isActive
              ? themeData.backgroundColor.withOpacity(.65)
              : themeData.backgroundColor.withOpacity(.4),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(Localizer.getLocaleById(LocaleId.from, context)),
            ),
            InkWell(
              child: Text(
                startText,
                style: themeData.textTheme.subtitle.copyWith(
                  color: _isActive
                      ? themeData.backgroundColor.withOpacity(.65)
                      : themeData.backgroundColor.withOpacity(.4),
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: _showIntervalTimePicker,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(Localizer.getLocaleById(LocaleId.to, context)),
            ),
            InkWell(
              child: Text(
                endText,
                style: themeData.textTheme.subtitle.copyWith(
                  color: _isActive
                      ? themeData.backgroundColor.withOpacity(.65)
                      : themeData.backgroundColor.withOpacity(.4),
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: _showIntervalTimePicker,
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
      colors: [
        activeCardColor.withLightness(.5).toColor(),
        activeCardColor.withLightness(.4).toColor()
      ],
    );

    final inactiveGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        inactiveCardColor.withLightness(.5).toColor(),
        inactiveCardColor.withLightness(.4).toColor()
      ],
    );

    return InkWell(
      onLongPress: _showIntervalTimePicker,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
        widget.onChange(_isActive, _startOfWork, _endOfWork);
      },
      child: Column(children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: _isActive ? activeGradient : inactiveGradient,
            boxShadow: [
              const BoxShadow(
                color: Color(0x3A000000),
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
                color: _isActive
                    ? themeData.backgroundColor
                    : themeData.backgroundColor.withOpacity(.65),
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
                        child: Text(Localizer.getLocaleById(
                            _isActive ? LocaleId.working_time : LocaleId.weekend, context)),
                      ),
                      if (_isActive) _buildWorkingTime(),
                    ],
                  ),
                  _buildToggle(),
                ],
              ),
            ),
          ),
        ),
        if (widget.showError) _buildError()
      ]),
    );
  }

  Widget _buildError() {
    TextTheme textTheme = Theme.of(context).textTheme;
    HSLColor errorCardColor = HSLColor.fromColor(EyehelperColorScheme.errorColor);

    return Stack(
      children: [
        Center(
          child: Transform(
            alignment: Alignment.bottomRight,
            transform: Matrix4.rotationZ(-math.pi / 4),
            child: Container(
              color: EyehelperColorScheme.errorColor,
              width: 32.0,
              height: 32.0,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                errorCardColor.withSaturation(.7).toColor(),
                errorCardColor.withSaturation(.6).toColor()
              ],
            ),
            boxShadow: [
              const BoxShadow(
                color: Color(0x3A000000),
                offset: Offset(0.0, 6.0),
                blurRadius: 8.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Text(
              Localizer.getLocaleById(LocaleId.wrong_work_time, context),
              style: textTheme.body1
                  .copyWith(color: EyehelperColorScheme.btnTextWhite.withOpacity(.85)),
            ),
          ),
        ),
      ],
    );
  }
}
