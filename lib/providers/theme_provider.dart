

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const THEME_STATUS = 'THEME_STATUS';
  bool _isDarkTheme = false;
  bool get getIsDarkTheme => _isDarkTheme;
  ThemeProvider() {
    getTheme();
  }
  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(THEME_STATUS, themeValue);
    _isDarkTheme = themeValue;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isDarkTheme = pref.getBool(THEME_STATUS) ?? false;
    notifyListeners();
    return _isDarkTheme;
  }
}
