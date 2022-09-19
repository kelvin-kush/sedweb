import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/chats/components/chat_card.dart';
import 'package:sedweb/Screens/Home/chats/components/message_card.dart';
import 'package:sedweb/Screens/Home/chats/components/preson_card.dart';
import 'package:sedweb/Screens/Home/chats/search_user.dart';
import 'package:sedweb/Screens/user_search/user_search.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/service/firebase_db.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _database = FirebaseDatabase.instance.ref();
  User? _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          title: const Text(
            'Chats',
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  try {
                    var res = await FirebaseDB.instance.getAllUsers();
                    showSearch(
                        context: context,
                        delegate: UserSearchDelegate(users: res));
                  } catch (e) {
                    print(e);
                  }
                },
                icon: const Icon(
                  Icons.search_outlined,
                  color: kPrimaryColor,
                ))
          ],
        ),
        body: StreamBuilder(
            stream: _database
                .child('chatRoomUsers/')
                .child(_currentUser!.uid)
                .onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                final _data = snapshot.data!.snapshot.children.toList();
                return ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: ((context, index) {
                      final personId = (_data[index].value as Map)["person"];
                      return ChatCard(
                        userId: personId,
                        groupChatId: _data[index].key!,
                      );
                    }));
              } else {
                return Container();
              }
            }));
  }
}

final randomData = [
  ['kate', 'Give me 90 percent', 'today'],
  ['Clemet Owusu', 'hello', '2:00'],
  ['derrick', 'Called you yesterday', '5:00'],
  ['kush', 'HEllo there', '7:00'],
];
