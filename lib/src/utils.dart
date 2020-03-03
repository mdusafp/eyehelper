import 'dart:math';
import 'dart:ui';

import 'package:eyehelper/src/constants.dart';

class Utils {
  double PREFERED_HEIGHT_FOR_CUSTOM_APPBAR = 110.0;
  double PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR = 90.0;
  double PREFERED_EYE_SIZE = 60;
  bool IS_SMALL_DEVICE = false;
  bool ADAPTED = false;

  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  void init(Window window) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640)..init(window);

    IS_SMALL_DEVICE =
        Utils.calculateDiagonal(window.physicalSize.width, window.physicalSize.height) < SMALL_DEVICE_LIMIT;

    if (IS_SMALL_DEVICE && !ADAPTED) {
      PREFERED_HEIGHT_FOR_CUSTOM_APPBAR *= 3 / 4;
      PREFERED_HEIGHT_FOR_CUSTOM_BOTTOM_BAR *= 3 / 4;
      PREFERED_EYE_SIZE *= 5 / 6;
    }

    ADAPTED = true;
  }

  static calculateDiagonal(double width, double height) {
    return sqrt(width * width + height * height);
  }
}

class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  double width;
  double height;

  bool allowFontScaling;

  static double _screenWidth;

  ScreenUtil({this.width = 1080, this.height = 1920});

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(Window window) {
    _screenWidth = window.physicalSize.width;
  }

  get scaleWidth => _screenWidth / instance.width;

  setSp(num fontSize) => fontSize * scaleWidth * (Utils().IS_SMALL_DEVICE ? 1.1 : 0.8);
}
