import 'package:flutter/material.dart';
import 'package:nahj_asma_app/core/constants/explaination_videos.dart';
import 'package:nahj_asma_app/core/widgets/background_wrapper.dart';
import 'package:nahj_asma_app/providers/theme_provider.dart';
import 'package:nahj_asma_app/screens/home_screen.dart'; // افترضنا وجود ReadButton هنا
import 'package:nahj_asma_app/widgets/home_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // 💡 استيراد مكتبة url_launcher

class ShowExplinationVideos extends StatelessWidget {
  const ShowExplinationVideos({super.key});

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
              "فيديوهات شرح الكتاب",
              style: TextStyle(
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          // 💡 هنا يجب استخدام اسم القائمة التي أنشأتها مسبقاً، وهي: shuroohAsmaaAllah
          itemCount: shuroohAsmaaAllahLinksList.length,
          itemBuilder: (context, index) {
            final video = shuroohAsmaaAllahLinksList[index];
            return ReadButton(
              // ❌ التعديل: استخدم دالة مجهولة لتمرير الاستدعاء
              // يجب أن تكون القيمة الممررة لـ onPressed هي دالة لا تقبل وسيطات
              onPressed: () => _onPressed(video.url, context),
              text: video.title,
            );
          },
        ),
      ),
    );
  }

  // 1. يجب أن تكون الدالة ستاتيك إذا كانت في StatelessWidget أو ضمن الكلاس
  // 2. أضف Context لتمكين عرض رسالة الخطأ (Snackbar)
  Future<void> _onPressed(String videoUrl, BuildContext context) async {
    final Uri url = Uri.parse(videoUrl);

    // 💡 الكود الجديد: استخدام url_launcher لفتح الرابط
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // إذا فشل الفتح، اعرض رسالة خطأ (Snackbar)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر فتح رابط الفيديو: $videoUrl')),
        );
      }
    }
  }
}
