import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/reminder_times.dart';
import 'package:eyehelper/src/screens/notification_screen/custom_time_picker.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/sheet_scaffold.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';

class WorkingHoursResult {
  final Duration start;
  final Duration end;
  final bool applyToAll;

  const WorkingHoursResult({required this.start, required this.end, required this.applyToAll});
}

/// Two hour wheels plus a live line saying when the reminders will land.
/// [showApplyToAll] is for the per-day entry point; from the shared row the
/// result always applies to every working day.
Future<WorkingHoursResult?> showWorkingHoursSheet(
  BuildContext context, {
  required Duration start,
  required Duration end,
  required int timesADay,
  String? dayName,
  bool showApplyToAll = false,
}) {
  return showAppSheet<WorkingHoursResult>(
    context,
    builder: (context) => _WorkingHoursSheet(
      start: start,
      end: end,
      timesADay: timesADay,
      dayName: dayName,
      showApplyToAll: showApplyToAll,
    ),
  );
}

class _WorkingHoursSheet extends StatefulWidget {
  final Duration start;
  final Duration end;
  final int timesADay;
  final String? dayName;
  final bool showApplyToAll;

  const _WorkingHoursSheet({
    required this.start,
    required this.end,
    required this.timesADay,
    required this.dayName,
    required this.showApplyToAll,
  });

  @override
  State<_WorkingHoursSheet> createState() => _WorkingHoursSheetState();
}

class _WorkingHoursSheetState extends State<_WorkingHoursSheet> {
  late Duration _start = widget.start;
  late Duration _end = widget.end;
  bool _applyToAll = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final formatter = CustomTimeFormatter();
    final times = autoReminderTimes(start: _start, end: _end, timesADay: widget.timesADay);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SheetTitle(
          widget.dayName == null ? t.workingHours : t.workingHoursFor(day: widget.dayName!),
        ),
        SizedBox(
          height: 180,
          child: IntervalPicker(
            showTitle: false,
            startDuration: _start,
            endDuration: _end,
            onChanged: (start, end) => setState(() {
              _start = start;
              _end = end;
            }),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.willRemindAt(times: times.map(formatter.formatShort).join(', ')),
          textAlign: TextAlign.center,
          style: appText(14),
        ),
        if (widget.showApplyToAll) ...[
          const SizedBox(height: 8),
          SheetCheckRow(
            label: t.applyToAllWorking,
            value: _applyToAll,
            onChanged: (value) => setState(() => _applyToAll = value),
          ),
        ],
        const SizedBox(height: 16),
        Center(
          child: RoundCustomButton(
            parentSize: MediaQuery.of(context).size,
            onPressed: () => Navigator.of(context).pop(
              WorkingHoursResult(
                start: _start,
                end: _end,
                applyToAll: !widget.showApplyToAll || _applyToAll,
              ),
            ),
            child: Text(context.t.common.save, style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ],
    );
  }
}
