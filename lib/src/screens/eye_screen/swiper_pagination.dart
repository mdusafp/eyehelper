import 'package:eyehelper/src/screens/eye_screen/today_training.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

/// Dots under the exercise cards: the current one stretches into a pill,
/// exercises already done today take the deeper green.
class CustomSwiperBuilder extends SwiperPlugin {
  final Color activeColor;
  final Color doneColor;
  final Color color;
  final double size;
  final double activeWidth;
  final double space;

  const CustomSwiperBuilder({
    required this.activeColor,
    required this.doneColor,
    required this.color,
    this.size = 6.0,
    this.activeWidth = 16.0,
    this.space = 5.0,
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    final counters = TodayTrainingCounters();
    return IgnorePointer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < config.itemCount; i++)
            AnimatedContainer(
              key: Key('pagination_$i'),
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              margin: EdgeInsets.symmetric(horizontal: space),
              width: i == config.activeIndex ? activeWidth : size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size / 2),
                color: i == config.activeIndex
                    ? activeColor
                    : counters.getPassed(i)
                        ? doneColor
                        : color,
              ),
            ),
        ],
      ),
    );
  }
}
