import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperMain extends StatefulWidget {

  @override
  _SwiperMainState createState() => new _SwiperMainState();

}

class _SwiperMainState extends State<SwiperMain> {


  static const Map<int, SwiperScreenInfo> flareActorByIndex = {
    0: SwiperScreenInfo(
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastTopBot',
      fakeImgName: 'assets/firstImageFace1.png',
      title: 'vertical_movements',
      mainText: 'turn_eyes_up_down',
      durationText: 'retry_three_times'
    ),
    1: SwiperScreenInfo(
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastLeftRight',
      fakeImgName: 'assets/firstImageFace1.png',
      title: 'horizontal_movements',
      mainText: 'turn_eyes_left_right',
      durationText: 'retry_three_times'
    ),
    2: SwiperScreenInfo(
        flareName: 'assets/screwUpFast.flr',
        animationName: 'screwUp',
        fakeImgName: 'assets/firstImageFace3.png',
        title: 'screw_up_movements',
        mainText: 'screw_up_your_eyes',
        durationText: 'retry_three_times'
    ),
    3: SwiperScreenInfo(
        flareName: 'assets/blinkingFast.flr',
        animationName: 'blinkingFast',
        fakeImgName: 'assets/firstImageFace4.png',
        title: 'blinking_movements',
        mainText: 'blink_fast_20_times',
        durationText: 'retry_one_time'
    ),
    4: SwiperScreenInfo(
        flareName: 'assets/farSeingFast.flr',
        animationName: 'farSeeing',
        fakeImgName: 'assets/firstImageFace5.png',
        title: 'focus_movements',
        mainText: 'focus_for_10_sec',
        durationText: 'retry_three_times'
    ),
    5: SwiperScreenInfo(
        flareName: 'assets/palmingFast.flr',
        animationName: 'palming',
        fakeImgName: 'assets/firstImageFace6.png',
        title: 'palming_movements',
        mainText: 'rub_hands_and_attach_to_eyes',
        durationText: 'retry_three_times'
    ),
  };



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
            margin: EdgeInsets.only(bottom: 10.0),
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                space: 10.0,
                size: 8.0,
                activeSize: 8.0,
                activeColor: StandardStyleColors.activeColor
            )
        ),
        itemBuilder: (BuildContext context, int index) {
          SwiperScreenInfo info = flareActorByIndex[index];

          return Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Container(
                        height: 30.0,
                      ),

                      Text(Localizer.getLocaleById(info.title, context), style: StandardStyleTexts.eyeScreenHeader, textAlign: TextAlign.center),
                      Text(Localizer.getLocaleById(info.mainText, context), style: StandardStyleTexts.eyeScreenMainText, textAlign: TextAlign.center),
                      Text(Localizer.getLocaleById(info.durationText, context), style: StandardStyleTexts.eyeScreenCountTxt, textAlign: TextAlign.center),

                      getFace(info),

                      Padding(
                        padding: EdgeInsets.only(left: 90.0, right: 90.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          child: RoundCustomButton(
                            onPressed: (){},
                            child: Text(Localizer.getLocaleById('begin_btn_txt', context), style: StandardStyleTexts.mainBtnText),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          );
        },
      itemCount: flareActorByIndex.length,
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
        height: 180,
        width: 180,
        child: Stack(
          children: <Widget>[
            Image.asset(info.fakeImgName),
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


class SwiperScreenInfo{

  final String flareName;
  final String animationName;
  final String fakeImgName;
  final String title;
  final String mainText;
  final String durationText;

  const SwiperScreenInfo({
    @required this.flareName,
    @required this.animationName,
    @required this.fakeImgName,
    @required this.title,
    @required this.mainText,
    @required this.durationText
  });

}