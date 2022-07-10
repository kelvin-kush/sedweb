import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    child: postModel.sender != null
                        ? CachedNetworkImage(
                            imageUrl: '${postModel.sender}',
                            placeholder: (context, url) {
                              return const ColoredBox(
                                  color:
                                       Colors.white24,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${postModel.sender}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${postModel.postDate!.toLocal().toString().substring(1, 4)}'),
                        ],
                      ),
                      postModel.message != null
                          ? Text(postModel.message!)
                          : Container(),
                      postModel.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: '',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                              return const ColoredBox(
                                  color:
                                       Colors.white24,
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
                                size: 50,
                              );
                            },
                              ),
                            )
                          : Container()
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
