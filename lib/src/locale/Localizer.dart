import 'package:flutter/material.dart';
import 'ru.dart';

class Localizer {
  static var defaultLang = 'ru';

  static var supportedLangs = [
    //Locale('en', 'EN'),
    Locale('ru', 'RU'),
  ];

  static Map<String, Map<LocaleId, String>> _locales = {
    //'en' : locale_en,
    'ru': localeRu,
  };

  static String getLocaleById(LocaleId id, BuildContext context) {
    String res = id.toString();
    String locale = Localizations.localeOf(context).languageCode;

    if (locale == null) {
      locale = defaultLang;
    }

    Map? translation = _locales[locale];

    try {
      res = translation![id];
    } catch (e) {
      print(e);
    }

    return res;
  }
}
