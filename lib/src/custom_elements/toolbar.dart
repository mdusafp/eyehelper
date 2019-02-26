import 'package:eyehelper/src/custom_elements/clip_shadow_path.dart';
import 'package:flutter/material.dart';

class ToolbarWavy extends StatelessWidget {
  final String title;

  ToolbarWavy(this.title);

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      clipper: BottomWaveClipper(),
      shadow: Shadow(blurRadius: 10, color: Colors.grey),
      child: SizedBox(
        height: 120.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.lineTo(0.0, size.height - 40);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final sControlPoint = Offset(size.width * 0.75, size.height);
    final sEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      sControlPoint.dx,
      sControlPoint.dy,
      sEndPoint.dx,
      sEndPoint.dy,
    );

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
