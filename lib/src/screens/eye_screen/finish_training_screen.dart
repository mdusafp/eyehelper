import 'package:eyehelper/app_id.dart';
import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:eyehelper/src/screens/eye_screen/rating_stars.dart';
 
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
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          height: 110.0,
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 6.0, left: 20.0, right: 20.0),
                          child: Center(
                              child: Text(
                                  Localizer.getLocaleById(LocaleId.good_job, context),
                                  style: StandardStyleTexts.eyeScreenHeader,
                                  textAlign: TextAlign.center)
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 20.0, right: 20.0),
                          child: Center(
                            child: Text(
                                Localizer.getLocaleById(LocaleId.you_done_excercises, context),
                                style: StandardStyleTexts.eyeScreenMainText,
                                textAlign: TextAlign.center),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 6.0, bottom: 10.0),
                          child: SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: Image.asset('assets/finish_face.png'),
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 15.0, left: 50.0, right: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkResponse(
                                radius: 25.0,
                                highlightColor: Colors.transparent,
                                onTap: (){
                                  setState(() {
                                    liked = !liked;
                                  });
                                  if (liked){
                                    _showWantToValueDialog();
                                  }
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Center(
                                    child: Icon(
                                      liked 
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                      size: 30.0,
                                      color: liked 
                                        ? Colors.red
                                        : StandardStyleColors.mainDark,
                                    ),
                                  ),
                                )
                              ),
                              InkResponse(
                                highlightColor: Colors.transparent,
                                radius: 25.0,
                                onTap: (){
                                  Share.share(Localizer.getLocaleById(LocaleId.there_is_app, context));
                                },
                                child: Container(
                                  width: 100.0,
                                  child: Center(
                                    child: Icon(
                                      Icons.share,
                                      color: StandardStyleColors.mainDark,
                                      size: 30.0,
                                    ),
                                  ),
                                )
                              )
                            ],
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                          child: Center(
                              child: Text(
                                  Localizer.getLocaleById(LocaleId.set_mark, context),
                                  style: StandardStyleTexts.eyeScreenMainText,
                                  textAlign: TextAlign.center)
                          ),
                        ),
                        
                        Container(
                          child: StarRating(
                            onRatingChanged: (rating) async {
                              if (rating > 3){
                                _showWantToValueDialog();
                              }
                            },
                            initRating: 0,
                            width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.4,
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 160.0,
                          ),
                        )

                      ],
                    ),
                  ),
                ]),
              ),
          ),
          Positioned(
            bottom: 130.0,
            child: Container(
                padding: EdgeInsets.only(left: 70, right: 70),
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: RoundCustomButton(
                  onPressed: () async {
                    widget.showProcessCallback();
                  },
                  child: Text(Localizer.getLocaleById(LocaleId.continue_btn_txt, context), style: StandardStyleTexts.mainBtnText),
                )
              )
            )
          ],
      ),
    );
  
  }

  void _showWantToValueDialog() {
    showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          actions: <Widget>[
            
            MaterialButton(
              child: Text(
                Localizer.getLocaleById(LocaleId.not_now, context)),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text(
                Localizer.getLocaleById(LocaleId.value, context)),
              onPressed: () async {
                if (await canLaunch(getAppUrl()))
                  launch(getAppUrl());
              },
            ),
          ],
          title: Text(
            Localizer.getLocaleById(LocaleId.want_to_set_mark, context)
          ),
        )
    );
  }
}