import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart'; // Import required for AssetBundle access

class ShowPdfScreen extends StatefulWidget {
  // معرف الملف الفريد (مثل اسم ملف الكتاب) لحفظ آخر صفحة قراءة.
  final String pdfFileId;
  // مسار ملف PDF في مجلد Assets
  final String pdfAssetPath;

  const ShowPdfScreen({
    super.key,
    required this.pdfFileId,
    required this.pdfAssetPath,
  });

  @override
  State<ShowPdfScreen> createState() => _ShowPdfScreenState();
}

class _ShowPdfScreenState extends State<ShowPdfScreen> {
  int _lastReadPage = 1;
  late PdfViewerController _pdfViewerController;
  bool _isLoading = true;
  int _totalPages = 0; // 1. تم إضافة المتغير المفقود لتخزين العدد الكلي للصفحات

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    // ابدأ بتحميل آخر صفحة قراءة عند تهيئة الشاشة
    _loadLastReadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pdfFileId,
          style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold),
        ), // عرض معرف الملف كعنوان
        centerTitle: true,
        actions: [
          // 3. تم تحديث زر الطباعة لاستدعاء الديالوج بدلاً من دالة الطباعة مباشرة
          IconButton(
            icon: const Icon(Icons.print, size: 28),
            tooltip: 'تحديد النطاق وطباعة المستند',
            onPressed: _showPrintRangeDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Directionality(
              textDirection:
                  TextDirection.rtl, // لضمان عرض المحتوى العربي بشكل صحيح
              child: SfPdfViewer.asset(
                widget.pdfAssetPath,
                controller: _pdfViewerController,
                // هذا الـ Callback يتم تشغيله في كل مرة تتغير فيها الصفحة
                onPageChanged: (details) {
                  _saveCurrentPage(details.newPageNumber);
                },
                // تم تحديث هذا الجزء لحفظ العدد الكلي للصفحات
                onDocumentLoaded: (details) {
                  setState(() {
                    _totalPages =
                        details.document.pages.count; // تم حفظ العدد الكلي هنا
                  });
                  // عند اكتمال تحميل المستند، نتأكد من القفز إلى الصفحة المحفوظة
                  if (_pdfViewerController.pageNumber != _lastReadPage) {
                    _pdfViewerController.jumpToPage(_lastReadPage);
                  }
                },
              ),
            ),
    );
  }

  // ميزة حفظ آخر صفحة قراءة
  Future<void> _loadLastReadPage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // استخدام pdfFileId كمفتاح فريد لكل ملف
      final page = prefs.getInt('last_page_${widget.pdfFileId}') ?? 1;
      setState(() {
        _lastReadPage = page;
        _isLoading = false;
        // الانتقال إلى الصفحة المحفوظة فور تحميل المستند
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pdfViewerController.pageNumber != _lastReadPage) {
            _pdfViewerController.jumpToPage(_lastReadPage);
          }
        });
      });
    } catch (e) {
      // طباعة الخطأ في وحدة التحكم دون إظهاره للمستخدم
      print('Error loading last read page: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // حفظ رقم الصفحة الحالية عند التنقل
  Future<void> _saveCurrentPage(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_page_${widget.pdfFileId}', page);
      // يمكنك إزالة هذه الطباعة في الإنتاج
      print('Saved page $page for ${widget.pdfFileId}');
    } catch (e) {
      print('Error saving current page: $e');
    }
  }

  // ميزة الطباعة: تم تحديث توقيع الدالة لاستقبال نطاق الصفحات
  Future<void> _printDocument(
    String title,
    String assetPath, {
    required int startPage,
    required int endPage,
  }) async {
    try {
      // تحميل ملف PDF من مجلد assets كـ بيانات
      final fileData = await DefaultAssetBundle.of(context).load(assetPath);
      final pdfBytes = fileData.buffer.asUint8List();

      // استخدام Printing.sharePdf لفتح شاشة المشاركة/الطباعة
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: '$title-pages-$startPage-to-$endPage.pdf',
      );

      // رسالة توجيهية للمستخدم لتحديد النطاق مرة أخرى في إعدادات النظام
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم فتح نافذة الطباعة/المشاركة. الرجاء تحديد الصفحات من $startPage إلى $endPage للطباعة في الإعدادات الأصلية.',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('فشل في عملية الطباعة: $e')));
      }
    }
  }

  // واجهة تحديد نطاق الطباعة
  Future<void> _showPrintRangeDialog() async {
    int startPage = 1;
    int endPage = _totalPages;

    if (_totalPages == 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الرجاء الانتظار حتى يتم تحميل المستند بالكامل.'),
          ),
        );
      }
      return;
    }

    // يتم عرض الديالوج
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();

        return Directionality(
          textDirection: TextDirection.rtl, // لضمان عرض الحقول باللغة العربية
          child: AlertDialog(
            title: const Text('تحديد نطاق الطباعة', textAlign: TextAlign.right),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'إجمالي عدد الصفحات: $_totalPages',
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: startPage.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: 'من صفحة رقم',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.start),
                    ),
                    validator: (value) {
                      final page = int.tryParse(value ?? '');
                      if (page == null || page < 1 || page > _totalPages) {
                        return 'الرجاء إدخال رقم صفحة صالح (1 إلى $_totalPages)';
                      }
                      startPage = page;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: endPage.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: 'إلى صفحة رقم',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.send),
                    ),
                    validator: (value) {
                      final page = int.tryParse(value ?? '');
                      if (page == null || page < 1 || page > _totalPages) {
                        return 'الرجاء إدخال رقم صفحة صالح (1 إلى $_totalPages)';
                      }
                      endPage = page;
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('إلغاء'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('طباعة'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (startPage > endPage) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'صفحة البداية يجب أن تكون أصغر من صفحة النهاية.',
                            ),
                          ),
                        );
                      }
                      return;
                    }
                    Navigator.of(context).pop();
                    // استدعاء دالة الطباعة مع النطاق المحدد
                    _printDocument(
                      widget.pdfFileId,
                      widget.pdfAssetPath,
                      startPage: startPage,
                      endPage: endPage,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
