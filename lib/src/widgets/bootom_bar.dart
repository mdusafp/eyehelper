import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/enums/screens.enum.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';
import 'package:flutter/material.dart';

const double PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR = 90.0;

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
    final statisticsButton = IconButton(
      icon: Image.asset(
        'assets/stat_menu_icon.png',
        height: 25,
        color: widget.currentIndex == INDEX_STATISTICS_SCREEN
            ? StandardStyleColors.activeColor
            : StandardStyleColors.lightGrey,
      ),
      onPressed: () => widget.onTap(INDEX_STATISTICS_SCREEN),
    );

    final mainButton = Container(
      height: eyeHeight,
      width: eyeWidth,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: StandardStyleColors.activeColor,
          heroTag: 'mainBtn',
          child: Icon(
            Icons.remove_red_eye,
            color: StandardStyleColors.backgroundWhite,
            size: 30.0,
          ),
          onPressed: () => widget.onTap(INDEX_EYE_SCREEN),
        ),
      ),
    );

    final notificationsButton = IconButton(
      icon: Image.asset(
        'assets/notif_menu_icon.png',
        height: 25,
        color: widget.currentIndex == INDEX_NOTIFICATIONS_SCREEN
            ? StandardStyleColors.activeColor
            : StandardStyleColors.lightGrey,
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () => widget.onTap(INDEX_NOTIFICATIONS_SCREEN),
    );

    return Stack(
      children: <Widget>[
        ClipShadowPath(
          clipper: BottomWaveClipper(),
          shadow: Shadow(blurRadius: 10, color: StandardStyleColors.lightGrey),
          child: Container(
            color: StandardStyleColors.backgroundWhite,
            height: PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR,
            width: MediaQuery.of(context).size.width,
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(
                  top: wv(10),
                  left: hv(30),
                  right: hv(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[statisticsButton, notificationsButton],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15.0,
          left: 80.0,
          right: 80.0,
          child: Container(
            height: 75.0,
            width: 75.0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 17.0),
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[mainButton],
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
