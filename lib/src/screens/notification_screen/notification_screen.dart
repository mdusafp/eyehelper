// import 'dart:convert';
// import 'package:eyehelper/src/colors.dart';
// import 'package:eyehelper/src/utils/adaptive_utils.dart';
// import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
// import 'package:eyehelper/src/widgets/toolbar.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:scroll_to_index/scroll_to_index.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class ExerciseFrequency extends StatefulWidget {
//   @override
//   _ExerciseFrequencyState createState() => _ExerciseFrequencyState();
// }

// class _ExerciseFrequencyState extends State<ExerciseFrequency> {
//   bool value = false;
//   AutoScrollController _hoursController;
//   AutoScrollController _minutesController;

//   @override
//   void initState() {
//     super.initState();
//     _hoursController = AutoScrollController(
//       axis: Axis.vertical,
//       viewportBoundaryGetter: () =>
//           Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//     );
//     _minutesController = AutoScrollController(
//       axis: Axis.vertical,
//       viewportBoundaryGetter: () =>
//           Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _hoursController.dispose();
//     _minutesController.dispose();
//   }

//   int _hoursIndex = 0;
//   Future _scrollHoursToBottom() async {
//     setState(() {
//       _hoursIndex++;
//     });

//     await _hoursController.scrollToIndex(_hoursIndex);
//     _hoursController.highlight(_hoursIndex);
//   }

//   int _minutesIndex = 0;
//   Future _scrollMinutesToBottom() async {
//     setState(() {
//       _minutesIndex++;
//     });

//     await _minutesController.scrollToIndex(_minutesIndex);
//     _minutesController.highlight(_minutesIndex);
//   }

//   Future _scrollHoursToTop() async {
//     setState(() {
//       _hoursIndex--;
//     });

//     await _hoursController.scrollToIndex(_minutesIndex);
//     _minutesController.highlight(_minutesIndex);
//   }

//   Future _scrollMinutesToTop() async {
//     setState(() {
//       _minutesIndex--;
//     });

