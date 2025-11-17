import 'package:flutter/material.dart';
import 'package:nahj_asma_app/core/widgets/background_wrapper.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';
import 'package:nahj_asma_app/screens/show_explination_videos.dart';
import 'package:nahj_asma_app/screens/show_pdf_screen.dart';
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
        backgroundColor: Colors.transparent,
        endDrawer: HomeDrawerWidget(themeProvider: themeProvider),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                //   textDirection: TextDirection.rtl,
                'أهلا وسهلا بك في تطبيق النهج الأسمى في شرح أسماء الله الحسنى للشيخ محمد الحمود النجدي',
                style: TextStyle(
                  color: themeProvider.getIsDarkTheme
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.bold,
                  //    fontSize: 24,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                //   textDirection: TextDirection.rtl,
                'الكتاب يحتوى على ثلاث مجلدات يمكنك اختيار المجلد الذي ترغب بقراته :',
                style: TextStyle(
                  color: themeProvider.getIsDarkTheme
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.bold,
                  //    fontSize: 24,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Spacer(flex: 1),
            ReadButton(
              onPressed: () {
                // عند الضغط، انتقل إلى شاشة عرض PDF
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowPdfScreen(
                      pdfFileId: '`المجلد الاول`',
                      pdfAssetPath: 'assets/pdfs_files/folder1.pdf',
                    ),
                  ),
                );
              },
              text: ' المجلد الأول من كتاب النهج الأسمى',
            ),
            ReadButton(
              onPressed: () {
                // عند الضغط، انتقل إلى شاشة عرض PDF
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowPdfScreen(
                      pdfFileId: '`المجلد الثاني`',
                      pdfAssetPath: 'assets/pdfs_files/folder2.pdf',
                    ),
                  ),
                );
              },
              text: ' المجلد الثاني من كتاب النهج الأسمى',
            ),
            ReadButton(
              onPressed: () {
                // عند الضغط، انتقل إلى شاشة عرض PDF
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowPdfScreen(
                      pdfFileId: '`المجلد الثالث`',
                      pdfAssetPath: 'assets/pdfs_files/folder3.pdf',
                    ),
                  ),
                );
              },
              text: ' المجلد الثالث من كتاب النهج الأسمى',
            ),
            ReadButton(
              onPressed: () {
                // عند الضغط، انتقل إلى شاشة عرض PDF
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ShowExplinationVideos(),
                  ),
                );
              },
              text: "مشاهدة الشرح",
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class ReadButton extends StatelessWidget {
  const ReadButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    // الألوان المستوحاة من الديكور الذهبي/النحاسي في الخلفية
    const Color startColor = Color(0xFFC0996D); // ذهبي نحاسي فاتح
    const Color endColor = Color(0xFFA17F51); // ذهبي نحاسي داكن

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
          decoration: BoxDecoration(
            // استخدام التدرج اللوني (Gradient) لإعطاء تأثير معدني
            gradient: const LinearGradient(
              colors: [startColor, Color.fromARGB(255, 139, 105, 58)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15.0), // حواف دائرية
            boxShadow: [
              // ظل خفيف لجعله يبدو بارزًا
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87, // لون نص داكن ليبرز على الخلفية الذهبية
              fontFamily: 'Amiri', // استخدام الخط الذي تستخدمه
              // fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.5, // ارتفاع السطر لتحسين قراءة النص الطويل
            ),
          ),
        ),
      ),
    );
  }
}
