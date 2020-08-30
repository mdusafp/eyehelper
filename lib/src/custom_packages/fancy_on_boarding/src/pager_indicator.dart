import 'dart:ui';
import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:flutter/material.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;
  final bool isRtl;

  PagerIndicator({
    this.viewModel,
    this.isRtl,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: bubbles,
        ),
      ),
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      height: 65.0,
      child: Center(
        child: Container(
          width: lerpDouble(16.0, 24.0, viewModel.activePercent),
          height: lerpDouble(16.0, 24.0, viewModel.activePercent),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow
                ? Theme.of(context).accentColor
                    .withAlpha((0x88 * viewModel.activePercent).round())
                : Theme.of(context).accentColor,
            border: Border.all(
              color: viewModel.isHollow
                  ? Theme.of(context).accentColor.withAlpha(
                      (0x88 * (1.0 - viewModel.activePercent)).round())
                  : Theme.of(context).accentColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class PageBubbleViewModel {
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
    this.color,
    this.isHollow,
    this.activePercent,
  );
}

Widget _renderImageAsset(String assetPath,
    {double width = 24, double height = 24, Color color = Colors.white}) {
  return Image.asset(
      assetPath,
      color: color,
      width: width,
      height: height,
    );
}
