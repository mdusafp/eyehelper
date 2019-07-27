import 'package:flutter/material.dart';
import 'en.dart';
import 'ru.dart';

class Localizer {
  static var defaultLang = 'en';

  static var supportedLangs = [
    Locale('en', 'EN'),
    Locale('ru', 'RU'),
  ];

  static var langsSupportedBySite = ['ru', 'en'];

  static Map<String, Map> _locales = {
    'en': locale_en,
    'ru': locale_ru,
  };

  static String getLocaleById(String id, BuildContext context) {
    String res = id;
    String locale = 'ru';
    // String locale = Localizations.localeOf(context).languageCode;

    if (locale == null || !langsSupportedBySite.contains(locale)) {
      locale = defaultLang;
    }

    Map translation = _locales[locale];

    try {
      res = translation[id];
    } catch (e) {
      print(e);
    }

    return res;
  }
}
