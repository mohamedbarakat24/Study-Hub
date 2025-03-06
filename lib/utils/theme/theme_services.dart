import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

  void _saveThemeToBox(bool isDarkMode) {
    _box.write(_key, isDarkMode);
  }

  bool _loadThemeFromeBox() {
    return _box.read<bool>(_key) ?? false;
  }

  ThemeMode get theme {
    return _loadThemeFromeBox() ? ThemeMode.dark : ThemeMode.light;
  }

  void switchMode() async {
    Get.changeThemeMode(
        _loadThemeFromeBox() ? ThemeMode.light : ThemeMode.dark);
    //await Future.delayed(const Duration(milliseconds: 1000));

    _saveThemeToBox(!_loadThemeFromeBox());
  }
}
