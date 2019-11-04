import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/repositories/settings_repository.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_frequency_picker.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/daily_schedule_card.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationSettings _notificationSettings;
  SettingsRepository _repository;
  Duration frequency;

  @override
  void initState() {
    super.initState();
    _repository = new SettingsRepository(FastPreferences());
    _notificationSettings = _repository.getSettings();
    frequency = new Duration();
  }

  Future<void> _saveSettings() async {
    await _repository.saveSettings(_notificationSettings);
    // TODO: add notification that settings saved
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.body1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
              horizontal: 16.0,
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Localizer.getLocaleById(LocaleId.notifications_on, context),
                          textAlign: TextAlign.center,
                        ),
                        Switch(
                          value: _notificationSettings.notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationSettings.notificationsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        Localizer.getLocaleById(LocaleId.choose_time, context),
                        textAlign: TextAlign.center,
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: DailyScheduleCard(
                              name:
                                  Localizer.getLocaleById(_notificationSettings.dailyScheduleList[i].localeId, context),
                              isActive: _notificationSettings.dailyScheduleList[i].isWorkingDay,
                              onChange: (bool isWorkingDay, Duration startOfWork, Duration endOfWork) {
                                _notificationSettings.dailyScheduleList[i].isWorkingDay = isWorkingDay;
                                _notificationSettings.dailyScheduleList[i].startOfWorkInMilliseconds =
                                    startOfWork.inMilliseconds;
                                _notificationSettings.dailyScheduleList[i].endOfWorkInMilliseconds =
                                    endOfWork.inMilliseconds;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: NotificationFrequencyPicker(
                        initialFrequency:
                            new Duration(milliseconds: _notificationSettings.notificationFrequencyInMilliseconds),
                        onChange: (frequency) {
                          _notificationSettings.notificationFrequencyInMilliseconds = frequency.inMilliseconds;
                        },
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 180.0,
                      child: RoundCustomButton(
                        child: Text(
                          Localizer.getLocaleById(LocaleId.save, context),
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: _saveSettings,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
