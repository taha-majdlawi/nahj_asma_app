import 'package:flutter/material.dart';
import 'package:nahj_asma_app/core/widgets/background_wrapper.dart';
import 'package:nahj_asma_app/providers/font_size_provider.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';

import 'package:provider/provider.dart';

class FontSizeScreen extends StatelessWidget {
  const FontSizeScreen({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return BackgroundWrapper(
      themeProvider: themeProvider,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "تغيير حجم الخط",
            style: TextStyle(
              fontSize: fontSizeProvider.fontSize,
              fontFamily: 'Amiri',
              color: themeProvider.getIsDarkTheme
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "هذا نص تجريبي",

                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize,
                  fontFamily: 'Amiri',
                  color: themeProvider.getIsDarkTheme
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                min: 12,
                max: 32,
                divisions: 20,
                value: fontSizeProvider.fontSize,
                label: fontSizeProvider.fontSize.toStringAsFixed(0),
                onChanged: (value) {
                  fontSizeProvider.setFontSize(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
