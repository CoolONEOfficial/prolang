import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/ui/views/home/lesson/widgets/download_button.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:http/http.dart' as http;

class LessonPdfDialog extends StatelessWidget {
  final Lang lang;
  final LessonSection section;
  final Lesson lesson;

  const LessonPdfDialog({
    Key key,
    this.lang,
    this.section,
    this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = FirebasePaths.lessonPath(
      lang,
      section,
      lesson,
    );

    return ResponsiveSafeArea(
      child: PlatformScaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: FutureBuilder<Uint8List>(
            future: FirebaseStorageService.loadFromStorage("$path/pdf.pdf")
                .then((value) async => (await http.get(value)).bodyBytes),
            builder: (context, snapshot) {
              debugPrint("error: ${snapshot.error.toString()}");
              return snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError
                  ? _LessonPdf(pdfData: snapshot.data)
                  : LoadingIndicator();
            },
          ),
        ),
        appBar: PlatformAppBar(
          title: Text("PDF"),
          trailingActions: <Widget>[
            DownloadButton(
              url: FirebaseStorageService.loadFromStorage("$path/pdf.pdf"),
              fileName: "${lesson.documentId}.pdf",
            )
          ],
          material: (context, _) => MaterialAppBarData(
            shape: appBarShape(context),
          ),
          cupertino: (context, _) => CupertinoNavigationBarData(
            previousPageTitle: lesson.title,
          ),
        ),
      ),
    );
  }
}

class _LessonPdf extends StatefulWidget {
  final Uint8List pdfData;

  const _LessonPdf({
    Key key,
    this.pdfData,
  }) : super(key: key);

  @override
  _LessonPdfState createState() => _LessonPdfState();
}

class _LessonPdfState extends State<_LessonPdf> {
  PdfController _pdfController;

  @override
  void initState() {
    debugPrint("pre data: ${widget.pdfData?.length}");
    _pdfController = PdfController(
      document: PdfDocument.openData(widget.pdfData),
    );
    debugPrint("post data");
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PdfView(
        controller: _pdfController,
        documentLoader: LoadingIndicator(),
        pageLoader: LoadingIndicator(),
        onDocumentLoaded: (document) {
          debugPrint("srcname: ${document.sourceName}");
          
        },
      );
}
