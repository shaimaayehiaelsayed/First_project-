import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/ui/theme.dart';
import 'package:get/get.dart';

class ThemeServices {
  final GetStorage _box=GetStorage();
  final _key= 'isDarkMode';
  _saveThemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);
  // ignore: non_constant_identifier_names
  bool _LoadThemeFromBox()=>_box.read(_key)??false;
  ThemeMode get theme=>_LoadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  void switchTheme()
  {
    Get.changeThemeMode(_LoadThemeFromBox()?ThemeMode.dark:ThemeMode.light);
    _saveThemeToBox(!_LoadThemeFromBox());
  }
}
