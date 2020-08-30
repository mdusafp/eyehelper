import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class TimePickerDialog extends StatefulWidget {
  final bool showAdd;
  final String customTitle;
  final TimeCardInfo initInfo;
  final Function(TimeCardInfo) onChanged;

  const TimePickerDialog({Key key, this.showAdd = false, this.customTitle, @required this.initInfo, @required this.onChanged}) : super(key: key);

  @override
  _TimePickerDialogState createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  Duration currentDuration;
  Map<WeekDay, bool> currentWeekDays;
  
  @override
  void initState() {
    currentDuration = widget.initInfo?.time ?? Duration();
    if (widget.initInfo?.weekDays != null && widget.initInfo.weekDays.isNotEmpty){
      currentWeekDays = widget.initInfo?.weekDays;
    } else {
      currentWeekDays = {};
      weekList.forEach((item) {
        currentWeekDays[item] = false;
      });
    }

    if (widget.onChanged != null){
      SchedulerBinding.instance.addPostFrameCallback((_){
        widget.onChanged(
          TimeCardInfo(currentDuration, currentWeekDays)
        );
      });
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: (){
                      Navigator.of(context).maybePop(false);
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                      ),
                      width: 48)),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(height: 16),
                                Center(child: Text(widget.customTitle ?? "Параметры")),
                                Container(
                                  height: 140,
                                  child: CupertinoTimerPicker(
                                    onTimerDurationChanged: (time){
                                      currentDuration = time;
                                      setState(() {});
                                      if (widget.onChanged != null){
                                        widget.onChanged(
                                          TimeCardInfo(time, currentWeekDays)
                                        );
                                      }
                                    },
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: currentDuration,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: Column(
                                    children: List.generate(
                                      weekList.length,
                                      (index){
                                        return GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 32.0, right: 32),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    Localizer.getLocaleById(weekList[index].fullLocale, context)
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  width: 20,
                                                  child: Checkbox(
                                                    onChanged: (value){
                                                      currentWeekDays[weekList[index]] = value;
                                                      setState(() {});
                                                      if (widget.onChanged != null){
                                                        widget.onChanged(
                                                          TimeCardInfo(currentDuration, currentWeekDays)
                                                        );
                                                      }
                                                    },
                                                    value: currentWeekDays[weekList[index]] ?? false,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                ),

                                if (widget.showAdd)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 32.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: RoundCustomButton(
                                          parentSize: MediaQuery.of(context).size,
                                          onPressed: () {
                                            Navigator.of(context).maybePop(true);
                                          },
                                          child: Text(
                                            "Добавить",
                                            style: Theme.of(context).textTheme.button,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),

                            Positioned(
                              top: 16.0,
                              right: 16.0,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).maybePop(false);
                                },
                                child: Icon(Icons.close)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: (){
                      Navigator.of(context).maybePop(false);
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                      ),
                      width: 48)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}