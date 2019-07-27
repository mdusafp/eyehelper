import 'package:eyehelper/src/helpers/persistent_store.dart';
import 'package:flutter/material.dart';

import 'package:eyehelper/src/dtos/day_schedule_dto.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/notification/notification_config_saver.dart';
import 'package:eyehelper/src/widgets/notification/notification_week_scheduler.dart';
import 'package:eyehelper/src/widgets/notification/notification_frequency_configurator.dart';
import 'package:eyehelper/src/widgets/notification/notification_meta_configurator.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _onToggleNotificationsEnabled(bool value) {}

  void _onToggleApplyToAll(bool value) {}

  void _onToggleDayScheduleEnabled(int index, bool value) {
    print('$index. $value');
  }

  void _onChangeDaySchedule(int index, double lower, double upper) {
    print('$index. lo: $lower, up: $upper');
  }

  void _onChangeFrequency(int value) {}

  Widget _successDialogBuilder(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.done),
              Text('Success'),
            ],
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(context: context, builder: _successDialogBuilder);
  }

  void _onSave() async {
    List<Future> futures = [
      PersistentStore.setNotificationEnabled(true),
      PersistentStore.setApplyAll(false),
      PersistentStore.setWeekSchedule([]),
      PersistentStore.setNotificationFrequency(0),
    ];

    await Future.wait(futures);
    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    List<Future> futures = [
      PersistentStore.notificationEnabled,
      PersistentStore.applyAll,
      PersistentStore.weekSchedule,
      PersistentStore.notificationFrequency,
    ];

    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isNotificationEnabled = snapshot.data[0];
          bool isAppliedToAll = snapshot.data[1];
          // List<DayScheduleDto> weekSchedule = snapshot.data[2];
          List<DayScheduleDto> weekSchedule = [
            new DayScheduleDto(
              name: 'monday',
              min: 0.0,
              max: 24.0,
              lower: 8.0,
              upper: 19.0,
              isEnabled: true,
            ),
            new DayScheduleDto(
              name: 'tuesday',
              min: 0.0,
              max: 24.0,
              lower: 9.0,
              upper: 17.0,
              isEnabled: true,
            ),
            new DayScheduleDto(
              name: 'wednesday',
              min: 0.0,
              max: 24.0,
              lower: 5.0,
              upper: 15.0,
              isEnabled: false,
            ),
            new DayScheduleDto(
              name: 'thursday',
              min: 0.0,
              max: 24.0,
              lower: 10.0,
              upper: 20.0,
              isEnabled: true,
            ),
            new DayScheduleDto(
              name: 'friday',
              min: 0.0,
              max: 24.0,
              lower: 8.0,
              upper: 17.0,
              isEnabled: true,
            ),
            new DayScheduleDto(
              name: 'saturday',
              min: 0.0,
              max: 24.0,
              lower: 9.0,
              upper: 14.0,
              isEnabled: false,
            ),
            new DayScheduleDto(
              name: 'sunday',
              min: 0.0,
              max: 24.0,
              lower: 15.0,
              upper: 22.0,
              isEnabled: true,
            ),
          ];
          int frequency = snapshot.data[3];

          return ListView(
            children: <Widget>[
              NotificationMetaConfigurator(
                isEnabled: isNotificationEnabled,
                isAppliedToAll: isAppliedToAll,
                onToggleEnabled: _onToggleNotificationsEnabled,
                onToggleToApplyAll: _onToggleApplyToAll,
              ),
              NotificationWeekScheduler(
                weekSchedule: weekSchedule,
                onToggleEnabled: _onToggleDayScheduleEnabled,
                onChangeDaySchedule: _onChangeDaySchedule,
              ),
              NotificationFrequencyConfigurator(
                frequency: frequency,
                onChangeFrequency: _onChangeFrequency,
              ),
              NotificationConfigSaver(onPressed: _onSave),
            ],
          );
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                Text('Loading'),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
