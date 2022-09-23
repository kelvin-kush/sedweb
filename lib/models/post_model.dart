import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? postID;
  String? message;
  int? likes;
  String senderID;
  String? image;
  List? comments;
  List? likers;
  DateTime? postDate;

  PostModel({
    this.message,
    this.postID,
    this.likers,
    this.likes,
    this.postDate,
    this.image,
    this.comments,
    required this.senderID,
  });

  factory PostModel.fromMap(map) {
    return PostModel(
      postID: map['postID'],
      image: map['image'],
      postDate: (map['postDate'] as Timestamp).toDate(),
      senderID: map['senderID'],
      message: map['message'],
      likers: map['likers']??[],
      comments: map['comments'],
      likes:int.parse("${map['likes']}"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'image': image ?? '',
      'postDate': postDate,
      'senderID': senderID,
      'message': message ?? '',
      'likers': likers ?? [],
      'comments': comments ?? [],
      'likes': likes ?? 0,
    };
  }
}
