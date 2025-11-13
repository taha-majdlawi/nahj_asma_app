import 'package:flutter/material.dart';
import 'package:shared_pref\erences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  static const FONT_SIZE_KEY = 'FONT_SIZE';
  double _fontSize = 16.0; // الحجم الافتراضي

  double get fontSize => _fontSize;

  FontSizeProvider() {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble(FONT_SIZE_KEY) ?? 16.0;
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = size;
    await prefs.setDouble(FONT_SIZE_KEY, size);
    notifyListeners();
  }
}
