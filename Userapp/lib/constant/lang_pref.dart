import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelperUtils {
  static const String languageCode = "language_code";
  static SharedPreferences _preferences = _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future<bool> setStringList(String key, List<String> value) async => await _preferences.setStringList(key, value);

  static List<String> getStringList(String key) => _preferences.getStringList(key) ?? [];

  static Future setString(String key, String value) async => await _preferences.setString(key, value);

  static String? getString(String key) => _preferences.getString(key) ?? "N/A";

  static Future setBoolean(String key, bool value) async => await _preferences.setBool(key, value);

  static bool getBoolean(String key) => _preferences.getBool(key) ?? false;

  static int getInt(dynamic key) {
    return _preferences.getInt("$key") ?? 0;
  }

  static double getDouble(String key) => _preferences.getDouble(key) ?? 0.0;

  static Future<bool> setBool(String key, bool value) async => await _preferences.setBool(key, value);

  static Future setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  static Future setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  static void clearPref() {
    _preferences.clear();
  }

  static Future<bool>? remove(String key) {
    // ignore: unrelated_type_equality_checks
    if (_preferences == false) return null;
    return _preferences.remove(key);
  }
}
