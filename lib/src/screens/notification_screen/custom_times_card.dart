import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/models/notification_settings.dart';
import 'package:eyehelper/src/screens/notification_screen/day_chip.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_card_info.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/week.dart';
import 'package:eyehelper/src/screens/notification_screen/notification_summary.dart';
import 'package:eyehelper/src/screens/notification_screen/reminder_time_sheet.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/adaptive_switch.dart';
import 'package:eyehelper/src/widgets/alert_dialog.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';

/// The user's own reminder times as rows: tap to edit, swipe to delete,
/// switch to pause. Adding is the last row of the list.
class CustomTimesCard extends StatelessWidget {
  final List<CustomSchedule> items;
  final void Function(int index, bool isActive) onToggled;
  final void Function(int index, TimeCardInfo info) onEdited;
  final void Function(int index) onDeleted;
  final void Function(TimeCardInfo info) onAdded;

  const CustomTimesCard({
    super.key,
    required this.items,
    required this.onToggled,
    required this.onEdited,
    required this.onDeleted,
    required this.onAdded,
  });

  Future<void> _edit(BuildContext context, int index) async {
    final info = items[index].cardInfo;
    if (info == null) {
      return;
    }
    final result = await showReminderTimeSheet(context, initial: info, isNew: false);
    if (result == null) {
      return;
    }
    if (result.isDelete) {
      onDeleted(index);
    } else {
      onEdited(index, result.info!);
    }
  }

  Future<void> _add(BuildContext context) async {
    final result = await showReminderTimeSheet(
      context,
      initial: TimeCardInfo.defaultCard13,
      isNew: true,
    );
    final info = result?.info;
    if (info != null) {
      onAdded(info);
    }
  }

  /// A swipe is easy to do by accident; the row is gone for good, so ask.
  Future<bool> _confirmDelete(BuildContext context, CustomSchedule schedule) async {
    final t = context.t.notifications;
    final info = schedule.cardInfo;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => EyeHelperAlertDialog(
        title: t.deleteConfirmTitle,
        subtitle: info == null
            ? '—'
            : t.deleteConfirmText(
                time: CustomTimeFormatter().formatShort(info.time),
                days: describeWeekdays(context, _selectedDays(info)),
              ),
        mainBtnTitle: context.t.common.delete,
        mainBtnCallback: () => Navigator.of(dialogContext).pop(true),
        secondaryBtnTitle: context.t.common.cancel,
        secondaryBtnCallback: () => Navigator.of(dialogContext).pop(false),
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Dismissible(
              key: ObjectKey(items[i]),
              direction: DismissDirection.endToStart,
              confirmDismiss: (_) => _confirmDelete(context, items[i]),
              onDismissed: (_) => onDeleted(i),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 8),
                color: EyehelperColorScheme.errorColor.withValues(alpha: 0.12),
                child: const Icon(Icons.delete_outline, color: EyehelperColorScheme.errorColor),
              ),
              child: _TimeRow(
                schedule: items[i],
                first: i == 0,
                onTap: () => _edit(context, i),
                onToggled: (value) => onToggled(i, value),
              ),
            ),
          InkWell(
            onTap: () => _add(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                border: items.isEmpty ? null : const Border(top: BorderSide(color: appHairline)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: EyehelperColorScheme.activeColor, width: 1.5),
                    ),
                    child: const Icon(Icons.add, size: 16, color: appAccentDeep),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    context.t.notifications.addTime,
                    style: appText(15, weight: FontWeight.w600, color: appAccentDeep),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Set<int> _selectedDays(TimeCardInfo info) => {
      for (var i = 0; i < weekList.length; i++)
        if (info.weekDays[weekList[i]] ?? false) i,
    };

class _TimeRow extends StatelessWidget {
  final CustomSchedule schedule;
  final bool first;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggled;

  const _TimeRow({
    required this.schedule,
    required this.first,
    required this.onTap,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    final info = schedule.cardInfo;
    final active = schedule.isActive;
    final selected = info == null ? <int>{} : _selectedDays(info);
    final inkColor = active ? EyehelperColorScheme.mainDark : EyehelperColorScheme.lightGrey;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: first ? null : const Border(top: BorderSide(color: appHairline)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        info == null ? '—' : CustomTimeFormatter().formatShort(info.time),
                        style: appText(26, weight: FontWeight.w200, color: inkColor, height: 1, letterSpacing: -0.5),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          describeWeekdays(context, selected),
                          style: appText(12.5, color: EyehelperColorScheme.lightGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      for (var i = 0; i < weekList.length; i++) ...[
                        if (i > 0) const SizedBox(width: 3),
                        DayChip(
                          label: trKey(context, weekList[i].shortLocale).substring(0, 1),
                          selected: selected.contains(i),
                          dimmed: !active,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AdaptiveSwitch(value: active, onChanged: onToggled),
          ],
        ),
      ),
    );
  }
}
