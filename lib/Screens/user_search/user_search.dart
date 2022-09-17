import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:sedweb/service/firebase_db.dart';

import '../Home/chats/chat_screen.dart';

class UserSearchDelegate extends SearchDelegate<String> {
  final List<UserModel> users;
  UserSearchDelegate({required this.users}) : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var res = _getUsers();
    return ListView.builder(
        itemCount: res.length,
        itemBuilder: (_, i) => ListTile(
              title: Text(res[i].name ?? ''),
              onTap: () => _onUserTap(res[i].id!, context, res[i]),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var res = _getUsers();
    return ListView.builder(
        itemCount: res.length,
        itemBuilder: (_, i) => ListTile(
              title: Text(res[i].name ?? ''),
              onTap: () => _onUserTap(res[i].id!, context, res[i]),
            ));
  }

  List<UserModel> _getUsers() => users
      .where((element) =>
          element.name!.toLowerCase().contains(query.toLowerCase()))
      .toList();

  void _onUserTap(String userId, BuildContext context, UserModel userModel) {
    var currentUser = FirebaseAuth.instance.currentUser;
    final _database = FirebaseDatabase.instance.ref();
    String groupChatId = "";
    if (currentUser!.uid.compareTo(userId) == -1) {
      groupChatId = "${currentUser.uid}-${userId}";
    } else {
      groupChatId = "${userId}-${currentUser.uid}";
    }
    final chatroom = _database.child('/chatRoom/$groupChatId/members');
    chatroom.set({
      userId: true,
      currentUser.uid: true,
    });
    final chatroomUser1 =
        _database.child('/chatRoomUsers/${userId}/$groupChatId');
    chatroomUser1.set({
      'person': currentUser.uid,
    });
    final chatroomUser2 =
        _database.child('/chatRoomUsers/${currentUser.uid}/$groupChatId');
    chatroomUser2.set({
      'person': userId,
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ChatScreen(
                  user: userModel,
                  groupChatId: groupChatId,
                ))));
  }
}
