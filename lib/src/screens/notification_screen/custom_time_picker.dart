import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kItemExtent = 32.0;
// The density of a date picker is different from a generic picker.
// Eyeballed from iOS.
const double _kSqueeze = 1.25;
// Considers setting the default background color from the theme, in the future.
const Color _kBackgroundColor = CupertinoColors.white;

class CustomTimerPicker extends StatefulWidget {

  CustomTimerPicker({
    this.mode = CupertinoTimerPickerMode.hm,
    this.initialTimerDuration = Duration.zero,
    this.minuteInterval = 1,
    this.secondInterval = 1,
    @required this.onTimerDurationChanged,
  }) : assert(mode != null),
       assert(onTimerDurationChanged != null),
       assert(initialTimerDuration >= Duration.zero),
       assert(initialTimerDuration < const Duration(days: 1)),
       assert(minuteInterval > 0 && 60 % minuteInterval == 0),
       assert(secondInterval > 0 && 60 % secondInterval == 0),
       assert(initialTimerDuration.inMinutes % minuteInterval == 0),
       assert(initialTimerDuration.inSeconds % secondInterval == 0);

  /// The mode of the timer picker.
  final CupertinoTimerPickerMode mode;

  /// The initial duration of the countdown timer.
  final Duration initialTimerDuration;

  /// The granularity of the minute spinner. Must be a positive integer factor
  /// of 60.
  final int minuteInterval;

  /// The granularity of the second spinner. Must be a positive integer factor
  /// of 60.
  final int secondInterval;

  /// Callback called when the timer duration changes.
  final ValueChanged<Duration> onTimerDurationChanged;

  @override
  State<StatefulWidget> createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  int textDirectionFactor;
  CupertinoLocalizations localizations;
  double _kPickerWidth = 400.0;

  // Alignment based on text direction. The variable name is self descriptive,
  // however, when text direction is rtl, alignment is reversed.
  Alignment alignCenterLeft;
  Alignment alignCenterRight;

  // The currently selected values of the picker.
  int selectedHour;
  int selectedMinute;
  int selectedSecond;

  @override
  void initState() {
    super.initState();

    selectedMinute = selectedSecond = widget.initialTimerDuration.inSeconds % 60;
    selectedHour = widget.initialTimerDuration.inHours;
  }

  // Builds a text label with customized scale factor and font weight.
  Widget _buildLabel(String text) {
    return Text(
      text,
      textScaleFactor: 0.9,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Theme.of(context).primaryColor
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    textDirectionFactor = Directionality.of(context) == TextDirection.ltr ? 1 : -1;
    localizations = CupertinoLocalizations.of(context);

    alignCenterLeft = textDirectionFactor == 1 ? Alignment.centerLeft : Alignment.centerRight;
    alignCenterRight = textDirectionFactor == 1 ? Alignment.centerRight : Alignment.centerLeft;
  }

  Widget _buildHourPicker() {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: selectedHour),
      offAxisFraction: -0.5 * textDirectionFactor,
      itemExtent: _kItemExtent,
      backgroundColor: _kBackgroundColor,
      squeeze: _kSqueeze,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedHour = index;
          widget.onTimerDurationChanged(
            Duration(
              hours: selectedHour,
              minutes: selectedMinute,
              seconds: selectedSecond ?? 0));
        });
      },
      children: List<Widget>.generate(24, (int index) {
        final double hourLabelWidth = _kPickerWidth / 6;

        final String semanticsLabel = textDirectionFactor == 1
          ? localizations.timerPickerHour(index) + localizations.timerPickerHourLabel(index)
          : localizations.timerPickerHourLabel(index) + localizations.timerPickerHour(index);

        return Semantics(
          label: semanticsLabel,
          excludeSemantics: true,
          child: Container(
            alignment: alignCenterRight,
            padding: textDirectionFactor == 1
              ? EdgeInsets.only(right: hourLabelWidth)
              : EdgeInsets.only(left: hourLabelWidth),
            child: Container(
              alignment: alignCenterRight,
              // Adds some spaces between words.
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                localizations.timerPickerHour(index),
                style: Theme.of(context).textTheme.display1.copyWith(
                  color: Theme.of(context).primaryColor
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHourColumn() {
    final Widget hourLabel = IgnorePointer(
      child: Container(
        alignment: alignCenterRight,
        child: Container(
          alignment: alignCenterLeft,
          // Adds some spaces between words.
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          width: _kPickerWidth / 6,
          child: _buildLabel(localizations.timerPickerHourLabel(selectedHour)),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        _buildHourPicker(),
        hourLabel,
      ],
    );
  }

  Widget _buildMinutePicker() {
    double offAxisFraction = 0.5 * textDirectionFactor;

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
        initialItem: selectedMinute ~/ widget.minuteInterval,
      ),
      offAxisFraction: offAxisFraction,
      itemExtent: _kItemExtent,
      backgroundColor: _kBackgroundColor,
      squeeze: _kSqueeze,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedMinute = index * widget.minuteInterval;
          widget.onTimerDurationChanged(
            Duration(
              hours: selectedHour ?? 0,
              minutes: selectedMinute,
              seconds: selectedSecond ?? 0));
        });
      },
      children: List<Widget>.generate(60 ~/ widget.minuteInterval, (int index) {
        final int minute = index * widget.minuteInterval;

        final String semanticsLabel = textDirectionFactor == 1
          ? localizations.timerPickerMinute(minute) + localizations.timerPickerMinuteLabel(minute)
          : localizations.timerPickerMinuteLabel(minute) + localizations.timerPickerMinute(minute);

          return Semantics(
            label: semanticsLabel,
            excludeSemantics: true,
            child: Container(
              alignment: alignCenterLeft,
              child: Container(
                alignment: alignCenterRight,
                width: _kPickerWidth / 10,
                // Adds some spaces between words.
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  localizations.timerPickerMinute(minute),
                  style: Theme.of(context).textTheme.display1.copyWith(
                    color: Theme.of(context).primaryColor
                  )
                ),
              ),
            ),
          );
      }),
    );
  }

  Widget _buildMinuteColumn() {
    Widget minuteLabel = IgnorePointer(
        child: Container(
          alignment: alignCenterLeft,
          padding: textDirectionFactor == 1
            ? EdgeInsets.only(left: _kPickerWidth / 10)
            : EdgeInsets.only(right: _kPickerWidth / 10),
          child: Container(
            alignment: alignCenterLeft,
            // Adds some spaces between words.
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildLabel(localizations.timerPickerMinuteLabel(selectedMinute)),
          ),
        ),
      );

    return Stack(
      children: <Widget>[
        _buildMinutePicker(),
        minuteLabel,
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    _kPickerWidth = min(window.physicalSize.width, 440);

    return MediaQuery(
      data: const MediaQueryData(
        textScaleFactor: 1.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: _buildHourColumn()),
          Expanded(child: _buildMinuteColumn()),
        ],
      ),
    );
  }
}
