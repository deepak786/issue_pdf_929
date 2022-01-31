import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyPdfPreview extends StatefulWidget {
  const MyPdfPreview({Key? key}) : super(key: key);

  @override
  _MyPdfPreviewState createState() => _MyPdfPreviewState();
}

class _MyPdfPreviewState extends State<MyPdfPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (_) => _generateDocument(PdfPageFormat.a4),
        useActions: false,
        padding: const EdgeInsets.only(bottom: 80.0),
        previewPageMargin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        pdfPreviewPageDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        // Widget to display if the PDF document cannot be displayed
        onError: (BuildContext context, Object error) {
          // default error widget
          return ErrorWidget(error);
        },
      ),
    );
  }

  /// get the document to display on the screen
  Future<Uint8List> _generateDocument(PdfPageFormat pageFormat) async {
    // initialize the document
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        header: (context) {
          return pw.Column(
            children: [
              pw.Text(
                'Title ',
                style: pw.TextStyle(
                  fontSize: 36.0,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 10.0),
            ],
          );
        },
        build: (context) {
          return [
            pw.Lorem(length: 100),
            pw.SizedBox(height: 10.0),
            pw.Lorem(),
            pw.SizedBox(height: 10.0),
            pw.Lorem(length: 350),
            pw.SizedBox(height: 10.0),
            pw.Lorem(length: 100),
          ];
        },
        footer: (context) {
          return pw.Center(
            child: pw.Text('${context.pageNumber} of ${context.pagesCount}'),
          );
        },
      ),
    );

    return document.save();
  }
}
