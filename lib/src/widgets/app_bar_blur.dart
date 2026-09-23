import 'package:flutter/material.dart';
import 'package:gradient_blur/gradient_blur.dart';

/// Height of the glass app bar the tab screens scroll under.
const double kGlassAppBarHeight = 44.0;

/// Progressive blur under the glass app bar.
///
/// Wraps a tab's body: content scrolling up dissolves into the bar instead of
/// showing through the title. Sits below the bar in z-order, so the bar's own
/// glass samples the already-blurred result.
class AppBarBlur extends StatelessWidget {
  const AppBarBlur({super.key, required this.child, this.tail = 36.0});

  final Widget child;

  /// How far below the app bar the blur keeps fading out.
  final double tail;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.viewPaddingOf(context).top;
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: top + kGlassAppBarHeight + tail,
          child: const IgnorePointer(
            child: GradientBlur(
              maxBlur: 8,
              minBlur: 0,
              // Ten slices read as smooth; the default twenty is twenty
              // backdrop passes per frame.
              slices: 10,
              // Blur = max * (1 - curve(t)), so an ease-OUT curve decays the
              // sigma gently toward the bottom edge and the last slices are
              // sub-pixel — no visible seam where the blur ends.
              curve: Curves.easeOutSine,
              child: SizedBox.expand(),
            ),
          ),
        ),
      ],
    );
  }
}
