import 'package:eyehelper/src/custom_elements/clip_shadow_path.dart';
import 'package:flutter/material.dart';

class BottomWavy extends StatefulWidget {
  BottomWavy({Key key, this.onBottomBarTap}) : super(key: key);

  final Function onBottomBarTap;

  _BottomWavyState createState() => _BottomWavyState();
}

class _BottomWavyState extends State<BottomWavy> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipShadowPath(
          clipper: BottomWaveClipper(),
          shadow: Shadow(blurRadius: 10, color: Colors.grey),
          child: Container(
            color: Colors.white,
            height: 100.0,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => widget.onBottomBarTap(1),
                    child: Icon(Icons.settings, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () => widget.onBottomBarTap(2),
                    child: Icon(Icons.notifications, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          // TODO: refactor allWidth / 2 - circleWidth / 2
          left: MediaQuery.of(context).size.width / 2 - 30.0,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Material(
                type: MaterialType.transparency,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      // TODO: move to var heigh and width
                      height: 60.0,
                      width: 60.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 28.0,
                          ),
                          heroTag: 'mainBtn',
                          onPressed: () {
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('123')));
                          },
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
