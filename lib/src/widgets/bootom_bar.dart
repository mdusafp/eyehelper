import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
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
          shadow: Shadow(blurRadius: 10, color: StandartStyle.lightGrey),
          child: Container(
            color: StandartStyle.backgroundWhite,
            height: 75.0,
            width: MediaQuery.of(context).size.width,
            child: Material(
              type: MaterialType.transparency,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => widget.onTap(INDEX_STATISTICS_SCREEN),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          bottom: 15.0,
                          right: 10.0,
                        ),
                        child: Image.asset(
                          'assets/stat_menu_icon.png',
                          height: 25.0,
                          color: widget.currentIndex == INDEX_STATISTICS_SCREEN
                              ? StandartStyle.activeColor
                              : StandartStyle.lightGrey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => widget.onTap(INDEX_NOTIFICATIONS_SCREEN),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        child: Image.asset(
                          'assets/notif_menu_icon.png',
                          height: 25.0,
                          color:
                              widget.currentIndex == INDEX_NOTIFICATIONS_SCREEN
                                  ? StandartStyle.activeColor
                                  : StandartStyle.lightGrey,
                        ),
                      ),
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
            height: 75,
            child: Padding(
              padding: EdgeInsets.only(bottom: 17.0),
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
                          backgroundColor: StandartStyle.activeColor,
                          heroTag: 'mainBtn',
                          child: Icon(
                            Icons.remove_red_eye,
                            color: StandartStyle.backgroundWhite,
                            size: 30.0,
                          ),
                          onPressed: () => widget.onTap(INDEX_EYE_SCREEN),
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

    final firstControlPoint = Offset(size.width * .25, size.height * 0.45);
    final firstEndPoint = Offset(size.width * .5, size.height * 0.45);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final sControlPoint = Offset(size.width * .75, size.height * 0.45);
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
