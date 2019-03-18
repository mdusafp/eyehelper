import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperMain extends StatefulWidget {

  @override
  _SwiperMainState createState() => new _SwiperMainState();

}

class _SwiperMainState extends State<SwiperMain> {





  int swiperIndex = 0;

  SwiperController swiperController = SwiperController();


  @override
  Widget build(BuildContext context) {

    Widget swiper = new Swiper(
        onIndexChanged: (index) {
          setState(() => swiperIndex = index);
        },
        controller: swiperController,
        loop:false,
        pagination: new SwiperPagination(
            margin: EdgeInsets.only(bottom: wv(80.0)),
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                space: hv(10.0),
                size: wv(6.0),
                activeSize: wv(8.0),
                activeColor: StandardStyleColors.activeColor
            )
        ),
        itemBuilder: (BuildContext context, int index) {
          SwiperScreenInfo info = SwiperScreenInfo.flareActorByIndex[index];


          return Stack(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: hv(10.0), right: hv(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              height: wv(110.0),
                            ),

                            Padding(
                             padding: EdgeInsets.only(top: wv(18.0), bottom: wv(6.0), left: hv(20.0), right: hv(20.0)),
                              child: Center(
                                child: Text(
                                    Localizer.getLocaleById(info.title, context),
                                    style: StandardStyleTexts.eyeScreenHeader,
                                    textAlign: TextAlign.center)
                                ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: wv(6.0), bottom: wv(6.0), left: hv(20.0), right: hv(20.0)),
                              child: Center(
                                  child: Text(
                                      Localizer.getLocaleById(info.mainText, context),
                                      style: StandardStyleTexts.eyeScreenMainText,
                                      textAlign: TextAlign.center),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: wv(6.0), bottom: wv(6.0), left: hv(20.0), right: hv(20.0)),
                              child: Text(Localizer.getLocaleById(info.durationText, context), style: StandardStyleTexts.eyeScreenCountTxt, textAlign: TextAlign.center),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: wv(6.0), bottom: wv(10.0)),
                              child: getFace(info),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: wv(10.0)),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: wv(160.0),
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
                bottom: wv(125.0),
                left: hv(70.0),
                right: hv(70.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: wv(50.0),
                  child: RoundCustomButton(
                    onPressed: (){},
                    child: Text(Localizer.getLocaleById('begin_btn_txt', context), style: StandardStyleTexts.mainBtnText),
                  ),
                ),
              )
            ],
          );
        },
      itemCount: SwiperScreenInfo.flareActorByIndex.length,
    );

    return new Scaffold(
        body: new Container(
            child: Stack(
                children: <Widget>[
                  swiper
                ]
            )
        )
    );
  }

  getFace(SwiperScreenInfo info){
    return SizedBox(
        height: wv(160),
        width: hv(160),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              child: Image.asset(info.fakeImgName, alignment: Alignment.center),
            ),
            FlareActor(
              info.flareName,
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: info.animationName,
            )
          ],
        )
    );
  }

}


