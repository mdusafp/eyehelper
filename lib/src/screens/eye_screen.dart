import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class EyeScreen extends StatefulWidget {
  @override
  _EyeScreenState createState() => _EyeScreenState();
}

class _EyeScreenState extends State<EyeScreen> {
  String currentAnimation = '';

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: FlareActor(
                "assets/eyeTopBotFast.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'fastTopBot',
              )
            )
          ],
        ),
      )
    );
  }
}