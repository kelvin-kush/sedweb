import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? postID;
  String? message;
  int? likes;
  Object sender;
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
    required this.sender,
  });

  factory PostModel.fromMap(map) {
    return PostModel(
      postID: map['postID'],
      image: map['image'],
      postDate: (map['postDate'] as Timestamp).toDate(),
      sender: map['sender'],
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
      'sender': sender,
      'message': message ?? '',
      'likers': likers ?? [],
      'comments': comments ?? [],
      'likes': likes ?? 0,
    };
  }
}
