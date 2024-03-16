import 'dart:io';

import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<String> getPDFtext(String path) async {
  String text = "";
  try {
    //Load an existing PDF document.
    final PdfDocument document =
        PdfDocument(inputBytes: File(path).readAsBytesSync());
    //Extract the text from all the pages.
    String text = PdfTextExtractor(document).extractText();
    //Dispose the document.
    document.dispose();

    return text;
  } on PlatformException {
    text = 'Failed to get PDF text.';
  }
  return text;
}
