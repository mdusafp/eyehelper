import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/day_chip.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/working_hours_sheet.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';

typedef HoursChanged = void Function(Set<int> dayIndexes, Duration start, Duration end);

/// Seven day toggles, one row of hours for all of them, and a fold-out list
/// for the days that differ. Backed by the same seven [DailySchedule]s that
/// used to be seven cards.
class WorkingDaysCard extends StatefulWidget {
  final List<DailySchedule> days;
  final int timesADay;
  final void Function(int dayIndex, bool isWorking) onDayToggled;
  final HoursChanged onHoursChanged;

  const WorkingDaysCard({
    super.key,
    required this.days,
    required this.timesADay,
    required this.onDayToggled,
    required this.onHoursChanged,
  });

  @override
  State<WorkingDaysCard> createState() => _WorkingDaysCardState();
}

class _WorkingDaysCardState extends State<WorkingDaysCard> {
  bool _expanded = false;

  Set<int> get _working => {
        for (var i = 0; i < widget.days.length; i++)
          if (widget.days[i].isWorkingDay) i,
      };

  _Interval _intervalOf(int i) => _Interval(
        Duration(milliseconds: widget.days[i].startOfWorkInMilliseconds),
        Duration(milliseconds: widget.days[i].endOfWorkInMilliseconds),
      );

  /// The interval most working days share — what the shared row shows and
  /// what a day has to differ from to earn its dot.
  _Interval? get _majority {
    final counts = <_Interval, int>{};
    for (final i in _working) {
      counts.update(_intervalOf(i), (c) => c + 1, ifAbsent: () => 1);
    }
    if (counts.isEmpty) {
      return null;
    }
    return counts.entries.reduce((a, b) => b.value > a.value ? b : a).key;
  }

  bool get _allSame => _working.map(_intervalOf).toSet().length <= 1;

  Future<void> _editShared() async {
    final base = _majority ?? _Interval(const Duration(hours: 8), const Duration(hours: 16));
    final result = await showWorkingHoursSheet(
      context,
      start: base.start,
      end: base.end,
      timesADay: widget.timesADay,
    );
    if (result == null) {
      return;
    }
    widget.onHoursChanged(_working, result.start, result.end);
  }

  Future<void> _editDay(int i) async {
    final current = _intervalOf(i);
    final result = await showWorkingHoursSheet(
      context,
      start: current.start,
      end: current.end,
      timesADay: widget.timesADay,
      dayName: trKey(context, weekList[i].fullLocale).toLowerCase(),
      showApplyToAll: true,
    );
    if (result == null) {
      return;
    }
    widget.onHoursChanged(result.applyToAll ? _working : {i}, result.start, result.end);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final formatter = CustomTimeFormatter();
    final majority = _majority;
    final working = _working;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardLabel(t.workingDays),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < widget.days.length; i++)
                DayChip(
                  label: trKey(context, weekList[i].shortLocale),
                  selected: widget.days[i].isWorkingDay,
                  marked: widget.days[i].isWorkingDay &&
                      majority != null &&
                      _intervalOf(i) != majority,
                  onTap: () => widget.onDayToggled(i, !widget.days[i].isWorkingDay),
                ),
            ],
          ),
          if (working.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: AppCardSubtext(t.noWorkingDays, color: EyehelperColorScheme.errorColor),
            ),
          const SizedBox(height: 4),
          _Row(
            label: t.workingHours,
            first: true,
            value: majority == null
                ? '—'
                : _allSame
                    ? '${formatter.formatShort(majority.start)} – ${formatter.formatShort(majority.end)}'
                    : t.hoursDiffer,
            onTap: working.isEmpty ? null : _editShared,
          ),
          // An action, not a setting — coloured like a link so it is found.
          _Row(
            label: t.perDaySetup,
            value: _expanded ? t.collapse : '',
            accent: true,
            icon: _expanded ? Icons.expand_less : Icons.expand_more,
            onTap: () => setState(() => _expanded = !_expanded),
          ),
          if (_expanded)
            for (var i = 0; i < widget.days.length; i++)
              _DayRow(
                name: trKey(context, weekList[i].fullLocale),
                schedule: widget.days[i],
                differs: majority != null && _intervalOf(i) != majority,
                onTap: widget.days[i].isWorkingDay
                    ? () => _editDay(i)
                    : () => widget.onDayToggled(i, true),
              ),
        ],
      ),
    );
  }
}

class _Interval {
  final Duration start;
  final Duration end;

  const _Interval(this.start, this.end);

  @override
  bool operator ==(Object other) =>
      other is _Interval && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;
  final bool first;
  final IconData icon;
  final VoidCallback? onTap;

  const _Row({
    required this.label,
    required this.value,
    this.onTap,
    this.accent = false,
    this.first = false,
    this.icon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    final color = accent ? appAccentDeep : EyehelperColorScheme.mainDark;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: first ? null : const Border(top: BorderSide(color: appHairline)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: appText(15, color: color, weight: accent ? FontWeight.w600 : FontWeight.normal),
              ),
            ),
            Text(value, style: appText(14, color: accent ? appAccentDeep : EyehelperColorScheme.lightGrey)),
            const SizedBox(width: 4),
            Icon(icon, size: 20, color: accent ? appAccentDeep : EyehelperColorScheme.lightGrey),
          ],
        ),
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final String name;
  final DailySchedule schedule;
  final bool differs;
  final VoidCallback? onTap;

  const _DayRow({
    required this.name,
    required this.schedule,
    required this.differs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final formatter = CustomTimeFormatter();
    final start = Duration(milliseconds: schedule.startOfWorkInMilliseconds);
    final end = Duration(milliseconds: schedule.endOfWorkInMilliseconds);
    final invalid = end <= start;

    final String value;
    final Color valueColor;
    if (!schedule.isWorkingDay) {
      // A day off is one tap from being a working day, so say so.
      value = t.enableDay;
      valueColor = appAccentDeep;
    } else {
      value = '${formatter.formatShort(start)} – ${formatter.formatShort(end)}';
      valueColor = invalid
          ? EyehelperColorScheme.errorColor
          : differs
              ? appAccentDeep
              : EyehelperColorScheme.mainDark;
    }
    final weight = differs ? FontWeight.w600 : FontWeight.normal;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: appHairline)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: appText(
                  14,
                  weight: differs ? FontWeight.w600 : FontWeight.normal,
                  color: schedule.isWorkingDay
                      ? EyehelperColorScheme.mainDark
                      : EyehelperColorScheme.lightGrey,
                ),
              ),
            ),
            Text(value, style: appText(14, weight: weight, color: valueColor)),
            const SizedBox(width: 4),
            // Working days open a sheet, hence the chevron; a day off just
            // flips on in place.
            Icon(
              Icons.chevron_right,
              size: 20,
              color: schedule.isWorkingDay ? EyehelperColorScheme.lightGrey : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
