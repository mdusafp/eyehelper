import 'package:flutter_screenutil/flutter_screenutil.dart';

ScreenUtil adaptiveUtils = ScreenUtil(width: 360, height: 640);

double wv(dynamic val){
  int res = _prepare(val);
  return ScreenUtil.getInstance().setHeight(res);
}

double hv(dynamic val){
  int res = _prepare(val);
  return ScreenUtil.getInstance().setWidth(res);
}

double sp (dynamic val){
  int res = _prepare(val);
  return ScreenUtil.getInstance().setSp(res);
}


_prepare(dynamic val){
  if (val == null){
    throw Exception("Wrong argument");
  }

  int res;

  if (val is double){
    res = val.toInt();
  }

  if (val is int){
    res = val;
  }

  if (res == null){
    throw Exception("Wrong argument");
  }

  return res;
}