//     await _minutesController.scrollToIndex(_minutesIndex);
//     _minutesController.highlight(_minutesIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             child: Text('Times per', style: StandardStyleTexts.display1),
//             padding: const EdgeInsets.only(right: 16),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.keyboard_arrow_up),
//                   onPressed: _scrollHoursToTop,
//                 ),
//                 SizedBox(
//                   child: Container(
//                     color: Colors.amberAccent,
//                     child: ListView.builder(
//                       controller: _hoursController,
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context, index) {
//                         return AutoScrollTag(
//                           key: ValueKey(index),
//                           controller: _hoursController,
//                           index: index,
//                           child: Text(
//                             'index $index',
//                             textAlign: TextAlign.center,
//                             style: StandardStyleTexts.display1,
//                           ),
//                           highlightColor: Colors.black.withOpacity(0.1),
//                         );
//                       },
//                       physics: const NeverScrollableScrollPhysics(),
//                     ),
//                   ),
//                   height: 75.0,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.keyboard_arrow_down),
//                   onPressed: _scrollHoursToBottom,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(':', style: StandardStyleTexts.display1),
//           ),
//           Expanded(
//             child: Column(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.keyboard_arrow_up),
//                   onPressed: _scrollMinutesToTop,
//                 ),
//                 SizedBox(
//                   child: Container(
//                     color: Colors.pinkAccent,
//                     child: ListView.builder(
//                       controller: _minutesController,
//                       padding: EdgeInsets.zero,
//                       itemBuilder: (context, index) {
//                         return AutoScrollTag(
//                           key: ValueKey(index),
//                           controller: _minutesController,
//                           index: index,
//                           child: Container(
//                             height: 25.0,
//                             child: Text(
//                               'index $index',
//                               textAlign: TextAlign.center,
//                               style: StandardStyleTexts.display1,
//                             ),
//                           ),
//                           highlightColor: Colors.black.withOpacity(0.1),
//                         );
//                       },
//                       physics: const NeverScrollableScrollPhysics(),
//                     ),
//                   ),
//                   height: 75.0,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.keyboard_arrow_down),
//                   onPressed: _scrollMinutesToBottom,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// final defaultWeekSchedule = new WeekSchedule([
//   new DaySchedule('M', false, 'Monday', RangeValues(7, 13)),
//   new DaySchedule('T', true, 'Tuesday', RangeValues(9, 18)),
//   new DaySchedule('W', false, 'Wednesday', RangeValues(8, 20)),
//   new DaySchedule('T', false, 'Thursday', RangeValues(8, 19)),
//   new DaySchedule('F', false, 'Friday', RangeValues(9, 18)),
//   new DaySchedule('S', true, 'Saturday', RangeValues(7, 15)),
//   new DaySchedule('S', false, 'Sunday', RangeValues(10, 15)),
// ]);

// class _NotificationScreenState extends State<NotificationScreen> {
//   bool _applyToAll = false;
//   bool _notificationsEnabled = false;
//   ScrollController _hourScrollController;
//   ScrollController _minuteScrollController;

//   WeekSchedule _weekSchedule = new WeekSchedule([
//     new DaySchedule('M', false, 'Monday', RangeValues(7, 13)),
//     new DaySchedule('T', true, 'Tuesday', RangeValues(9, 18)),
//     new DaySchedule('W', false, 'Wednesday', RangeValues(8, 20)),
//     new DaySchedule('T', false, 'Thursday', RangeValues(8, 19)),
//     new DaySchedule('F', false, 'Friday', RangeValues(9, 18)),
//     new DaySchedule('S', true, 'Saturday', RangeValues(7, 15)),
//     new DaySchedule('S', false, 'Sunday', RangeValues(10, 15)),
//   ]);

//   @override
//   void initState() {
//     super.initState();
//     getConfig();
//     // skip first 10000 items to not allow user reach the top
//     double initialScrollOffset = wv(30) * 24 * 10000;
//     _hourScrollController = new ScrollController(
//       initialScrollOffset: initialScrollOffset,
//     );
//     _minuteScrollController = new ScrollController(
//       initialScrollOffset: initialScrollOffset,
//     );
//   }

//   @override
//   dispose() {
//     super.dispose();
//     _hourScrollController.dispose();
//     _minuteScrollController.dispose();
//   }

//   Future<void> getConfig() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _applyToAll = prefs.getBool('apply_to_all') ?? false;
//       _notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
//     });
//   }

//   Future<void> update() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('apply_to_all', _applyToAll);
//     await prefs.setBool('notifications_enabled', _notificationsEnabled);
//     print(json.encode(_weekSchedule));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints viewportConstraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: viewportConstraints.maxHeight,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'Notifications enabled',
//                           style: StandardStyleTexts.display2,
//                         ),
//                         Switch(
//                           value: _notificationsEnabled,
//                           onChanged: (value) {
//                             setState(() {
//                               _notificationsEnabled = value;
//                             });
//                           },
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: hv(30)),
//                       child: Text(
//                         'Select the time when you using PC. Application will notify you to do exercise.',
//                         style: StandardStyleTexts.display2,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: hv(15)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             'Apply to all',
//                             style: StandardStyleTexts.display2,
//                           ),
//                           Checkbox(
//                             value: _applyToAll,
//                             onChanged: (value) {
//                               setState(() {
//                                 _applyToAll = value;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     buildWeekSchedule(),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: hv(30),
//                         vertical: wv(15),
//                       ),
//                       child: Text(
//                         'How often do you want to be notified by application to make exercises?',
//                         style: StandardStyleTexts.display2,
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                     // timesPer,
//                     // Padding(
//                     //   child: ExerciseFrequency(),
//                     //   padding: EdgeInsets.symmetric(horizontal: hv(30)),
//                     // ),
//                     SizedBox(height: wv(15)),
//                     Container(
//                       width: hv(180),
//                       height: wv(40),
//                       child: RoundCustomButton(
//                         onPressed: update,
//                         child: Text(
//                           'Save',
//                           style: StandardStyleTexts.mainBtnText,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Column buildWeekSchedule() {
//     return Column(
//       children: _weekSchedule.days.map((day) {
//         return buildDaySchedule(day);
//       }).toList(),
//     );
//   }

//   Padding buildDaySchedule(DaySchedule daySchedule) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(wv(15), 0, wv(15), hv(10)),
//       child: Card(
//         elevation: 8.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             vertical: wv(10),
//             horizontal: hv(15),
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(daySchedule.abbr, style: StandardStyleTexts.display1),
//               Expanded(
//                 child: AbsorbPointer(
//                   absorbing: !daySchedule.checked,
//                   child: RangeSlider(
//                     activeColor: daySchedule.checked
//                         ? StandardStyleColors.activeColor
//                         : StandardStyleColors.lightGrey,
//                     labels: RangeLabels(
//                         '${daySchedule.rangeValues.start.round()}:00',
//                         '${daySchedule.rangeValues.end.round()}:00'),
//                     divisions: 24,
//                     max: 24,
//                     min: 0,
//                     onChanged: (values) {
//                       setState(() {
//                         daySchedule.rangeValues = values;
//                       });
//                     },
//                     values: daySchedule.rangeValues,
//                   ),
//                 ),
//               ),
//               Switch(
//                 value: daySchedule.checked,
//                 onChanged: (value) {
//                   setState(() {
//                     daySchedule.checked = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WeekSchedule {
//   List<DaySchedule> days;

//   WeekSchedule(this.days);
// }

// class DaySchedule {
//   String abbr;
//   bool checked;
//   String name;
//   RangeValues rangeValues;

//   DaySchedule(this.abbr, this.checked, this.name, this.rangeValues);

