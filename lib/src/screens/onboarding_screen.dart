import 'package:auto_size_text/auto_size_text.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/fancy_on_boarding.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:eyehelper/i18n/tr.dart';
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
                      context.t.onboarding.title1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    body: Text(
                      context.t.onboarding.subtitle1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                PageModel(
                    color: Colors.white,
                    heroAssetPath: 'assets/exercises_onb.png',
                    title: Text(context.t.onboarding.title2,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                    body: Text(
                      context.t.onboarding.subtitle2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    )),
                PageModel(
                  color: Colors.white,
                  heroAssetPath: 'assets/notif_onb.png',
                  title: Text(
                    context.t.onboarding.title3,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
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
                        context.t.notifications.setupButton,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Text(context.t.onboarding.subtitle3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
