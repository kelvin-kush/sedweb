import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? postID;
  String? caption;
  bool? isVideo;
  double? likes;
  Object? sender;
  String? meme;
  List? comments;
  List? likers;
  DateTime? postDate;
  List? tags;
  String? timestamp;

  Post({
    this.caption,
    this.isVideo,
    this.postID,
    this.likers,
    this.likes,
    this.postDate,
    this.meme,
    this.comments,
    this.sender,
    this.tags,
    this.timestamp,
  });

  factory Post.fromMap(map) {
    return Post(
      postID: map[' postID'],
      meme: map[' meme'],
      postDate: map[' postDate'],
      sender: map[' sender'],
      caption: map[' caption'],
      likers: map[' likers'],
      comments: map[' comments'],
      likes: map[' likes'],
      isVideo: map[' isVideo'],
      tags: ['tags'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postID': postID,
      'meme': meme,
      'postDate': postDate,
      'sender': sender,
      'caption': caption,
      'likers': likers,
      'comments': comments,
      'likes': likes,
      'isVideo': isVideo,
      'tags': tags,
      'timestamp': timestamp,
    };
  }
}
