import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/screens/notification_screen/day_chip.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/sheet_scaffold.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderTimeResult {
  /// Null when the user asked to delete the reminder.
  final TimeCardInfo? info;

  const ReminderTimeResult.saved(TimeCardInfo this.info);

  const ReminderTimeResult.deleted() : info = null;

  bool get isDelete => info == null;
}

/// Clock wheel, seven day chips, quick sets. Returns null when dismissed.
Future<ReminderTimeResult?> showReminderTimeSheet(
  BuildContext context, {
  required TimeCardInfo initial,
  required bool isNew,
}) {
  return showAppSheet<ReminderTimeResult>(
    context,
    builder: (context) => _ReminderTimeSheet(initial: initial, isNew: isNew),
  );
}

class _ReminderTimeSheet extends StatefulWidget {
  final TimeCardInfo initial;
  final bool isNew;

  const _ReminderTimeSheet({required this.initial, required this.isNew});

  @override
  State<_ReminderTimeSheet> createState() => _ReminderTimeSheetState();
}

class _ReminderTimeSheetState extends State<_ReminderTimeSheet> {
  static const _minuteStep = 5;

  late Duration _time = widget.initial.time;
  late final Map<WeekDay, bool> _days = {
    for (final day in weekList) day: widget.initial.weekDays[day] ?? false,
  };

  bool get _anyDay => _days.values.any((v) => v);

  void _setDays(bool Function(WeekDay day) selected) {
    setState(() {
      for (final day in weekList) {
        _days[day] = selected(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final theme = Theme.of(context).textTheme;

    // The wheel needs a minute on its own grid.
    final minutes = _time.inMinutes % 60;
    final initial = DateTime(2000, 1, 1, _time.inHours, minutes - minutes % _minuteStep);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(widget.isNew ? t.newReminder : t.reminder),
        SizedBox(
          height: 160,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            minuteInterval: _minuteStep,
            initialDateTime: initial,
            onDateTimeChanged: (value) =>
                _time = Duration(hours: value.hour, minutes: value.minute),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final day in weekList)
              DayChip(
                label: trKey(context, day.shortLocale),
                selected: _days[day] ?? false,
                size: 38,
                onTap: () => setState(() => _days[day] = !(_days[day] ?? false)),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _QuickSet(t.weekdays, () => _setDays((d) => d.weekDay.index < 5)),
            _QuickSet(t.everyDay, () => _setDays((_) => true)),
            _QuickSet(t.weekendDays, () => _setDays((d) => d.weekDay.index >= 5)),
          ],
        ),
        if (!_anyDay)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              t.pickAtLeastOneDay,
              textAlign: TextAlign.center,
              style: appText(13, color: EyehelperColorScheme.errorColor),
            ),
          ),
        Center(
          child: Opacity(
            opacity: _anyDay ? 1 : 0.5,
            child: RoundCustomButton(
              parentSize: MediaQuery.of(context).size,
              onPressed: () {
                if (!_anyDay) {
                  return;
                }
                Navigator.of(context).pop(
                  ReminderTimeResult.saved(TimeCardInfo(_time, Map.of(_days))),
                );
              },
              child: Text(
                widget.isNew ? context.t.common.add : context.t.common.save,
                style: theme.labelLarge,
              ),
            ),
          ),
        ),
        if (!widget.isNew)
          TextButton(
            onPressed: () => Navigator.of(context).pop(const ReminderTimeResult.deleted()),
            child: Text(
              t.deleteReminder,
              style: appText(13, color: EyehelperColorScheme.errorColor),
            ),
          ),
      ],
    );
  }
}

class _QuickSet extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickSet(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label, style: appText(14, weight: FontWeight.w600, color: appAccentDeep)),
    );
  }
}
