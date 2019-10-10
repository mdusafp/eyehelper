import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class CustomSwiperBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;

  const CustomSwiperBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.size: 10.0,
      this.activeSize: 10.0,
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
        config.layout == SwiperLayout.DEFAULT) {
      return new PageIndicator(
        count: config.itemCount,
        controller: config.pageController,
        layout: PageIndicatorLayout.SLIDE,
        size: size,
        activeColor: activeColor,
        color: color,
        space: space,
      );
    }

    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(Container(
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
        child: ClipOval(
          child: Container(
            color: active ? activeColor : color,
            width: active ? activeSize : size,
            height: active ? activeSize : size,
          ),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return new Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return new Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}







enum PageIndicatorLayout {
  NONE,
  SLIDE,
  WARM,
  COLOR,
  SCALE,
  DROP,
}

class PageIndicator extends StatefulWidget {
  /// size of the dots
  final double size;

  /// space between dots.
  final double space;

  /// count of dots
  final int count;

  /// active color
  final Color activeColor;

  /// normal color
  final Color color;

  /// layout of the dots,default is [PageIndicatorLayout.SLIDE]
  final PageIndicatorLayout layout;

  // Only valid when layout==PageIndicatorLayout.scale
  final double scale;

  // Only valid when layout==PageIndicatorLayout.drop
  final double dropHeight;

  final PageController controller;

  final double activeSize;

  PageIndicator(
      {Key key,
      this.size: 20.0,
      this.space: 5.0,
      this.count,
        this.activeSize : 20.0,
      this.controller,
      this.color: Colors.white30,
      this.layout: PageIndicatorLayout.SLIDE,
      this.activeColor: Colors.white,
      this.scale: 0.6,
      this.dropHeight: 20.0})
      : assert(count != null),
        assert(controller!=null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _PageIndicatorState();
  }
}

class _PageIndicatorState extends State<PageIndicator> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = new SizedBox(
      width: (widget.count * widget.size + (widget.count - 1) * widget.space) * 2,
      height: widget.size * 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < widget.count; i++)
            Expanded(
              child: Center(
                child: Icon(
                  widget.controller.page >= i - 0.5 && widget.controller.page <= i + 0.5 
                  ? TodayTrainingCounters().getPassed(i) 
                      ? Icons.check_circle
                      : Icons.lens
                  : TodayTrainingCounters().getPassed(i) 
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  color: StandardStyleColors.activeColor,
                  size: 23
                ),
              ),
            )
        ],
      )
    );

    return new IgnorePointer(
      child: child,
    );
  }

  void _onController() {
    double page = widget.controller.page ?? 0.0;
    index = page.floor();

    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_onController);
    super.initState();
  }

  @override
  void didUpdateWidget(PageIndicator oldWidget) {
    if(widget.controller != oldWidget.controller){
      oldWidget.controller.removeListener(_onController);
      widget.controller.addListener(_onController);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onController);
    super.dispose();
  }
}
