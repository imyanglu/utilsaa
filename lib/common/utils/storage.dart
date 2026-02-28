// lib/common/utils/storage.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _prefs;

  // 初始化（在 main.dart 调用一次）
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  static String? getString(String key) => _prefs?.getString(key);
  static Future<void> setString(String key, String value) async =>
      await _prefs?.setString(key, value);

  // Bool
  static bool? getBool(String key) => _prefs?.getBool(key);
  static Future<void> setBool(String key, bool value) async =>
      await _prefs?.setBool(key, value);

  // Int
  static int? getInt(String key) => _prefs?.getInt(key);
  static Future<void> setInt(String key, int value) async =>
      await _prefs?.setInt(key, value);

  // 存对象（转 JSON 字符串）
  static Map<String, dynamic>? getMap(String key) {
    final str = _prefs?.getString(key);
    if (str == null) return null;
    return jsonDecode(str);
  }

  static Future<void> setMap(String key, Map<String, dynamic> value) async =>
      await _prefs?.setString(key, jsonEncode(value));

  // 删除
  static Future<void> remove(String key) async => await _prefs?.remove(key);

  // 清空
  static Future<void> clear() async => await _prefs?.clear();
}
