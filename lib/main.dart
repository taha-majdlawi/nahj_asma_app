import 'package:flutter/material.dart';
import 'package:nahj_asma_app/core/constants/them.dart';
import 'package:nahj_asma_app/providers/font_size_provider.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';
import 'package:nahj_asma_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
      ],
      child: Consumer2<ThemeProvider, FontSizeProvider>(
        builder: (context, themeProvider, fontSizeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme,
                  context: context,
                ).copyWith(
                  textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: fontSizeProvider.fontSize / 16.0,
                  ),
                ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
