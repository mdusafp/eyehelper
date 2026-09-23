import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

/// The one card surface used by the statistics and reminder tabs, so both
/// read as the same app.
final BoxDecoration appCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(24),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ],
);

/// Text at a fixed point size, for cards that need finer steps than the
/// theme's text styles offer.
///
/// Fira Sans ships only regular (registered as 500) and light (200), so
/// anything heavier is synthesised — use [FontWeight.w600] for emphasis and
/// nothing in between.
TextStyle appText(
  double size, {
  FontWeight weight = FontWeight.normal,
  Color color = EyehelperColorScheme.mainDark,
  double height = 1.25,
  double letterSpacing = 0,
}) {
  return TextStyle(
    fontFamily: EyehelperTheme.fontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

/// Accent one shade deeper than the brand green, for text that has to read
/// on white.
const Color appAccentDeep = Color(0xFF3B7D5A);

/// Hairline between rows inside a card.
const Color appHairline = Color(0xFFE6ECE8);

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: appCardDecoration,
      child: child,
    );
  }
}

/// Heading of a block inside a card. Sentence case — the tabs had enough
/// capitals — but dark and bold enough to read as a heading, not a caption.
class AppCardLabel extends StatelessWidget {
  final String text;

  const AppCardLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: appText(14, weight: FontWeight.w600, color: EyehelperColorScheme.mainDark),
    );
  }
}

/// Quiet secondary line inside a card.
class AppCardSubtext extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const AppCardSubtext(this.text, {super.key, this.color, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: appText(13, color: color ?? EyehelperColorScheme.mainDark, height: 1.35),
    );
  }
}
