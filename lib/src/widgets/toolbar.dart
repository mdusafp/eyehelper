import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';
import 'package:flutter/material.dart';

const double PREFERED_HEIGHT_FOR_CUSTOM_APPBAR = 110.0;

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
        height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
        child: Container(
          decoration: BoxDecoration(color: StandardStyleColors.backgroundWhite),
          child: Stack(
            children: <Widget>[

              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Text(
                      widget.title,
                      style: StandardStyleTexts.headerMain,
                    ),
                  ),
                )
              ),


              widget.currentIndex == INDEX_EYE_SCREEN ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isVibrationActive = !isVibrationActive;
                              });
                            },
                            child: Icon(
                              Icons.vibration,
                              size: 24.0,
                              color: isVibrationActive ? StandardStyleColors.activeColor : StandardStyleColors.lightGrey,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isSoundOff = !isSoundOff;
                              });
                            },
                            child: Icon(
                              Icons.volume_off,
                              size: 24.0,
                              color: isSoundOff ? StandardStyleColors.activeColor : StandardStyleColors.lightGrey,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ) : Container()
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
