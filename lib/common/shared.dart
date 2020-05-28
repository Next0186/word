import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<void> setString(String key, Map value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }
  static Future<void> setList(String key, Map value) async {
    return await setMap(key, value);
  }
  static Future<void> setMap(String key, Map value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  //*******************************// 
  static Future<Map> getMap(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    if (value == null) return null;
    return json.decode(value);
  }

  static Future<List<dynamic>> getList(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    if (value == null) return null;
    return json.decode(value);
  }

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
