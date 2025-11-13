import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // هذا السطر يجعل الجسم يمتد خلف الـ AppBar
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
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // الخلفية
          Positioned.fill(
            child: Image.asset(
              "assets/images/bachground_lightmode.jpg",
              fit: BoxFit.cover,
            ),
          ),

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
        ],
      ),
    );
  }
}
