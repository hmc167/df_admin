import 'dart:io';
import 'dart:typed_data';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as h2p;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class HtmlPdfPreview extends StatelessWidget {
  final String html;
  final String pdfFileName;
  const HtmlPdfPreview({
    super.key,
    required this.html,
    required this.pdfFileName,
  });

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      pdfFileName: pdfFileName,
      allowPrinting: true,
      allowSharing: false,
      initialPageFormat: PdfPageFormat.a4,
      canChangeOrientation: false,
      canChangePageFormat: false,
      dynamicLayout: true,
      shouldRepaint: true,
      build: (format) async => await htmlToPdfBytes(html),
    );
  }

  // Future<Uint8List> htmlToPdfBytes(String html) async {
  //   final doc = pw.Document();
  //   final widgets = await h2p.HTMLToPdf().convert(html); // HTML -> pw.Widgets
  //   doc.addPage(pw.MultiPage(build: (_) => widgets));
  //   return await doc.save();
  // }

  Future<Uint8List> htmlToPdfBytes(String html) async {
  final latin = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans/NotoSans-Regular.ttf'));
  final latinBold = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans/NotoSans-Bold.ttf'));
  final guj = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSansGujarati/NotoSansGujarati-Regular.ttf'));
  final gujBold = pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSansGujarati/NotoSansGujarati-Bold.ttf'));

  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: latin, bold: latinBold),
  );

  final widgets = await h2p.HTMLToPdf().convert(html);

  doc.addPage(
    pw.MultiPage(
      build: (_) => [
        pw.DefaultTextStyle(
          style: pw.TextStyle(fontFallback: [guj, gujBold]),
          child: pw.Column(children: widgets),
        ),
      ],
    ),
  );

  return await doc.save();
}
}
