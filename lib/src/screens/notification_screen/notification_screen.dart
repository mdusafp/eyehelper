import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/models/working_hours.dart';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
 
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:eyehelper/src/screens/notification_screen/apply_to_all.dart';
import 'package:eyehelper/src/screens/notification_screen/notifications_toggle.dart';
import 'package:eyehelper/src/screens/notification_screen/exercise_frequency_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          vertical: 10,
          horizontal: 15,
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
  NotificationsHelper notificationsHelper;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;

    _notificationSettings = new NotificationSettings(
      applyToAll: false,
      notificationsOn: false,
    );

   
    _notificationSettings = NotificationSettings.getSettings();

    if (_notificationSettings.schedule.length == 0) {
      // array of keys from localizer
      List<LocaleId> week = [
        LocaleId.monday_short,
        LocaleId.tuesday_short,
        LocaleId.wednesday_short,
        LocaleId.thursday_short,
        LocaleId.friday_short,
        LocaleId.saturday_short,
        LocaleId.sunday_short,
      ];

      _notificationSettings.schedule = week.map((day) {
        return new WorkingHours(
          name: day,
          values: RangeValues(7, 18),
          isActivated: false,
        );
      }).toList();
    }
  }

  Future<bool> _saveSettings() async {
    return _notificationSettings.setSettings(_notificationSettings);
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
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : buildSettings(context),
            ),
          );
        },
      ),
    );
  }

  Column buildSettings(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
        NotificationsToggle(
          value: _notificationSettings.notificationsOn,
          onChange: (value) {
            setState(() {
              _notificationSettings.notificationsOn = value;
            });
          },
        ),
        Text(
          Localizer.getLocaleById(LocaleId.choose_time, context),
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
        SizedBox(height: 16),
        Text(
          Localizer.getLocaleById(LocaleId.exercise_frequency, context),
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
        SizedBox(height: 16),
        Container(
          width: 180,
          height: 40,
          child: RoundCustomButton(
            child: Text(
              Localizer.getLocaleById(LocaleId.save, context),
              style: StandardStyleTexts.mainBtnText,
            ),
            onPressed: _saveSettings,
          ),
        ),
        SizedBox(height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
      ],
    );
  }
}
