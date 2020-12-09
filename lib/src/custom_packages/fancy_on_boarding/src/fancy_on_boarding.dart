library fancy_on_boarding;

import 'dart:async';
import 'dart:ui' as ui;

import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/fancy_page.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_dragger.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_reveal.dart';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/pager_indicator.dart';
import 'package:flutter/material.dart';

class FancyOnBoarding extends StatefulWidget {
  final List<PageModel> pageList;
  final VoidCallback onDoneButtonPressed;
  final VoidCallback onSkipButtonPressed;
  final VoidCallback onNextButtonPressed;
  final VoidCallback onBackButtonPressed;
  final Function(int) pageIndexChanged;

  final ShapeBorder doneButtonShape;
  final TextStyle doneButtonTextStyle;
  final Color doneButtonBackgroundColor;
  final TextStyle skipButtonTextStyle;
  final Color skipButtonColor;
  final bool showSkipButton;

  FancyOnBoarding({
    Key key,
    @required this.pageList,
    this.onDoneButtonPressed,
    this.onNextButtonPressed,
    this.onSkipButtonPressed,
    this.onBackButtonPressed,
    this.pageIndexChanged,
    this.doneButtonShape,
    this.doneButtonTextStyle,
    this.doneButtonBackgroundColor,
    this.skipButtonTextStyle,
    this.skipButtonColor,
    this.showSkipButton = true,
  })  : assert(pageList.length != 0),
        super(key: key);

  @override
  FancyOnBoardingState createState() => FancyOnBoardingState();
}

class FancyOnBoardingState extends State<FancyOnBoarding> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  List<PageModel> pageList;
  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  bool animating = false;

  bool get isRTL => ui.window.locale.languageCode.toLowerCase() == "ar";

  @override
  void initState() {
    super.initState();
    this.pageList = widget.pageList;
    this.slideUpdateStream = StreamController<SlideUpdate>();
    _listenSlideUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FancyPage(
          model: pageList[activeIndex],
          percentVisible: 1.0,
        ),
        PageReveal(
          revealPercent: slidePercent,
          child: FancyPage(
            model: pageList[nextPageIndex],
            percentVisible: slidePercent,
          ),
        ),
        Positioned(
          bottom: 8.0,
          child: PagerIndicator(
            isRtl: isRTL,
            viewModel: PagerIndicatorViewModel(
              pageList,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
        ),
        PageDragger(
          pageLength: pageList.length - 1,
          currentIndex: activeIndex,
          canDragLeftToRight: activeIndex > 0,
          canDragRightToLeft: activeIndex < pageList.length - 1,
          slideUpdateStream: this.slideUpdateStream,
        ),
        Positioned(
          bottom: 24,
          right: 20,
          child: InkResponse(
            child: Icon(pageList.length - 1 < activeIndex + 1 ? Icons.done : Icons.navigate_next,
                size: 32, color: Theme.of(context).accentColor),
            onTap: widget.onDoneButtonPressed != null && widget.onNextButtonPressed != null
                ? pageList.length - 1 < activeIndex + 1
                    ? widget.onDoneButtonPressed
                    : widget.onNextButtonPressed
                : next,
          ),
        ),
        Positioned(
          top: 28,
          left: 12,
          child: IgnorePointer(
            ignoring: _getOpacity() < 1.0,
            child: Opacity(
              opacity: _getOpacity(),
              child: InkResponse(
                child: Icon(Icons.navigate_before, size: 32, color: Theme.of(context).accentColor),
                onTap: widget.onBackButtonPressed ?? back,
              ),
            ),
          ),
        ),
        widget.showSkipButton
            ? Positioned(
                top: 28,
                right: 16,
                child: InkResponse(
                  child: Icon(Icons.close, size: 32, color: Theme.of(context).accentColor),
                  onTap: widget.onSkipButtonPressed ?? () => Navigator.of(context).pop(),
                ),
              )
            : Offstage()
      ],
    );
  }

  back() async {
    if (animating) {
      return;
    }
    if (activeIndex == 0) {
      return;
    }
    slideDirection = SlideDirection.leftToRight;
    nextPageIndex = activeIndex - 1;
    animatedPageDragger = AnimatedPageDragger(
      slideDirection: slideDirection,
      transitionGoal: TransitionGoal.open,
      slidePercent: slidePercent,
      slideUpdateStream: slideUpdateStream,
      vsync: this,
    );
    animating = true;
    await animatedPageDragger.run();
    animating = false;
    setState(() {
      activeIndex = nextPageIndex;
      if (widget.pageIndexChanged != null) {
        widget.pageIndexChanged(activeIndex);
      }
    });
  }

  next() async {
    if (animating) {
      return;
    }
    if (pageList.length - 1 < activeIndex + 1) {
      if (widget.onDoneButtonPressed != null) {
        widget.onDoneButtonPressed();
      } else {
        Navigator.of(context).pop();
      }
      return;
    }
    slideDirection = SlideDirection.rightToLeft;
    nextPageIndex = activeIndex + 1;
    animatedPageDragger = AnimatedPageDragger(
      slideDirection: slideDirection,
      transitionGoal: TransitionGoal.open,
      slidePercent: slidePercent,
      slideUpdateStream: slideUpdateStream,
      vsync: this,
    );
    animating = true;
    await animatedPageDragger.run();
    animating = false;
    setState(() {
      activeIndex = nextPageIndex;
      if (widget.pageIndexChanged != null) {
        widget.pageIndexChanged(activeIndex);
      }
    });
  }

  _listenSlideUpdate() {
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
        if (widget.pageIndexChanged != null) {
          widget.pageIndexChanged(activeIndex);
        }
      });
    });
  }

  double _getOpacity() {
    if (activeIndex - 1 == 0 && slideDirection == SlideDirection.leftToRight)
      return 1 - slidePercent;
    if (activeIndex == 0 && slideDirection == SlideDirection.rightToLeft) return slidePercent;
    if (activeIndex == 0) return 0.0;
    return 1.0;
  }

  @override
  void dispose() {
    slideUpdateStream?.close();
    super.dispose();
  }
}
