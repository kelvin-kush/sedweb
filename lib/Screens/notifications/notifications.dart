import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/notifications/components/notification_card.dart';
import 'package:sedweb/components/constraints.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: SafeArea(
        child: Stack(children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("notifications")
                  .where('receiver', isEqualTo: widget.uid)
                  .snapshots(),
              builder: (
                BuildContext context,
                snapshot,
              ) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        if (data['seen'] == false) {
                          FirebaseFirestore.instance
                              .collection("notifications")
                              .doc(data['notID'])
                              .update({'seen': true});
                        }
                        return NotificationCard(
                          seen: data['seen'],
                          title: data['title'],
                          message: data['message'],
                          senderProfile: data['sender']['profile'],
                          receiver: data['receiver'],
                          date: (data['date'] as Timestamp).toDate(),
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                } else {
                  return const Center(child:  Text('No notifications found'));
                }
              }),
        ]),
      ),
    );
  }
}
