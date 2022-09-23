import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sedweb/models/article.dart';
import 'package:sedweb/models/user_model.dart';

class FirebaseDB {
  late FirebaseFirestore _database;

  static FirebaseDB instance = FirebaseDB._();

  FirebaseDB._() {
    _database = FirebaseFirestore.instance;
  }

  Future<List<UserModel>> getAllUsers() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var res = await _database
        .collection('users')
        // .where(uid, isEqualTo: false)
        .withConverter<UserModel>(
            fromFirestore: (data, _) => UserModel.fromMap(data.data()),
            toFirestore: (value, _) => value.toJson())
        .get();
    res.docs.removeWhere((element) => element.data().id == uid);
    return res.docs
        .map((e) => e.data())
        .where((element) => element.id != uid)
        .toList();
  }

  Future<String?> addArticle(Article article) async {
    try {
      await _database
          .collection('Articles')
          .doc(article.id)
          .set(article.toJson);
    } on Exception {
      return 'Error adding article';
    }
  }

  Stream<QuerySnapshot<Article>> getArticles() async* {
    yield* (_database
        .collection('Articles')
        .withConverter<Article>(
            fromFirestore: (value, _) =>
                Article.fromJson({...value.data()!, 'id': value.id}),
            toFirestore: (data, _) => data.toJson)
        .snapshots());
  }
}
