import 'package:eyehelper/src/locale/ru.dart';
import 'package:flutter/material.dart';

class WorkingHours {
  bool isActivated;
  LocaleId name;
  RangeValues values;

  WorkingHours({this.name, this.values, this.isActivated});

  WorkingHours.fromMap(Map<String, dynamic> map) {
    isActivated = map['isActivated'];
    name = map['name'];
    final range = map['values']?.split(':');
    values = RangeValues(double.parse(range[0]), double.parse(range[1]));
  }

  Map toMap() {
    return {
      'isActivated': isActivated,
      'name': name,
      // FIXME: if someone have better solution you're welcome
      'values': '${values.start}:${values.end}',
    };
  }
}
