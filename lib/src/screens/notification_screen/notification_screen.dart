import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/notification_screen/daily_schedule_card.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
// import 'package:eyehelper/src/screens/notification_screen/daily_schedule_card.dart';
// import 'package:eyehelper/src/helpers/notification.dart';
// import 'package:eyehelper/src/widgets/toolbar.dart';
// import 'package:eyehelper/src/locale/Localizer.dart';
// import 'package:eyehelper/src/models/notification_settings.dart';
// import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
// import 'package:eyehelper/src/screens/notification_screen/notifications_toggle.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationSettings _notificationSettings;
  SettingsRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = new SettingsRepository(FastPreferences());
    _notificationSettings = _repository.getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
            horizontal: 16.0,
          ),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.body1,
            child: Column(
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _notificationSettings.dailyScheduleList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DailyScheduleCard(
                        name: Localizer.getLocaleById(_notificationSettings.dailyScheduleList[i].localeId, context),
                        isActive: _notificationSettings.dailyScheduleList[i].isWorkingDay,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// // TODO: show tooltip on first user interaction with this page upper the monday
// class _NotificationScreenState extends State<NotificationScreen> {
//   NotificationSettings _notificationSettings;
//   NotificationsHelper notificationsHelper;

//   @override
//   void initState() {
//     super.initState();

//     _notificationSettings = new NotificationSettings(
//       notificationsOn: false,
//     );

//     _notificationSettings = NotificationSettings.getSettings();
//   }

//   Future<bool> _saveSettings() async {
//     return _notificationSettings.setSettings(_notificationSettings);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints viewportConstraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: viewportConstraints.maxHeight,
//               ),
//               child: buildSettings(context),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget buildSettings(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
//             child: NotificationsToggle(
//               value: _notificationSettings.notificationsOn,
//               onChange: (value) {
//                 setState(() {
//                   _notificationSettings.notificationsOn = value;
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: Text(
//               Localizer.getLocaleById(LocaleId.choose_time, context),
//               style: textTheme.body1,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: 7,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: DailyScheduleCard(
//                   name: Localizer.getLocaleById(week[index], context),
//                 ),
//               );
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: Text(
//               Localizer.getLocaleById(LocaleId.exercise_frequency, context),
//               textAlign: TextAlign.center,
//               style: textTheme.body1,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[Text('Раз в '), Text('1 час')],
//             ),
//           ),
//           Container(
//             height: 40.0,
//             width: 180.0,
//             child: RoundCustomButton(
//               child: Text(
//                 Localizer.getLocaleById(LocaleId.save, context),
//                 style: textTheme.button,
//               ),
//               onPressed: _saveSettings,
//             ),
//           ),
//           SizedBox(
//             height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
//           ),
//         ],
//       ),
//     );
//   }
// }
