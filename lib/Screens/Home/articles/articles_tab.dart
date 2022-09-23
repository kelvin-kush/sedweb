import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/articles/article_full_screen.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/article.dart';
import 'package:sedweb/service/firebase_db.dart';

import '../Feed/component/add_feed.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesTab extends StatelessWidget {
  const ArticlesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Column(
        children: [
          const AddFeed(
            isFromArticles: true,
          ),
          StreamBuilder<QuerySnapshot<Article>>(
              stream: FirebaseDB.instance.getArticles(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                if (snapshot.hasData) {
                  List<Article> data =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (c, i) {
                            return _ArticleCard(article: data[i]);
                          }));
                }
                return Container();
              })
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ArticleFullScreen(article: article)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                    child: article.profile != null && article.profile != ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              imageUrl: article.profile,
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
                            ),
                          )
                        : const Icon(Icons.person),
                  ),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    article.name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  timeago.format(article.createdAt),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(article.topic),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.document_scanner,
                                    size: 18,
                                  ),
                                  Text(
                                    article.docName,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Row(
                              children: [
                                const Icon(Icons.comment),
                                Text(article.comments.length.toString())
                              ],
                            )
                          ],
                        )))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
