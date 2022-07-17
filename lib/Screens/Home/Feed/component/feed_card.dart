import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    child: postModel.sender != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              imageUrl:
                                  postModel.image!, //'${postModel.sender}',
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
                              '${postModel.sender}',
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
                            timeago.format(postModel.postDate!),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      postModel.message != null
                          ? Text(postModel.message!)
                          : Container(),
                      const SizedBox(height: 5),
                      postModel.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: postModel.image!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
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
