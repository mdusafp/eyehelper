import 'package:eyehelper/src/helpers/notification.dart';
import 'package:flutter/material.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/widgets/clip_shadow_path.dart';

class ToolbarWavy extends StatefulWidget {
  final String title;
  final int currentIndex;

  ToolbarWavy({Key key, this.title, this.currentIndex}) : super(key: key);

  _ToolbarWavyState createState() => _ToolbarWavyState();
}

class _ToolbarWavyState extends State<ToolbarWavy> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ClipShadowPath(
      clipper: TopWaveClipper(),
      shadow: Shadow(blurRadius: 8, color: themeData.primaryColor),
      child: SizedBox(
        height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
        child: Container(
          decoration: BoxDecoration(color: themeData.backgroundColor),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
                child: Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              if (FastPreferences().prefs != null && widget.currentIndex == 1)
                _buildVibration(context),
              // if (FastPreferences().prefs != null && widget.currentIndex == 2) _buildNotification(context),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildVibration(BuildContext context) {
    final prefs = FastPreferences().prefs;
    final key = FastPreferences.isVibrationEnabled;
    final value = prefs.getBool(key) ?? true;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 1 / 12),
        child: InkWell(
          onTap: () async {
            await prefs.setBool(key, !value);
            setState(() {});
          },
          child: Container(
            height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR * 1 / 3,
            width: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR * 1 / 3,
            child: Icon(
              Icons.vibration,
              color: value ? Theme.of(context).accentColor : EyehelperColorScheme.mainDark,
            ),
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
