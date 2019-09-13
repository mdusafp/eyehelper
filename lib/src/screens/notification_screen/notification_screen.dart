import 'package:eyehelper/src/models/working_hours.dart';
import 'package:flutter/material.dart';

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
