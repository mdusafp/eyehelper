import 'package:eyehelper/src/enums/screens.enum.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';
import 'package:flutter/material.dart';

class BottomWavy extends StatefulWidget {
  BottomWavy({
    Key key,
    this.onTap,
    this.currentIndex,
  }) : super(key: key);

  final Function onTap;
  final int currentIndex;

  static int INDEX_STATISTICS_SCREEN = 0;
  static int INDEX_EYE_SCREEN = 1;
  static int INDEX_NOTIFICATIONS_SCREEN = 2;

  _BottomWavyState createState() => _BottomWavyState();
}

class _BottomWavyState extends State<BottomWavy> {
  final double eyeWidth = 60.0;
  final double eyeHeight = 60.0;
  Screens selectedScreen = Screens.main;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipShadowPath(
          clipper: BottomWaveClipper(),
          shadow: Shadow(blurRadius: 10, color: Colors.grey),
          child: Container(
            color: Colors.white,
            height: 90.0,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () =>
                        widget.onTap(BottomWavy.INDEX_STATISTICS_SCREEN),
                    child: Icon(
                      Icons.data_usage,
                      color: widget.currentIndex ==
                          BottomWavy.INDEX_STATISTICS_SCREEN
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        widget.onTap(BottomWavy.INDEX_NOTIFICATIONS_SCREEN),
                    child: Icon(
                      Icons.notifications,
                      color: widget.currentIndex ==
                          BottomWavy.INDEX_NOTIFICATIONS_SCREEN
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: MediaQuery.of(context).size.width / 2 - eyeWidth / 2,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: eyeHeight,
                      width: eyeWidth,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          heroTag: 'mainBtn',
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 28.0,
                          ),
                          onPressed: () =>
                              widget.onTap(BottomWavy.INDEX_EYE_SCREEN),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();

    final firstControlPoint = Offset(size.width * .25, size.height - 55);
    final firstEndPoint = Offset(size.width * .5, size.height - 55);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final sControlPoint = Offset(size.width * .75, size.height - 55);
    final sEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
      sControlPoint.dx,
      sControlPoint.dy,
      sEndPoint.dx,
      sEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
