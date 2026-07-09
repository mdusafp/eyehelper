import 'package:flutter/material.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/enums/screens.enum.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';

class BottomWavy extends StatefulWidget {
  BottomWavy({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final Function onTap;
  final int currentIndex;

  _BottomWavyState createState() => _BottomWavyState();
}

class _BottomWavyState extends State<BottomWavy> with SingleTickerProviderStateMixin {
  final double eyeWidth = Utils().PREFERED_EYE_SIZE;
  final double eyeHeight = Utils().PREFERED_EYE_SIZE;
  Screens selectedScreen = Screens.main;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    final statisticsButton = IconButton(
      icon: Image.asset(
        'assets/stat_menu_icon.png',
        height: 24.0,
        color: widget.currentIndex == INDEX_STATISTICS_SCREEN
            ? themeData.accentColor
            : themeData.primaryColor,
      ),
      onPressed: () => widget.onTap(INDEX_STATISTICS_SCREEN),
    );

    final mainButton = Container(
      height: eyeHeight,
      width: eyeWidth,
      child: FittedBox(
        child: FloatingActionButton(
          mini: widget.currentIndex != INDEX_EYE_SCREEN,
          backgroundColor: widget.currentIndex == INDEX_EYE_SCREEN
              ? themeData.accentColor
              : themeData.primaryColor,
          heroTag: 'mainBtn',
          child: Icon(
            Icons.remove_red_eye,
            color: themeData.backgroundColor,
            size: widget.currentIndex == INDEX_EYE_SCREEN ? 32.0 : 24,
          ),
          onPressed: () => widget.onTap(INDEX_EYE_SCREEN),
        ),
      ),
    );

    final notificationsButton = IconButton(
      icon: Icon(
        Icons.settings,
        size: 24.0,
        color: widget.currentIndex == INDEX_NOTIFICATIONS_SCREEN
            ? themeData.accentColor
            : themeData.primaryColor,
      ),
      color: Theme.of(context).primaryColor,
      onPressed: () => widget.onTap(INDEX_NOTIFICATIONS_SCREEN),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          ClipShadowPath(
            clipper: BottomWaveClipper(),
            shadow: Shadow(blurRadius: 10, color: themeData.primaryColor),
            child: Container(
              color: themeData.backgroundColor,
              height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR,
              width: MediaQuery.of(context).size.width,
              child: Material(
                type: MaterialType.transparency,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    left: 32.0,
                    right: 32.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[statisticsButton, notificationsButton],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: (Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR - eyeHeight) * 3 / 4),
            child: Align(alignment: Alignment.bottomCenter, child: mainButton),
          ),
        ],
      ),
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
