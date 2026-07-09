import 'dart:math';
import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget? child;

  PageReveal({
    required this.revealPercent,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClipShadowShadowPainter(
        shadow: Shadow(
          blurRadius: 10,
          offset: Offset(0, 0),
          color: Theme.of(context).accentColor, //color: Color(0xFF000000).withOpacity(0.25),
        ),
        clipper: CircleRevealClipper(revealPercent),
      ),
      child: ClipOval(
        clipper: CircleRevealClipper(revealPercent),
        child: child,
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  CircleRevealClipper(
    this.revealPercent,
  );

  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height - 40);

    // Calculate distance from epicenter to the top left corner to make sure we fill the screen.
    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow? shadow;
  final CustomClipper<Rect> clipper;

  ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    if (shadow == null) {
      return;
    }
    var paint = shadow!.toPaint();
    var clipPath = Path();
    clipPath.addOval(clipper.getClip(size).shift(shadow!.offset));

    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
