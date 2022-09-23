import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/models/article.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleFullScreen extends StatefulWidget {
  const ArticleFullScreen({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  State<ArticleFullScreen> createState() => _ArticleFullScreenState();
}

class _ArticleFullScreenState extends State<ArticleFullScreen> {
  late bool isReadLoading;

  @override
  void initState() {
    super.initState();
    isReadLoading = false;
  }

  void onRead() {
    Dio()
        .get(widget.article.documentUrl,
            options: Options(responseType: ResponseType.bytes))
        .then((value) {
      var file = File.fromRawPath(value.data);
      print(file.readAsLinesSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
                child: widget.article.profile != null ||
                        widget.article.profile != ''
                    ? Image.network(
                        widget.article.profile,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.person)),
            title: Text(
              widget.article.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              timeago.format(widget.article.createdAt),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: RichText(
                text: TextSpan(
                    text: 'Article Topic:\n',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    children: [
                  TextSpan(
                      text: widget.article.topic,
                      style: const TextStyle(
                        color: Colors.black54,
                      ))
                ])),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: RichText(
                text: TextSpan(
                    text: 'Article filename:\n',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    children: [
                  TextSpan(
                      text: widget.article.docName,
                      style: const TextStyle(
                        color: Colors.black54,
                      ))
                ])),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.comment),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.article.comments.length.toString())
                  ],
                ),
                TextButton.icon(
                    onPressed: onRead,
                    icon: const Icon(Icons.read_more),
                    label: const Text('Read article')),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.summarize),
                    label: const Text('Get summary'))
              ],
            ),
          ),
          Divider(),
          // Expanded(child: )
        ],
      ),
    );
  }
}