//   DaySchedule.fromJson(Map<String, dynamic> json)
//       : abbr = json['abbr'],
//         checked = json['checked'],
//         name = json['name'],
//         rangeValues = json['rangeValues'];

//   Map<String, dynamic> toJson() => {
//         'abbr': abbr,
//         'checked': checked,
//         'name': name,
//         'rangeValues': rangeValues,
//       };
// }

import 'package:eyehelper/src/models/working_hours.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:eyehelper/src/screens/notification_screen/apply_to_all.dart';
import 'package:eyehelper/src/screens/notification_screen/notifications_toggle.dart';
import 'package:eyehelper/src/screens/notification_screen/exercise_frequency_picker.dart';

final logger = new Logger();

typedef void OnToggle(bool value);
typedef void OnChanged(RangeValues values);

class WorkingDay extends StatelessWidget {
  final String name;
  final RangeValues values;
  final bool isActivated;
  final OnToggle onToggle;
  final OnChanged onChanged;

  const WorkingDay({
    Key key,
    this.name,
    this.values,
    this.isActivated,
    this.onToggle,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text(name, style: StandardStyleTexts.display1),
            Expanded(
              child: AbsorbPointer(
                absorbing: !isActivated,
                child: RangeSlider(
                  activeColor: isActivated
                      ? StandardStyleColors.activeColor
                      : StandardStyleColors.lightGrey,
                  labels: RangeLabels(
                      '${values.start.round()}:00', '${values.end.round()}:00'),
                  divisions: 24,
                  max: 24,
                  min: 0,
                  onChanged: onChanged,
                  values: values,
                ),
              ),
            ),
            Switch(
              value: isActivated,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationSettings _notificationSettings;
  SharedPreferencesHelper _sharedPreferencesHelper;

  @override
  void initState() {
    super.initState();

    _notificationSettings = new NotificationSettings(
      applyToAll: false,
      notificationsOn: false,
    );

    _sharedPreferencesHelper = new SharedPreferencesHelper();
    _sharedPreferencesHelper.init().then((prefs) async {
      _notificationSettings = await _sharedPreferencesHelper.getSettings();

      // set default schedule
      // FIXME: kinda workaround not ready to fix it yet
      if (_notificationSettings.schedule.length == 0) {
        // array of keys from localizer
        List<String> week = [
          'monday',
          'tuesday',
          'wednesday',
          'thursday',
          'friday',
          'saturday',
          'sunday',
        ];

        _notificationSettings.schedule = week.map((day) {
          return new WorkingHours(
            name: day,
            values: RangeValues(7, 18),
            isActivated: false,
          );
        }).toList();
      }

      setState(() {});
    });
  }

  Future<bool> _saveSettings() async {
    return _sharedPreferencesHelper.setSettings(_notificationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
                  NotificationsToggle(
                    value: _notificationSettings.notificationsOn,
                    onChange: (value) {
                      setState(() {
                        _notificationSettings.notificationsOn = value;
                      });
                    },
                  ),
                  Text(
                    Localizer.getLocaleById('choose_time', context),
                    style: StandardStyleTexts.display1,
                    textAlign: TextAlign.center,
                  ),
                  ApplyToAll(
                    value: _notificationSettings.applyToAll,
                    onChanged: (value) {
                      setState(() {
                        _notificationSettings.applyToAll = value;
                        _notificationSettings.schedule.forEach((s) {
                          s.isActivated = true;
                        });
                      });
                    },
                  ),
                  ListView.builder(
                    itemCount: _notificationSettings.schedule.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = _notificationSettings.schedule[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: WorkingDay(
                          key: ValueKey(index),
                          isActivated: item.isActivated,
                          name: Localizer.getLocaleById(item.name, context),
                          values: item.values,
                          onToggle: (value) {
                            setState(() {
                              item.isActivated = value;

                              if (!value) {
                                _notificationSettings.applyToAll = false;
                              }
                            });
                          },
                          onChanged: (values) {
                            setState(() {
                              item.values = values;
                            });
                          },
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  SizedBox(height: wv(16)),
                  Text(
                    Localizer.getLocaleById('exercise_frequency', context),
                    textAlign: TextAlign.center,
                    style: StandardStyleTexts.display1,
                  ),
                  ExerciseFrequencyPicker(
                    value: _notificationSettings.notificationFrequency,
                    onChangeFrequency: (value) {
                      setState(() {
                        _notificationSettings.notificationFrequency =
                            value.millisecondsSinceEpoch;
                      });
                    },
                  ),
                  SizedBox(height: wv(16)),
                  Container(
                    width: hv(180),
                    height: wv(40),
                    child: RoundCustomButton(
                      child: Text(
                        Localizer.getLocaleById('save', context),
                        style: StandardStyleTexts.mainBtnText,
                      ),
                      onPressed: _saveSettings,
                    ),
                  ),
                  SizedBox(height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
