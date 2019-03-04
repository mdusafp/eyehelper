import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperMain extends StatefulWidget {

  @override
  _SwiperMainState createState() => new _SwiperMainState();

}

class _SwiperMainState extends State<SwiperMain> {


  Map<int, SwiperScreenInfo> flareActorByIndex = {
    0: SwiperScreenInfo(
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastTopBot',
      fakeImgName: 'assets/firstImageFace1.png',
      title: '1. Вертикальные\n движения',
      mainText: 'Поводите глазами снизу вверх и наоборот. ',
      durationText: 'Повторить: 3 раза.'
    ),
    1: SwiperScreenInfo(
      flareName: 'assets/lrtbFaceFast.flr',
      animationName: 'fastLeftRight',
      fakeImgName: 'assets/firstImageFace1.png',
      title: '2. Горизонтальные\n движения',
      mainText: 'Поводите глазами слев направо и наоборот. ',
      durationText: 'Повторить: 3 раза.'
    ),
    2: SwiperScreenInfo(
        flareName: 'assets/screwUpFast.flr',
        animationName: 'screwUp',
        fakeImgName: 'assets/firstImageFace3.png',
        title: '3. Жмурки',
        mainText: 'Крепко зажмрурьте глаза\n на 10 секунд, не открывая\n глаза расслабьте мышцы\nна 10 секунд',
        durationText: 'Повторить: 3 раза.'
    ),
    3: SwiperScreenInfo(
        flareName: 'assets/blinkingFast.flr',
        animationName: 'blinkingFast',
        fakeImgName: 'assets/firstImageFace4.png',
        title: '4. Моргание',
        mainText: 'Быстро поморгайте 20-25 раз',
        durationText: 'Повторить: 1 раз.'
    ),
    4: SwiperScreenInfo(
        flareName: 'assets/farSeingFast.flr',
        animationName: 'farSeeing',
        fakeImgName: 'assets/firstImageFace5.png',
        title: '5. Фокусировка',
        mainText: 'Сфокусируйтесь сначала на\nближнем предмете (10 сек),\nпотом на дальнем (10 сек).',
        durationText: 'Повторить: 3 раза.'
    ),
    5: SwiperScreenInfo(
        flareName: 'assets/palmingFast.flr',
        animationName: 'palming',
        fakeImgName: 'assets/firstImageFace6.png',
        title: '6. Пальминг',
        mainText: 'Потрите руки друг о друга до\nпоявления тепла. Приложите руки\nк глазам на 15 секунд (не давить).\mПодумайте о своей мечте.',
        durationText: 'Повторить: 3 раза.'
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
                activeColor: Colors.red
            )
        ),
        itemBuilder: (BuildContext context, int index) {
          SwiperScreenInfo info = flareActorByIndex[index];

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  height: 30.0,
                ),

                Text(info.title),
                Text(info.mainText),
                Text(info.durationText),


                SizedBox(
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
                ),

                Padding(
                  padding: EdgeInsets.only(left: 90.0, right: 90.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: RoundCustomButton(
                      onPressed: (){},
                      child: Text('НАЧАТЬ'),
                    ),
                  ),
                )

              ],
            ),
          );
        },
      itemCount: 6,
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


class SwiperScreenInfo{

  String flareName;
  String animationName;
  String fakeImgName;
  String title;
  String mainText;
  String durationText;

  SwiperScreenInfo({
    @required this.flareName,
    @required this.animationName,
    @required this.fakeImgName,
    @required this.title,
    @required this.mainText,
    @required this.durationText
  });

}