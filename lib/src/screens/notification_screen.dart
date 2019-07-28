import 'dart:convert';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

final defaultWeekSchedule = new WeekSchedule([
  new DaySchedule('M', false, 'Monday', RangeValues(7, 13)),
  new DaySchedule('T', true, 'Tuesday', RangeValues(9, 18)),
  new DaySchedule('W', false, 'Wednesday', RangeValues(8, 20)),
  new DaySchedule('T', false, 'Thursday', RangeValues(8, 19)),
  new DaySchedule('F', false, 'Friday', RangeValues(9, 18)),
  new DaySchedule('S', true, 'Saturday', RangeValues(7, 15)),
  new DaySchedule('S', false, 'Sunday', RangeValues(10, 15)),
]);

class _NotificationScreenState extends State<NotificationScreen> {
  bool _applyToAll = false;
  bool _notificationsEnabled = false;
  ScrollController _hourScrollController;
  ScrollController _minuteScrollController;

  WeekSchedule _weekSchedule = new WeekSchedule([
    new DaySchedule('M', false, 'Monday', RangeValues(7, 13)),
    new DaySchedule('T', true, 'Tuesday', RangeValues(9, 18)),
    new DaySchedule('W', false, 'Wednesday', RangeValues(8, 20)),
    new DaySchedule('T', false, 'Thursday', RangeValues(8, 19)),
    new DaySchedule('F', false, 'Friday', RangeValues(9, 18)),
    new DaySchedule('S', true, 'Saturday', RangeValues(7, 15)),
    new DaySchedule('S', false, 'Sunday', RangeValues(10, 15)),
  ]);

  @override
  void initState() {
    super.initState();
    getConfig();
    // skip first 10000 items to not allow user reach the top
    double initialScrollOffset = wv(30) * 24 * 10000;
    _hourScrollController = new ScrollController(
      initialScrollOffset: initialScrollOffset,
    );
    _minuteScrollController = new ScrollController(
      initialScrollOffset: initialScrollOffset,
    );
  }

  @override
  dispose() {
    super.dispose();
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
  }

  Future<void> getConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _applyToAll = prefs.getBool('apply_to_all') ?? false;
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
    });
  }

  Future<void> update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('apply_to_all', _applyToAll);
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    print(json.encode(_weekSchedule));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Notifications enabled',
                          style: StandardStyleTexts.display2,
                        ),
                        Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hv(30)),
                      child: Text(
                        'Select the time when you using PC. Application will notify you to do exercise.',
                        style: StandardStyleTexts.display2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hv(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Apply to all',
                            style: StandardStyleTexts.display2,
                          ),
                          Checkbox(
                            value: _applyToAll,
                            onChanged: (value) {
                              setState(() {
                                _applyToAll = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    buildWeekSchedule(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: hv(30),
                        vertical: wv(15),
                      ),
                      child: Text(
                        'How often do you want to be notified by application to make exercises?',
                        style: StandardStyleTexts.display2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hv(30)),
                      child: Row(
                        children: <Widget>[
                          Text('Times per', style: StandardStyleTexts.display1),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                controller: _hourScrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        '${index % 24}h',
                                        style: StandardStyleTexts.display1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        height: wv(1),
                                        width: hv(30),
                                        color: StandardStyleColors.activeColor,
                                      ),
                                    ],
                                  );
                                },
                                itemExtent: wv(30),
                              ),
                            ),
                          ),
                          Text(':', style: StandardStyleTexts.display1),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                controller: _minuteScrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        '${index % 60}m',
                                        style: StandardStyleTexts.display1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        height: wv(1),
                                        width: hv(30),
                                        color: StandardStyleColors.activeColor,
                                      ),
                                    ],
                                  );
                                },
                                itemExtent: wv(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: wv(15)),
                    Container(
                      width: hv(180),
                      height: wv(40),
                      child: RoundCustomButton(
                        onPressed: update,
                        child: Text(
                          'Save',
                          style: StandardStyleTexts.mainBtnText,
                        ),
                      ),
                    ),
                    SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column buildWeekSchedule() {
    return Column(
      children: _weekSchedule.days.map((day) {
        return buildDaySchedule(day);
      }).toList(),
    );
  }

  Padding buildDaySchedule(DaySchedule daySchedule) {
    return Padding(
      padding: EdgeInsets.fromLTRB(wv(15), 0, wv(15), hv(10)),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: wv(10),
            horizontal: hv(15),
          ),
          child: Row(
            children: <Widget>[
              Text(daySchedule.abbr, style: StandardStyleTexts.display1),
              Expanded(
                child: AbsorbPointer(
                  absorbing: !daySchedule.checked,
                  child: RangeSlider(
                    activeColor: daySchedule.checked
                        ? StandardStyleColors.activeColor
                        : StandardStyleColors.lightGrey,
                    labels: RangeLabels(
                        '${daySchedule.rangeValues.start.round()}:00',
                        '${daySchedule.rangeValues.end.round()}:00'),
                    divisions: 24,
                    max: 24,
                    min: 0,
                    onChanged: (values) {
                      setState(() {
                        daySchedule.rangeValues = values;
                      });
                    },
                    values: daySchedule.rangeValues,
                  ),
                ),
              ),
              Switch(
                value: daySchedule.checked,
                onChanged: (value) {
                  setState(() {
                    daySchedule.checked = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeekSchedule {
  List<DaySchedule> days;

  WeekSchedule(this.days);
}

class DaySchedule {
  String abbr;
  bool checked;
  String name;
  RangeValues rangeValues;

  DaySchedule(this.abbr, this.checked, this.name, this.rangeValues);

  DaySchedule.fromJson(Map<String, dynamic> json)
      : abbr = json['abbr'],
        checked = json['checked'],
        name = json['name'],
        rangeValues = json['rangeValues'];

  Map<String, dynamic> toJson() => {
        'abbr': abbr,
        'checked': checked,
        'name': name,
        'rangeValues': rangeValues,
      };
}
