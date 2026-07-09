import 'package:eyehelper/src/screens/eye_screen/finish_training_screen.dart';
import 'package:eyehelper/src/screens/eye_screen/swiper_main.dart';
import 'package:flutter/material.dart';

class EyeScreen extends StatefulWidget {
  @override
  _EyeScreenState createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 300),
        crossFadeState: showResult ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild:
            FinishTrainingScreen(showProcessCallback: () => setState(() => showResult = false)),
        secondChild: SwiperMain(showResultCallback: () => setState(() => showResult = true)),
      ),
    );
  }
}
