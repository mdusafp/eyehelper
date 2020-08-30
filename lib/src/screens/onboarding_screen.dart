import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/fancy_on_boarding.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  GlobalKey<FancyOnBoardingState> key = GlobalKey<FancyOnBoardingState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FancyOnBoarding(
            key: key,
            pageList: [
              PageModel(
                color: Colors.white,
                heroAssetPath: 'assets/work_onb.png',
                title: Text(Localizer.getLocaleById(LocaleId.onb_title1, context),
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                body: Text(Localizer.getLocaleById(LocaleId.onb_subtitle1, context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ),
              PageModel(
                  color: Colors.white,
                  heroAssetPath: 'assets/exercises_onb.png',
                  title: Text(Localizer.getLocaleById(LocaleId.onb_title2, context),
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: Theme.of(context).accentColor,
                    )
                  ),
                  body: Text(
                      Localizer.getLocaleById(LocaleId.onb_subtitle2, context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body1.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                  )
              ),
              PageModel(
                color: Colors.white,
                heroAssetPath: 'assets/notif_onb.png',
                title: Text(Localizer.getLocaleById(LocaleId.onb_title3, context),
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                body: Text(Localizer.getLocaleById(LocaleId.onb_subtitle3, context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Theme.of(context).primaryColor,
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}