import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<void> setItem(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getItem(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}