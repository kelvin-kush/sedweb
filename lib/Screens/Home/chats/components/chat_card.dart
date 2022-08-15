import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/chats/chat_screen.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {Key? key,
      required this.username,
      this.lastMessage,
      this.messageDate,
      this.profileImage})
      : super(key: key);
  final String? profileImage;
  final String username;
  final String? lastMessage;
  final String? messageDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ChatScreen(
            //             username: username,
            //           )),
            // );
          },
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(username),
          subtitle: lastMessage != null ? Text(lastMessage!) : null,
          trailing: lastMessage != null
              ? Text(
                  messageDate!,
                  style: const TextStyle(fontSize: 13, color: Colors.black45),
                )
              : null,
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
}
