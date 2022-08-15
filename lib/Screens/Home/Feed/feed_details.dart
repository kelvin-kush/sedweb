import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/user_profile/user_profile.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedDetails extends StatelessWidget {
  const FeedDetails({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Feed',style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => UserProfile(
                                userId: (postModel.sender as Map)['uid']!))));
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          child: (postModel.sender as Map)['profile'] != null &&
                                  (postModel.sender as Map)['profile'] != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        (postModel.sender as Map)['profile'],
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
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
                            Column(
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${(postModel.sender as Map)['name']}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  timeago.format(postModel.postDate!),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              postModel.message != null && postModel.message!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(postModel.message!,
                          style: const TextStyle(fontSize: 19)),
                    )
                  : Container(),
              const SizedBox(height: 5),
              (postModel.image != null && postModel.image!.isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: postModel.image!,
                        height: 250,
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
                  : Container(),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('10K')
                            ],
                          ),
                          style:
                              TextButton.styleFrom(padding: EdgeInsets.zero))),
                  Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.comment,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('10K')
                          ],
                        ),
                      )),
                  Expanded(
                      child: TextButton(
                    onPressed: () {},
                    child: Icon(Icons.share, color: Colors.black),
                  )),
                ],
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
