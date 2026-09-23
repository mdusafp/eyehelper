import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/helpers/ads/ads_service.dart';
import 'package:eyehelper/src/screens/eye_screen/feedback_card.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';

class FinishTrainingScreen extends StatefulWidget {
  final Function? showProcessCallback;

  const FinishTrainingScreen({Key? key, this.showProcessCallback}) : super(key: key);

  @override
  _FinishTrainingScreenState createState() => _FinishTrainingScreenState();
}

class _FinishTrainingScreenState extends State<FinishTrainingScreen> {
  /// While the "do you like the app" card is up it carries the accent; the
  /// Continue button steps back to an outline until it is answered.
  late bool _feedbackDue = FeedbackCard.isDue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).padding.top + 52,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 18.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                            bottom: 6.0,
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: Center(
                            child: Text(
                              context.t.finish.goodJob,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge, // StandardStyleTexts.eyeScreenHeader,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 20.0, right: 20.0),
                          child: Center(
                            child: Text(
                                context.t.finish.youDoneExercises,
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                            bottom: 10.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                          ),
                          child: SizedBox(
                            height: 160.0,
                            width: 160.0,
                            child: Image.asset('assets/finish_face.png'),
                          ),
                        ),
                        if (_feedbackDue)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: FeedbackCard(
                              onAnswered: () => setState(() => _feedbackDue = false),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).padding.bottom + 124.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 94.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: _feedbackDue
                    ? FlatRoundCustomButton(
                        parentSize: MediaQuery.of(context).size,
                        onPressed: _continue,
                        child: Text(
                          context.t.common.continueButton,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: appAccentDeep),
                        ),
                      )
                    : RoundCustomButton(
                        parentSize: MediaQuery.of(context).size,
                        onPressed: _continue,
                        child: Text(
                          context.t.common.continueButton,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _continue() async {
    // Leaving the finish screen is the one safe spot for a full-screen ad:
    // the training is over and nothing is interrupted. Rate-limited inside
    // the service.
    await AdsService().maybeShowInterstitial();
    widget.showProcessCallback?.call();
  }
}
