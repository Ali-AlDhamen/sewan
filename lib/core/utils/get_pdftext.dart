import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
Future<String> getPDFtext(String path) async {
  String text = "";
  try {
    text = await ReadPdfText.getPDFtext(path);
    print(text);
  } on PlatformException {
    text = 'Failed to get PDF text.'; 
  }
  return text;
}