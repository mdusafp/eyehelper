import 'package:eyehelper/src/custom_elements/clip_shadow_path.dart';
import 'package:flutter/material.dart';

class BottomWavy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipShadowPath(
        clipper: WaveClipper(),
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
                    onTap: () {},
                    child: Icon(Icons.notifications),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.notifications),
                  )
                ],
              ),
            )),
      ),
      Positioned(
        bottom: 0.0,
        child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        width: 60.0,
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: 'mainBtn',
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
      )
    ]);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    var firstControlPoint = Offset(size.width * .25, size.height - 55);
    var firstEndPoint = Offset(size.width * .5, size.height - 55);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var sControlPoint = Offset(size.width * .75, size.height - 55);
    var sEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
        sControlPoint.dx, sControlPoint.dy, sEndPoint.dx, sEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
