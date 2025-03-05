import 'dart:io';

import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';


class PDFViewerScreen extends StatelessWidget {
  final File pdfFile;
  PDFViewerScreen({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back,color: AppColors.backgroundColor,)),
        backgroundColor: AppColors.grade1,
        title: Text("PDF",style: AppStyle.fontStyle.copyWith(color: AppColors.backgroundColor,fontSize: 20),)),
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
