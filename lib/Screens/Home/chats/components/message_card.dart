import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sedweb/Screens/Home/chats/components/view_chat_image.dart';

class MessageCard extends StatefulWidget {
  const MessageCard(
      {Key? key,
      required this.isSender,
      required this.id,
      this.imageUrl,
      required this.text,
      required this.time})
      : super(key: key);
  final String text;
  final bool isSender;
  final DateTime time;
  final String id;
  final String? imageUrl;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool delete = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          delete = !delete;
        });
      },
      onTap: widget.imageUrl == 'null'
          ? () {}
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          ViewChatImage(imageUrl: widget.imageUrl!))));
            },
      child: widget.imageUrl == 'null'
          ? Container(
              width: double.infinity,
              color: delete ? Colors.blueGrey.withOpacity(0.3) : null,
              padding: EdgeInsets.only(
                  left: widget.isSender ? 50 : 14,
                  right: widget.isSender ? 14 : 50,
                  top: 5,
                  bottom: 5),
              margin: const EdgeInsets.only(bottom: 2),
              child: Align(
                alignment:
                    (widget.isSender ? Alignment.topRight : Alignment.topLeft),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: (widget.isSender
                        ? Colors.blue[200]
                        : Colors.grey.shade200),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.text,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat.jm().format(widget.time),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.mark_chat_unread_outlined,
                            color: Colors.green,
                            size: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              width: double.infinity,
              color: delete ? Colors.blueGrey.withOpacity(0.3) : null,
              padding: EdgeInsets.only(
                  left: widget.isSender ? 100 : 14,
                  right: widget.isSender ? 14 : 100,
                  top: 5,
                  bottom: 5),
              margin: const EdgeInsets.only(bottom: 2),
              child: Align(
                alignment:
                    (widget.isSender ? Alignment.topRight : Alignment.topLeft),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (widget.isSender
                        ? Colors.blue[200]
                        : Colors.grey.shade200),
                  ),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl!,
                          height: 320,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: widget.text != "" ? 10 : 0,
                      ),
                      widget.text != ""
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.text,
                                style: const TextStyle(fontSize: 15),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat.jm().format(widget.time),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black54),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(
                            Icons.mark_chat_unread_outlined,
                            color: Colors.green,
                            size: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
