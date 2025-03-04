import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PDFViewerScreen extends StatelessWidget {
  final File pdfFile;
  PDFViewerScreen({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: PDFView(
        filePath: pdfFile.path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          debugPrint("PDF Xatolik: $error");
        },
        onPageError: (page, error) {
          debugPrint("Xatolik: $page: $error");
        },
      ),
    );
  }
}
