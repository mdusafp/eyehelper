import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/notification.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/custom_times_card.dart';
import 'package:eyehelper/src/screens/notification_screen/mode_card.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_summary.dart';
import 'package:eyehelper/src/screens/notification_screen/working_days_card.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/ad_banner.dart';
import 'package:eyehelper/src/widgets/adaptive_switch.dart';
import 'package:eyehelper/src/widgets/app_bar_blur.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

/// Reminder settings: master switch with a one-line summary, the mode card,
/// and either the working-days card or the custom-times list.
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationsHelper _notificationsHelper = NotificationsHelper(context);
  late final NotificationSettings _settings = NotificationsHelper.getUpdatedSettings();

  /// Remembered while in manual mode, so switching back restores the count.
  late int _autoTimesADay = (_settings.timesADay ?? 1) > 0 ? _settings.timesADay! : 1;

  bool get _manual => _settings.type == NotificationSettings.manualNotifType;

  Future<void> _save() async {
    setState(() {});
    await NotificationsHelper.saveSettings(_settings);
    await _notificationsHelper.scheduleExerciseReminders().catchError((e, stack) {
      debugPrint('$e');
      FirebaseCrashlytics.instance.recordError(e, stack);
    });
  }

  Future<void> _switchNotifications(bool value) async {
    final shouldContinue = value ? await NotificationsHelper.requestPermissions(context) : true;
    if (!shouldContinue) {
      return;
    }
    _settings.notificationsEnabled = value;
    await _save();
  }

  void _setMode(bool manual) {
    if (manual) {
      _settings.type = NotificationSettings.manualNotifType;
      _settings.timesADay = -1;
    } else {
      _settings.type = NotificationSettings.autoNotifType;
      _settings.timesADay = _autoTimesADay;
    }
    _save();
  }

  void _setTimesADay(int n) {
    _autoTimesADay = n;
    _settings.timesADay = n;
    _save();
  }

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final now = DateTime.now();
    final enabled = _settings.notificationsEnabled;
    final todayIndex = now.weekday - 1;
    final today = todayIndex < _settings.dailyScheduleList.length
        ? _settings.dailyScheduleList[todayIndex]
        : null;

    return AppBarBlur(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            viewPadding.top + kGlassAppBarHeight + 12,
            16,
            viewPadding.bottom + 60 + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _MasterCard(
                summary: notificationSummary(context, _settings, now),
                enabled: enabled,
                onChanged: _switchNotifications,
              ),
              // Same frame as on statistics; takes no space until an ad loads.
              AdBanner(
                placement: 'notifications',
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(12),
                decoration: appCardDecoration,
                borderRadius: BorderRadius.circular(12),
              ),
              if (!enabled) ...[
                const SizedBox(height: 12),
                _EnablePromptCard(onEnable: () => _switchNotifications(true)),
              ],
              const SizedBox(height: 12),
              // Settings stay visible while reminders are off, only muted —
              // the user can see what turning them on will do.
              IgnorePointer(
                ignoring: !enabled,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: enabled ? 1 : 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ModeCard(
                        manual: _manual,
                        timesADay: _autoTimesADay,
                        today: today,
                        now: now,
                        onModeChanged: _setMode,
                        onTimesChanged: _setTimesADay,
                      ),
                      const SizedBox(height: 12),
                      if (_manual) ...[
                        CustomTimesCard(
                          items: _settings.customScheduleList ??= [],
                          onToggled: (i, active) {
                            _settings.customScheduleList![i].isActive = active;
                            _save();
                          },
                          onEdited: (i, info) {
                            _settings.customScheduleList![i].cardInfo = info;
                            _save();
                          },
                          onDeleted: (i) {
                            _settings.customScheduleList!.removeAt(i);
                            _save();
                          },
                          onAdded: (info) {
                            // On, right away — a reminder nobody asked to
                            // pause should not start paused.
                            _settings.customScheduleList!.add(
                              CustomSchedule(cardInfo: info, isActive: true),
                            );
                            _save();
                          },
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: AppCardSubtext(
                            context.t.notifications.manualHint,
                            color: EyehelperColorScheme.lightGrey,
                          ),
                        ),
                      ] else
                        WorkingDaysCard(
                          days: _settings.dailyScheduleList,
                          timesADay: _autoTimesADay,
                          onDayToggled: (i, working) {
                            _settings.dailyScheduleList[i].isWorkingDay = working;
                            _save();
                          },
                          onHoursChanged: (indexes, start, end) {
                            for (final i in indexes) {
                              _settings.dailyScheduleList[i]
                                ..startOfWorkInMilliseconds = start.inMilliseconds
                                ..endOfWorkInMilliseconds = end.inMilliseconds;
                            }
                            _save();
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MasterCard extends StatelessWidget {
  final List<String> summary;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const _MasterCard({required this.summary, required this.enabled, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.common.notifications,
                  style: appText(16.5, weight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                for (final line in summary)
                  AppCardSubtext(line, color: EyehelperColorScheme.lightGrey),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AdaptiveSwitch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _EnablePromptCard extends StatelessWidget {
  final VoidCallback onEnable;

  const _EnablePromptCard({required this.onEnable});

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final theme = Theme.of(context).textTheme;
    return AppCard(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        children: [
          Image.asset('assets/firstImageFace5.png', height: 120),
          const SizedBox(height: 10),
          Text(
            t.offTitle,
            textAlign: TextAlign.center,
            style: appText(16.5, weight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          AppCardSubtext(t.offText, textAlign: TextAlign.center),
          const SizedBox(height: 14),
          RoundCustomButton(
            parentSize: MediaQuery.of(context).size,
            onPressed: onEnable,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(t.enableButton, style: theme.labelLarge),
            ),
          ),
        ],
      ),
    );
  }
}
