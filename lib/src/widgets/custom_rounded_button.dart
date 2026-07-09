import 'dart:math';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Primary pill CTA: green-tinted liquid glass, keeps white text readable.
class RoundCustomButton extends StatelessWidget {
  final Size parentSize;
  final Widget child;
  final double? width;
  final double heightAbs;
  final Function onPressed;
  final BoxShadow shadow;

  const RoundCustomButton({
    Key? key,
    required this.parentSize,
    required this.child,
    this.shadow = const BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0.0, 3.0),
      blurRadius: 6.0,
    ),
    this.width,
    this.heightAbs = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: GlassCard(
        // Own layer so the button also works on plain Material routes
        // (onboarding, about screen) outside the GlassScaffold layer.
        useOwnLayer: true,
        width: width ?? min(240.0, parentSize.width),
        height: heightAbs,
        padding: EdgeInsets.zero,
        shape: LiquidRoundedRectangle(borderRadius: heightAbs / 2),
        settings: LiquidGlassSettings(
          glassColor: EyehelperColorScheme.activeColor.withAlpha(0x99),
        ),
        child: Center(child: child),
      ),
    );
  }
}

/// Secondary pill button: clear liquid glass with a thin accent border.
class FlatRoundCustomButton extends StatelessWidget {
  final Size parentSize;
  final Widget child;
  final double? width;
  final double heightAbs;
  final Function onPressed;
  final Color? color;

  const FlatRoundCustomButton({
    Key? key,
    required this.parentSize,
    required this.child,
    this.width,
    this.color,
    this.heightAbs = 50.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.secondary;
    return GestureDetector(
      onTap: () => onPressed(),
      child: GlassCard(
        useOwnLayer: true,
        width: width ?? min(240.0, parentSize.width),
        height: heightAbs,
        padding: EdgeInsets.zero,
        shape: LiquidRoundedRectangle(
          borderRadius: heightAbs / 2,
          side: BorderSide(color: accent, width: 1.5),
        ),
        child: Center(child: child),
      ),
    );
  }
}
