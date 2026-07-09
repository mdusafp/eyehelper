import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/fancy_on_boarding.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  final Function(int)? onSetupSettings;

  const OnBoardingScreen({Key? key, this.onSetupSettings}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  GlobalKey<FancyOnBoardingState> key = GlobalKey<FancyOnBoardingState>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: FancyOnBoarding(
              key: key,
              onDoneButtonPressed: () {
                FastPreferences().prefs.setBool(FastPreferences.wasOnboardingShown, true);
                Navigator.of(context).pop();
              },
              onSkipButtonPressed: () {
                FastPreferences().prefs.setBool(FastPreferences.wasOnboardingShown, true);
                Navigator.of(context).pop();
              },
              pageIndexChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              pageList: [
                PageModel(
                    color: Colors.white,
                    heroAssetPath: 'assets/work_onb.png',
                    title: Text(
                      Localizer.getLocaleById(LocaleId.onb_title1, context),
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).accentColor,
                          ),
                    ),
                    body: Text(
                      Localizer.getLocaleById(LocaleId.onb_subtitle1, context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                PageModel(
                    color: Colors.white,
                    heroAssetPath: 'assets/exercises_onb.png',
                    title: Text(Localizer.getLocaleById(LocaleId.onb_title2, context),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).accentColor,
                            )),
                    body: Text(
                      Localizer.getLocaleById(LocaleId.onb_subtitle2, context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                PageModel(
                  color: Colors.white,
                  heroAssetPath: 'assets/notif_onb.png',
                  title: Text(
                    Localizer.getLocaleById(LocaleId.onb_title3, context),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                  button: RoundCustomButton(
                    parentSize: MediaQuery.of(context).size,
                    onPressed: () async {
                      if (await NotificationsHelper.requestPermissions(context)) {
                        FastPreferences().prefs.setBool(FastPreferences.wasOnboardingShown, true);
                        final _notificationsHelper = new NotificationsHelper(context);
                        final _notificationSettings = NotificationsHelper.getUpdatedSettings();
                        _notificationSettings.notificationsEnabled = true;
                        await NotificationsHelper.saveSettings(_notificationSettings);
                        await _notificationsHelper
                            .scheduleExerciseReminders()
                            .catchError((e, stack) {
                          debugPrint(e);
                          FirebaseCrashlytics.instance.recordError(e, stack);
                        });
                        widget.onSetupSettings?.call(2);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: AutoSizeText(
                        Localizer.getLocaleById(LocaleId.setup_notifications, context),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Text(Localizer.getLocaleById(LocaleId.onb_subtitle3, context),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                color: Theme.of(context).primaryColor,
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
