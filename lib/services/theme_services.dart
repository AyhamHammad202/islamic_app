import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _storage = GetStorage();
  final String _key = 'isDarkMode';

  _saveThemToStorage(bool isDarkMode) => _storage.write(_key, isDarkMode);

  bool loadThemFromStorage() => _storage.read(_key) ?? false;

  ThemeMode get theme =>
      loadThemFromStorage() ? ThemeMode.dark : ThemeMode.light;

  void switchThemeMode() {
    Get.changeThemeMode(
        loadThemFromStorage() ? ThemeMode.light : ThemeMode.dark);
    _saveThemToStorage(!loadThemFromStorage());
  }
}
