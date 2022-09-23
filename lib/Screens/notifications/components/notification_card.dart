import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {Key? key,
      required this.title,
      required this.message,
      this.receiver,
      this.notId,
      required this.date,
      required this.senderID,
      required this.seen})
      : super(key: key);
  final String title;
  final String? receiver;
  final String message;
  final DateTime date;
  final String? notId;
  final String senderID;
  final bool seen;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(senderID).get(),
        builder: (context, AsyncSnapshot snapshot) {
          UserModel? _userModel;
          if (snapshot.hasData) {
            _userModel = UserModel.fromMap(snapshot.data);

            return Card(
              elevation: 1,
              child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(38, 158, 158, 158), width: 1),
                    ),
                  ),
                  //height: 115,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  // margin: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            _userModel.profile!,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messageFormat(message, _userModel.name!),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: seen ? Colors.black54 : Colors.black),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(timeago.format(date),
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10.0),

                    const SizedBox(
                      height: 10.0,
                    ),
                  ])),
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

  String messageFormat(String type, String user) {
    switch (type) {
      case "follow":
        return '$user started following you.';
      default:
        return '$user started following you.';
    }
  }
}
