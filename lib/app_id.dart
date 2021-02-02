import 'dart:io';

const String iosAppId = '000000000';
const String androidAppId = 'com.fluttergods.eyehelper';

getAppUrl() {
  if (Platform.isAndroid)
    return 'https://play.google.com/store/apps/details?id=$androidAppId';
  else
    return 'itms-apps://itunes.apple.com/app/id$iosAppId';
}
