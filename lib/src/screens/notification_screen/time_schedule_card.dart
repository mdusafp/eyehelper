import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/picker_dialog.dart' as Dialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// callback to update parent data (without setState to don't rerender whole widget tree)
typedef void OnChange(bool isActive, TimeCardInfo? info);

// TODO: provide error handler (start date can't be later than end date)
class TimeScheduleCard extends StatefulWidget {
  final bool isActive;
  final TimeCardInfo? initialInfo;
  final OnChange onChange;
  final Function? onDelete;

  const TimeScheduleCard({
    Key? key,
    required this.onChange,
    this.isActive = false,
    this.onDelete,
    required this.initialInfo,
  }) : super(key: key);

  @override
  TimeScheduleCardState createState() => TimeScheduleCardState();
}

class TimeScheduleCardState extends State<TimeScheduleCard> {
  bool _isActive = false;
  TimeCardInfo? currentInfo;
  @override
  void initState() {
    currentInfo = widget.initialInfo;
    super.initState();
    _isActive = widget.isActive;
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
                _isActive = !_isActive;
              });
              widget.onChange(_isActive, currentInfo);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    HSLColor activeCardColor = HSLColor.fromColor(themeData.colorScheme.secondary);
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
      onLongPress: showParamsDialog,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
        widget.onChange(_isActive, currentInfo);
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
              style: themeData.textTheme.bodyText2!.copyWith(
                color: _isActive
                    ? themeData.backgroundColor
                    : themeData.backgroundColor.withOpacity(.65),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 64.0,
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: showParamsDialog,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            CustomTimeFormatter().format(currentInfo!.time, isEndOfDay: true),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: Colors.white, fontSize: 28),
                          ),
                        ),
                      ),
                      Container(height: 8),
                      GestureDetector(
                        onTap: showParamsDialog,
                        child: Container(
                          constraints: BoxConstraints(minWidth: 140, maxWidth: 230),
                          child: Row(
                            children: List.generate(
                              weekList.length,
                              (index) => Expanded(
                                child: CircleAvatar(
                                  backgroundColor: currentInfo!.weekDays[weekList[index]] ?? false
                                      ? Colors.white
                                      : Colors.white24,
                                  minRadius: 13,
                                  child: Center(
                                    child: AutoSizeText(
                                      Localizer.getLocaleById(weekList[index].shortLocale, context),
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.headline3?.copyWith(
                                          color: currentInfo!.weekDays[weekList[index]] ?? false
                                              ? Theme.of(context).primaryColorDark
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildToggle(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void showParamsDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return Center(
          child: Dialog.TimePickerDialog(
            initInfo: currentInfo,
            onDelete: () => widget.onDelete?.call(),
            onChanged: (info) {
              setState(() {
                currentInfo = info;
              });
            },
          ),
        );
      },
    );
    widget.onChange(_isActive, currentInfo);
  }
}
