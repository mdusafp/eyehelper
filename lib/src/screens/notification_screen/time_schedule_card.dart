import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/picker_dialog.dart' as Dialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

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
            activeColor: Theme.of(context).colorScheme.surface,
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
    return InkWell(
      onLongPress: showParamsDialog,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
        widget.onChange(_isActive, currentInfo);
      },
      child: Column(children: [
        GlassCard(
          useOwnLayer: true,
          padding: EdgeInsets.zero,
          shape: const LiquidRoundedRectangle(borderRadius: 20.0),
          settings: LiquidGlassSettings(
            glassColor: _isActive
                ? themeData.colorScheme.secondary.withAlpha(0x99)
                : themeData.primaryColor.withAlpha(0x59),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: DefaultTextStyle(
              style: themeData.textTheme.bodyMedium!.copyWith(
                color: _isActive
                    ? themeData.colorScheme.surface
                    : themeData.colorScheme.surface.withOpacity(.65),
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
                                .headlineSmall
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
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
