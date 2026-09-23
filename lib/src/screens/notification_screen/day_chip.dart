import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

const _idleBorder = Color(0xFFE6ECE8);
const _idleFill = Color(0xFFF1F5F2);

/// Round weekday toggle. [marked] draws a dot underneath — used for days
/// whose hours differ from the rest. [dimmed] is the look inside a switched
/// off row: selection still visible, but grey.
class DayChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool marked;
  final bool dimmed;
  final double size;
  final VoidCallback? onTap;

  const DayChip({
    super.key,
    required this.label,
    required this.selected,
    this.marked = false,
    this.dimmed = false,
    this.size = 34,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color fill;
    final Color border;
    final Color text;
    if (selected && dimmed) {
      fill = _idleFill;
      border = _idleFill;
      text = EyehelperColorScheme.lightGrey;
    } else if (selected) {
      fill = EyehelperColorScheme.activeColor;
      border = EyehelperColorScheme.activeColor;
      text = Colors.white;
    } else {
      fill = Colors.transparent;
      border = _idleBorder;
      text = EyehelperColorScheme.lightGrey;
    }

    final chip = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill,
        border: Border.all(color: border, width: size > 24 ? 1.5 : 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: EyehelperTheme.fontFamily,
          fontSize: size > 24 ? 12 : 9,
          fontWeight: FontWeight.w600,
          color: text,
          height: 1,
        ),
      ),
    );

    final withMark = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        chip,
        const SizedBox(height: 3),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: marked ? const Color(0xFF3B7D5A) : Colors.transparent,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return withMark;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: withMark,
    );
  }
}
