import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/chats/components/chat_card.dart';
import 'package:sedweb/Screens/Home/chats/search_user.dart';
import 'package:sedweb/components/constraints.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor)),
              height: 30,
              width: 30,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchUser()));
                },
                child: const Icon(
                  Icons.search,
                  size: 20,
                  color: kPrimaryColor,
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: randomData.length,
          itemBuilder: ((context, index) {
            return ChatCard(
              username: randomData[index][0],
              messageDate: randomData[index][2],
              lastMessage: randomData[index][1],
            );
          })),
    );
  }
}

final randomData = [
  ['kate', 'Give me 90 percent', 'today'],
  ['Clemet Owusu', 'hello', '2:00'],
  ['derrick', 'Called you yesterday', '5:00'],
  ['kush', 'HEllo there', '7:00'],
];
