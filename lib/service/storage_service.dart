import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final instance = StorageService._();
  StorageService._();

  Future<String?> uploadDocument(File file, String name) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // final fileName = basename(file.path);
    // final destination = 'files/$fileName';
    String uuid = const Uuid().v4();
    try {
      final ref = storage.ref('articles/').child('$uuid/');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
