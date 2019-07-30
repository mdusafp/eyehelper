import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_single_page.dart';
import 'package:eyehelper/src/utils/adaptive_utils.dart';
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
          margin: EdgeInsets.only(bottom: hv(80.0)),
          builder: DotSwiperPaginationBuilder(
              color: Colors.grey,
              space: wv(10.0),
              size: hv(6.0),
              activeSize: hv(8.0),
              activeColor: StandardStyleColors.activeColor

          )
      ),
      itemBuilder: (BuildContext context, int index) {
        SwiperScreenInfo info = SwiperScreenInfo.flareActorByIndex[index];

        return EyeSinglePage(info: info, controller: swiperController, callbackBtnPressed: (){

        });

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


}


