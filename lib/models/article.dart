import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Article {
  final String id;
  final String documentUrl;
  final String name;
  final String userId;
  final String profile;
  final String docName;
  final String topic;
  final List<String> comments;
  final DateTime createdAt;

  Article(
      {required this.id,
      required this.documentUrl,
      required this.name,
      required this.userId,
      required this.profile,
      required this.comments,
      required this.topic,
      required this.docName,
      required this.createdAt});

  Article.fromJson(Map data)
      : comments = (data['comments'].cast<String>()),
        createdAt = (data['createdAt'] ?? Timestamp.now()).toDate(),
        documentUrl = data['documentUrl'],
        id = data['id'],
        name = data['name'],
        topic = data['topic'],
        profile = data['profile'],
        docName = data['docName'],
        userId = data['userId'];

  Map<String, dynamic> get toJson => {
        'id': id,
        'documentUrl': documentUrl,
        'name': name,
        'userId': userId,
        'profile': profile,
        'docName': docName,
        'comments': comments,
        'topic': topic,
        'createdAt': FieldValue.serverTimestamp()
      };
}

class ArticleComment {
  final String id;
  final String comment;
  final String articleId;
  final String name;
  final String userId;
  final String profile;
  final DateTime createdAt;

  ArticleComment(
      {required this.id,
      required this.comment,
      required this.articleId,
      required this.name,
      required this.userId,
      required this.profile,
      required this.createdAt});

  ArticleComment.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        articleId = data['articleId'],
        comment = data['comment'],
        createdAt = (data['createdAt'] ?? Timestamp.now()).toDate(),
        name = data['name'],
        profile = data['profile'],
        userId = data['userId'];

  Map<String, dynamic> get toJson => {
        'id': id,
        'comment': comment,
        'articleId': articleId,
        'name': name,
        'userId': userId,
        'profile': profile,
        'createdAt': FieldValue.serverTimestamp()
      };
}
