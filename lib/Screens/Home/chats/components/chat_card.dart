import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/chats/chat_screen.dart';
import 'package:sedweb/models/user_model.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.userId,
    required this.groupChatId,
  }) : super(key: key);
  final String userId;
  final String groupChatId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          UserModel? _userModel;
          if (snapshot.hasData) {
            _userModel = UserModel.fromMap(snapshot.data);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                user: _userModel!,
                                groupChatId: groupChatId,
                              )),
                    );
                  },
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(_userModel.name!),
                  subtitle: const Text(
                    'Give me 90 percent',
                  ),
                  trailing: const Text(
                    "today",
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    color: Colors.black12,
                    height: 0.1,
                  ),
                )
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Container(
                    width: 10,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                  subtitle: Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[200],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    color: Colors.black12,
                    height: 0.1,
                  ),
                )
              ],
            );
          }
        });
  }
}
