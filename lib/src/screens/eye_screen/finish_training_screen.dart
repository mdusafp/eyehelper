import 'dart:io';

import 'package:app_review/app_review.dart';
import 'package:eyehelper/app_id.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/eye_screen/rating_stars.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/utils.dart';
import 'package:eyehelper/src/widgets/alert_dialog.dart';

import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class FinishTrainingScreen extends StatefulWidget {
  final Function showProcessCallback;

  const FinishTrainingScreen({Key key, this.showProcessCallback}) : super(key: key);

  @override
  _FinishTrainingScreenState createState() => _FinishTrainingScreenState();
}

class _FinishTrainingScreenState extends State<FinishTrainingScreen> {
  bool ratingChanged = false;
  bool liked = false;
  int initRating = 0;
  FastPreferences fastPrefs;
  @override
  void initState() {
    fastPrefs = FastPreferences();
    liked = fastPrefs?.prefs?.getBool(FastPreferences.userLikedApp) ?? false;
    initRating = fastPrefs?.prefs?.getInt(FastPreferences.userAppRating) ?? 0;
    super.initState();
  }

  bool get shouldShowDialog {
    final lastRated = fastPrefs?.prefs?.getInt(FastPreferences.userRatedTheAppTime);
    if (lastRated == null || lastRated is! int) {
      return true;
    }
    if (DateTime.fromMillisecondsSinceEpoch(lastRated).difference(DateTime.now()).inDays > 7) {
      return true;
    }
    return false;
  }

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
                          height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
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
                              Localizer.getLocaleById(LocaleId.good_job, context),
                              style: Theme.of(context)
                                  .textTheme
                                  .title, // StandardStyleTexts.eyeScreenHeader,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 20.0, right: 20.0),
                          child: Center(
                            child: Text(
                                Localizer.getLocaleById(LocaleId.you_done_excercises, context),
                                style: Theme.of(context).textTheme.subtitle,
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                            bottom: 15.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                            left: 50.0,
                            right: 50.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkResponse(
                                radius: 25.0,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    liked = !liked;
                                  });
                                  fastPrefs.prefs.setBool(FastPreferences.userLikedApp, liked);
                                  if (liked && shouldShowDialog) {
                                    _showWantToValueDialog();
                                  }
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Center(
                                    child: Icon(
                                      liked ? Icons.favorite : Icons.favorite_border,
                                      size: 30.0,
                                      color: liked ? Colors.red : EyehelperColorScheme.mainDark,
                                    ),
                                  ),
                                ),
                              ),
                              InkResponse(
                                highlightColor: Colors.transparent,
                                radius: 25.0,
                                onTap: () {
                                  Share.share(
                                      Localizer.getLocaleById(LocaleId.there_is_app, context));
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Center(
                                    child: Icon(
                                      Icons.share,
                                      color: EyehelperColorScheme.mainDark,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0 * (Utils().IS_SMALL_DEVICE ? 1 / 3 : 1),
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: Center(
                            child: Text(
                              Localizer.getLocaleById(LocaleId.set_mark, context),
                              style: Theme.of(context).textTheme.subtitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                            child: StarRating(
                          onRatingChanged: (rating) async {
                            fastPrefs.prefs.setInt(FastPreferences.userAppRating, rating?.toInt());
                            if (rating > 3 && shouldShowDialog) {
                              if (rating == 5) {
                                liked = true;
                                fastPrefs.prefs.setBool(FastPreferences.userLikedApp, liked);
                                setState(() {});
                              }
                              _showWantToValueDialog();
                            }
                          },
                          initRating: initRating,
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width * 0.4,
                        )),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR + 40.0,
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
            bottom: Utils().PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR + 10.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: RoundCustomButton(
                  parentSize: MediaQuery.of(context).size,
                  onPressed: () async {
                    widget.showProcessCallback();
                  },
                  child: Text(
                    Localizer.getLocaleById(LocaleId.continue_btn_txt, context),
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWantToValueDialog() {
    showDialog(
      context: context,
      builder: (context) => EyeHelperAlertDialog(
        subtitle:
            'Вы можете оценить наше приложение в ${Platform.isAndroid ? 'Google Play' : 'App Store'}, это поможет нам развиваться и становиться лучше',
        mainBtnTitle: Localizer.getLocaleById(LocaleId.value, context),
        mainBtnCallback: () async {
          fastPrefs.prefs.setInt(
            FastPreferences.userRatedTheAppTime,
            DateTime.now().millisecondsSinceEpoch,
          );
          await AppReview.requestReview;
          Navigator.of(context).pop();
        },
        secondaryBtnTitle: "Закрыть",
        secondaryBtnCallback: () {
          Navigator.of(context).pop();
        },
        title: Localizer.getLocaleById(LocaleId.want_to_set_mark, context),
      ),
    );
  }
}
