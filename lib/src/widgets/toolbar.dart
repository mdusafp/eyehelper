import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';
import 'package:flutter/material.dart';

const int PREFERED_HEIGHT_FOR_CUSTOM_APPBAR = 110;

class ToolbarWavy extends StatefulWidget {
  final String title;
  final int currentIndex;

  ToolbarWavy({Key key, this.title, this.currentIndex}) : super(key: key);

  _ToolbarWavyState createState() => _ToolbarWavyState();
}

class _ToolbarWavyState extends State<ToolbarWavy> {
  bool isVibrationActive = true;
  bool isSoundOff = false;

  @override
  Widget build(BuildContext context) {
    return ClipShadowPath(
      clipper: TopWaveClipper(),
      shadow: Shadow(blurRadius: 10, color: StandardStyleColors.lightGrey),
      child: SizedBox(
        height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
        child: Container(
          decoration: BoxDecoration(color: StandardStyleColors.backgroundWhite),
          child: Stack(
            children: <Widget>[

              Container(
                width: MediaQuery.of(context).size.width,
                height: wv(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
                child: Center(
                  child: Text(
                    widget.title,
                    style: StandardStyleTexts.headerMain,
                  ),
                )
              ),

            ],
          )
        ),
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
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
