import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/repositories/settings_repository.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_frequency_picker.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/daily_schedule_card.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationSettings _notificationSettings;
  NotificationsHelper _notificationsHelper;
  SettingsRepository _repository;
  Duration frequency;

  @override
  void initState() {
    super.initState();
    frequency = new Duration();
    _repository = new SettingsRepository(FastPreferences());
    _notificationsHelper = new NotificationsHelper(context);
    _notificationSettings = _repository.getSettings();
  }

  Future<void> _saveSettings() async {
    await _repository.saveSettings(_notificationSettings);
    await _notificationsHelper.scheduleExerciseReminders(_notificationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.body1,
          child: Padding(
            padding: EdgeInsets.only(
              top: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
              bottom: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR + 10.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 32.0),
                  child: NotificationFrequencyPicker(
                    initialFrequency: new Duration(
                      milliseconds: _notificationSettings.notificationFrequencyInMilliseconds,
                    ),
                    onChange: (frequency) async {
                      _notificationSettings.notificationFrequencyInMilliseconds = frequency.duration.inMilliseconds;
                      await _saveSettings();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    Localizer.getLocaleById(LocaleId.choose_time, context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _notificationSettings.dailyScheduleList.length,
                    itemBuilder: (context, i) {
                      final schedule = _notificationSettings.dailyScheduleList[i];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: DailyScheduleCard(
                          name: Localizer.getLocaleById(schedule.localeId, context),
                          isActive: schedule.isWorkingDay,
                          initialStartOfWork: Duration(milliseconds: schedule.startOfWorkInMilliseconds),
                          initialEndOfWork: Duration(milliseconds: schedule.endOfWorkInMilliseconds),
                          onChange: (bool isWorkingDay, Duration startOfWork, Duration endOfWork) async {
                            schedule.isWorkingDay = isWorkingDay;
                            schedule.startOfWorkInMilliseconds = startOfWork.inMilliseconds;
                            schedule.endOfWorkInMilliseconds = endOfWork.inMilliseconds;
                            await _saveSettings();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
