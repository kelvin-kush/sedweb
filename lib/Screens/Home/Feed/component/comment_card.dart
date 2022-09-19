import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';

import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatefulWidget {
  const CommentCard(
      {Key? key,
      required this.comment,
      required this.commentID,
      required this.senderImage,
      required this.timeStamp,
      required this.senderUid,
      required this.senderName})
      : super(key: key);
  final String comment;
  final String? senderImage;
  final DateTime timeStamp;
  final String commentID;
  final String senderName;
  final String senderUid;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.senderImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: (widget.senderImage) as String,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
                //'${postModel.sender}',
                placeholder: (context, url) {
                  return const ColoredBox(
                      color: Colors.white24,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ));
                },
                errorWidget: (context, error, url) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 25,
                  );
                },
              ))
          : const Padding(
              padding: EdgeInsets.all(5.0),
              child: CircularProgressIndicator(),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.senderName,
            style: const TextStyle(fontSize: 13),
          ),
          Text(
            timeago.format((widget.timeStamp)),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(widget.comment),
    );
  }
}
