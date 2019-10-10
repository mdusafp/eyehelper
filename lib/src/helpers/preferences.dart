import 'package:shared_preferences/shared_preferences.dart';

class FastPreferences {
  SharedPreferences prefs;

  Future<void> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static final FastPreferences _singleton = FastPreferences._internal();

  factory FastPreferences() {
    return _singleton;
  }

  FastPreferences._internal();
}