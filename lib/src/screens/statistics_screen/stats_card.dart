import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';

export 'package:eyehelper/src/helpers/format_duration.dart';

/// Surface shared by every block on the statistics tab — also lent to the ad
/// slot so it reads as one more card rather than a foreign rectangle.
final BoxDecoration statsCardDecoration = appCardDecoration;

/// White rounded surface shared by every block on the statistics tab.
class StatsCard extends StatelessWidget {
  final Widget child;

  const StatsCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) => AppCard(child: child);
}

/// Small uppercase caption above a block.
class StatsLabel extends StatelessWidget {
  final String text;

  const StatsLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) => AppCardLabel(text);
}

/// Quiet secondary line inside a card.
class StatsSubtext extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const StatsSubtext(this.text, {super.key, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) => AppCardSubtext(text, color: color, textAlign: textAlign);
}

/// Large light-weight figure with a small unit next to it.
class StatsBigNumber extends StatelessWidget {
  final String value;
  final String unit;
  final double size;

  const StatsBigNumber({super.key, required this.value, required this.unit, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value,
          style: theme.titleSmall?.copyWith(
            fontSize: size,
            color: EyehelperColorScheme.mainDark,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            unit,
            style: theme.bodyMedium?.copyWith(color: EyehelperColorScheme.mainDark),
          ),
        ),
      ],
    );
  }
}
