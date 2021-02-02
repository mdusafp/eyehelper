import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/frequency.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/picker_dialog.dart';
import 'package:eyehelper/src/screens/notification_screen/time_schedule_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
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
  Set<int> _errorIndexes;
  NotificationSettings _notificationSettings;
  NotificationsHelper _notificationsHelper;
  Duration frequency;

  //TEMP
  Frequency currentFreq;
  //

  @override
  void initState() {
    super.initState();
    frequency = new Duration();
    _notificationsHelper = new NotificationsHelper(context);
    _notificationSettings = NotificationsHelper.getUpdatedSettings();

    try {
      currentFreq =
          frequencies.firstWhere((element) => element.timesADay == _notificationSettings.timesADay);
    } catch (e) {/* No such element */}

    _errorIndexes = new Set();
    _notificationSettings.dailyScheduleList.asMap().forEach((i, schedule) {
      if (schedule.endOfWorkInMilliseconds <= schedule.startOfWorkInMilliseconds) {
        _errorIndexes.add(i);
      }
    });
  }

  Future<void> _saveSettings() async {
    await NotificationsHelper.saveSettings(_notificationSettings);
    await _notificationsHelper.scheduleExerciseReminders().catchError((e, stack) {
      debugPrint(e);
      FirebaseCrashlytics.instance.recordError(e, stack);
    });
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
              // left: 16.0,
              // right: 16.0,
            ),
            child: Column(
              children: <Widget>[
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 400),
                  crossFadeState: _notificationSettings?.notificationsEnabled ?? false
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: <Widget>[
                        Container(height: 10),
                        _getNotificationsEnabledHeader(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 65.0),
                          child: Image.asset(
                            'assets/firstImageFace5.png',
                            height: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: Text(
                            "Включите их\nчтобы приложение подсказало вам,\nчто пора позаниматься, когда вы будете на работе.",
                            // Localizer.getLocaleById(LocaleId.choose_time, context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Container(
                          height: 24,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: RoundCustomButton(
                              parentSize: MediaQuery.of(context).size,
                              width: 250,
                              onPressed: () async {
                                _notificationSettings.notificationsEnabled = true;
                                // final settings = _settingsRepository.getSettings();
                                // await _notificationHelper.scheduleExerciseReminders(settings);

                                setState(() {});

                                _saveSettings();
                              },
                              child: Text(
                                "Включить Уведомления",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  secondChild: Column(
                    children: <Widget>[
                      Container(
                        height: 10,
                      ),
                      _getNotificationsEnabledHeader(),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 32.0, top: 32.0, left: 16.0, right: 16.0),
                        child: NotificationFrequencyPicker(
                          initialFrequency: currentFreq ?? frequencies[0],
                          onChange: (frequency) async {
                            currentFreq = frequency;
                            setState(() {});
                            _notificationSettings.type = frequency?.type == FrequencyType.manual
                                ? NotificationSettings.manualNotifType
                                : NotificationSettings.autoNotifType;
                            _notificationSettings.timesADay = frequency.timesADay;
                            _saveSettings();
                          },
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 400),
                        crossFadeState:
                            currentFreq != null && currentFreq.type == FrequencyType.manual
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                        firstChild: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 32.0,
                                right: 32.0,
                                bottom: 32.0,
                              ),
                              child: Text(
                                "Установите время, в которое вы хотите получать уведомления и приложение напомнит вам об упражнениях",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: _notificationSettings.customScheduleList.length,
                                itemBuilder: (context, i) {
                                  final schedule = _notificationSettings.customScheduleList[i];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: TimeScheduleCard(
                                      initialInfo: schedule.cardInfo,
                                      isActive: schedule.isActive,
                                      onDelete: () {
                                        _notificationSettings.customScheduleList.remove(schedule);
                                        setState(() {});
                                        _saveSettings();
                                      },
                                      onChange: (bool isActive, TimeCardInfo cardInfo) async {
                                        schedule.isActive = isActive;
                                        schedule.cardInfo = cardInfo;

                                        try {
                                          await _saveSettings();
                                          _errorIndexes.clear();
                                        } catch (e) {
                                          _errorIndexes.clear();

                                          _notificationSettings.dailyScheduleList
                                              .asMap()
                                              .forEach((i, schedule) {
                                            if (schedule.endOfWorkInMilliseconds <=
                                                schedule.startOfWorkInMilliseconds) {
                                              _errorIndexes.add(i);
                                            }
                                          });
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: RoundCustomButton(
                                  parentSize: MediaQuery.of(context).size,
                                  onPressed: () async {
                                    TimeCardInfo infoResult;

                                    bool shouldAdd = await showDialog<bool>(
                                        context: context,
                                        child: Center(
                                            child: TimePickerDialog(
                                          showAdd: true,
                                          customTitle: "Укажите параметры",
                                          initInfo: TimeCardInfo.defaultCard13,
                                          onChanged: (info) {
                                            infoResult = info;
                                          },
                                        )));
                                    if (shouldAdd != null && shouldAdd) {
                                      _notificationSettings.customScheduleList.add(
                                        CustomSchedule(cardInfo: infoResult, isActive: false),
                                      );
                                    }

                                    setState(() {});
                                    _saveSettings();
                                  },
                                  child: Text(
                                    "Добавить время",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        secondChild: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 32.0,
                              ),
                              child: Text(
                                Localizer.getLocaleById(LocaleId.choose_time, context),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(color: Theme.of(context).primaryColorDark),
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
                                    padding: const EdgeInsets.only(
                                        bottom: 16.0, left: 16.0, right: 16.0),
                                    child: DailyScheduleCard(
                                      name: Localizer.getLocaleById(schedule.localeId, context),
                                      showError: _errorIndexes.contains(i),
                                      isActive: schedule.isWorkingDay,
                                      initialStartOfWork: Duration(
                                          milliseconds: schedule.startOfWorkInMilliseconds),
                                      initialEndOfWork:
                                          Duration(milliseconds: schedule.endOfWorkInMilliseconds),
                                      onChange: (bool isWorkingDay, Duration startOfWork,
                                          Duration endOfWork) async {
                                        schedule.isWorkingDay = isWorkingDay;
                                        schedule.startOfWorkInMilliseconds =
                                            startOfWork.inMilliseconds;
                                        schedule.endOfWorkInMilliseconds = endOfWork.inMilliseconds;

                                        try {
                                          await _saveSettings();
                                          _errorIndexes.clear();
                                        } catch (e) {
                                          _errorIndexes.clear();

                                          _notificationSettings.dailyScheduleList
                                              .asMap()
                                              .forEach((i, schedule) {
                                            if (schedule.endOfWorkInMilliseconds <=
                                                schedule.startOfWorkInMilliseconds) {
                                              _errorIndexes.add(i);
                                            }
                                          });
                                        }

                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getNotificationsEnabledHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AutoSizeText(
              _notificationSettings?.notificationsEnabled ?? false
                  ? "Уведомления включены"
                  : "Уведомления отключены",
              // Localizer.getLocaleById(LocaleId.choose_time, context),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
          Switch(
            onChanged: (value) async {
              _notificationSettings.notificationsEnabled = value;
              setState(() {});

              _saveSettings();
            },
            value: _notificationSettings?.notificationsEnabled ?? false,
          ),
        ],
      ),
    );
  }
}
