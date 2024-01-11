import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<void> saveStringValue(String key ,String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getStringValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}