import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  PrefHelper._();

  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static Future<void> save(String key, dynamic value) async {
    final prefs = await _prefs;

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  static Future<dynamic> get(String key) async {
    final prefs = await _prefs;
    return prefs.get(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
