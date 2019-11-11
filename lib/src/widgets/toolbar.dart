import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';
import 'package:flutter/material.dart';

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
        height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
        child: Container(
          decoration: BoxDecoration(color: StandardStyleColors.backgroundWhite),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
                child: Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                ),
              ),
              if (FastPreferences().prefs != null && widget.currentIndex == 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 1/12),
                    child: InkWell(
                      onTap: () async {
                        FastPreferences().prefs.setBool(
                          FastPreferences.isVibrationEnabled, 
                          !(FastPreferences().prefs
                            .getBool(FastPreferences.isVibrationEnabled) ?? false)
                        ).then((_)=> setState(()=>{}));
                      },
                      child: Container(
                        height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR * 1/3,
                        width: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR * 1/3,
                        child: Icon(
                          Icons.vibration,
                          color: (FastPreferences().prefs
                            .getBool(FastPreferences.isVibrationEnabled) ?? false)
                              ? Theme.of(context).accentColor : StandardStyleColors.mainDark
                        )
                      ),
                    ),
                  ),
                )
            ],
          ),
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
