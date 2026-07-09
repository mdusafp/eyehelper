import 'package:flutter/material.dart';

/// Static app background: white base with a soft green gradient rising from
/// the bottom edge, giving the glass bottom bar something to refract.
class AppBackground extends StatelessWidget {
  const AppBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ColoredBox(
        color: Colors.white,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 340,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFFCFE9DB),
                  Color(0x00FFFFFF),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
