import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {Key? key,
      required this.title,
      required this.message,
      this.receiver,
      this.notId,
      required this.date,
      required this.senderProfile,
      required this.seen})
      : super(key: key);
  final String title;
  final String? receiver;
  final String message;
  final DateTime date;
  final String? notId;
  final String senderProfile;
  final bool seen;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(38, 158, 158, 158), width: 1),
          ),
        ),
        //height: 115,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // margin: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 40,
                width: 40,
                child: Image.network(
                  "${senderProfile}",
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
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${timeago.format(date)}',
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color.fromRGBO(254, 206, 0, 1),
                        )),
                  ],
                ),
                Text(
                  message,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: seen ? Colors.white54 : Colors.white),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10.0),

          SizedBox(
            height: 10.0,
          ),
        ]));
  }
}
