import 'package:file_picker/file_picker.dart';

class DocumentService {
  static final instance = DocumentService._();

  DocumentService._();

  Future pickDocument() async {
    try {
      var res = await FilePicker.platform.pickFiles(
          allowedExtensions: ['doc', 'pdf', 'docx'], type: FileType.custom);
      return res?.files[0] ?? 'No File selected';
    } on Exception {
      return 'Error picking file';
    }
  }
}
