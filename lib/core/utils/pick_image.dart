import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickFile() async {
  final image = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  return image;
}

