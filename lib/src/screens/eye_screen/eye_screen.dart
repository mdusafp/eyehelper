import 'package:eyehelper/src/screens/eye_screen/swiper_main.dart';
import 'package:flutter/material.dart';

class EyeScreen extends StatefulWidget {
  @override
  _EyeScreenState createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
      child: SwiperMain(),
    );
  }
}