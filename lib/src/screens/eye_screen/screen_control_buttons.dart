import 'package:eyehelper/src/widgets/round_control_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ScreenControlButtons extends StatefulWidget {
  final String text;
  final bool paused;
  final bool stopped;
  final Function pauseResumeCallback;
  final Function finishCallback;
  final Function callbackStartFace;

  const ScreenControlButtons({
    Key key,
    @required this.paused,
    @required this.stopped,
    @required this.pauseResumeCallback,
    @required this.finishCallback,
    @required this.callbackStartFace,
    @required this.text,
  }) : super(key: key);

  @override
  _ScreenControlButtonsState createState() => _ScreenControlButtonsState();
}

class _ScreenControlButtonsState extends State<ScreenControlButtons> {
  int counterVal = 3;
  String counterStr;
  Timer _startCounterTimer;

  bool trainingStarted = false;

  bool mainTimerPause = true;

  @override
  void dispose() {
    _startCounterTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    counterStr = '$counterVal...';

    _startCounterTimer = new Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        counterVal--;
        counterStr = '$counterVal...';
      });

      if (counterVal == 0) {
        widget.callbackStartFace();
        trainingStarted = true;
        t.cancel();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RoundControlButton(
                  imagePath: mainTimerPause ? 'assets/pause_control.png' : 'assets/play_control.png',
                  callback: () {
                    setState(() {
                      mainTimerPause = !mainTimerPause;
                    });
                    widget.pauseResumeCallback();
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                !trainingStarted ? counterStr : widget.text,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ),
              Expanded(
                flex: 1,
                child: RoundControlButton(
                  imagePath: 'assets/flag_control.png',
                  callback: () {
                    trainingStarted = false;
                    widget.finishCallback();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
