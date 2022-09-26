import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? noteID;
  String? message;
  String senderID;
  String title;
  DateTime? noteDate;

  NoteModel({
    this.message,
    this.noteID,
    this.noteDate,
    required this.senderID,
    required this.title,
  });

  factory NoteModel.fromMap(map) {
    return NoteModel(
      noteID: map['noteID'],
      noteDate: (map['noteDate'] as Timestamp).toDate(),
      senderID: map['senderID'],
      message: map['message'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noteID': noteID,
      'noteDate': noteDate,
      'senderID': senderID,
      'message': message ?? "",
      'title': title,
    };
  }
}
