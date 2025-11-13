import 'package:flutter/material.dart';
import 'package:nahj_asma_app/core/widgets/background_wrapper.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';
import 'package:nahj_asma_app/widgets/home_drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BackgroundWrapper(
      themeProvider: themeProvider,
      child: Scaffold(
        backgroundColor: Colors.transparent, // يجعل الـ AppB
        endDrawer: HomeDrawerWidget(themeProvider: themeProvider),
        extendBodyBehindAppBar:
            true, // هذا السطر يجعل الجسم يمتد خلف الـ AppBar
        appBar: AppBar(
          backgroundColor: Colors.transparent, // يجعل الـ AppBar شفاف
          elevation: 0, // إزالة الظل
          title: const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'النهج الأسمى',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
                //    fontSize: 24,
              ),
            ),
          ),
        ),
        body:
            // المحتوى
            Center(
              child: Text(
                "مرحباً بك 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
