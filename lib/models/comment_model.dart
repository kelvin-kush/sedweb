import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? commentId;
  String? postID;
  String? comment;
  String? sender;
  DateTime? postDate;

  CommentModel({
    this.postID,
    this.commentId,
    this.comment,
    this.postDate,
    this.sender,
  });

  factory CommentModel.fromMap(map) {
    return CommentModel(
      commentId: map['commentId'],
      postDate: (map['postDate'] as Timestamp).toDate(),
      sender: map['sender'],
      postID: map['postID'],
      comment: map['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postDate': postDate,
      'sender': sender,
      'postID': postID ?? '',
      'comment': comment ?? '',
    };
  }
}
