import 'package:flutter/material.dart';

/// Static decorative background: a light brand gradient with soft radial
/// color blobs that give the liquid glass surfaces something to refract.
class AppBackground extends StatelessWidget {
  const AppBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FBF9), Color(0xFFE7F3EC)],
          ),
        ),
        child: const Stack(
          fit: StackFit.expand,
          children: [
            _Blob(alignment: Alignment(1.3, -0.9), size: 340, color: Color(0x38509F75)),
            _Blob(alignment: Alignment(-1.4, -0.1), size: 400, color: Color(0x2A5FB39B)),
            _Blob(alignment: Alignment(1.0, 1.15), size: 320, color: Color(0x3384C9A8)),
          ],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final Alignment alignment;
  final double size;
  final Color color;

  const _Blob({
    required this.alignment,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withAlpha(0)],
          ),
        ),
      ),
    );
  }
}
