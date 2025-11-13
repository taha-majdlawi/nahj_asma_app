import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 13, 6, 37)
          : const Color.fromARGB(255, 255, 255, 255),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
    );
  }
}
