import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/Feed/feed_details.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedCard extends StatefulWidget {
  const FeedCard({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.postModel.senderID)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          UserModel? _userModel;
          if (snapshot.hasData) {
            _userModel = UserModel.fromMap(snapshot.data);
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeedDetails(
                            postModel: widget.postModel,
                            user: _userModel ?? UserModel(),
                          )));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl:
                              _userModel != null ? _userModel.profile! : "",
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
                            return const CircleAvatar(
                                child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 15,
                            ));
                          },
                        ),
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
                                    _userModel != null ? _userModel.name! : "",
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
                                  timeago.format(widget.postModel.postDate!),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ]),
                          widget.postModel.message != null &&
                                  widget.postModel.message!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(widget.postModel.message!),
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          (widget.postModel.image != null &&
                                  widget.postModel.image!.isNotEmpty)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.postModel.image!,
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
                              : Container(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: TextButton(
                                      onPressed: () async {
                                        if (widget.postModel.likers!
                                            .contains(_currentUser!.uid)) {
                                          //remove like from db
                                          await FirebaseFirestore.instance
                                              .collection("Posts")
                                              .doc(widget.postModel.postID)
                                              .update({
                                            "likers": widget
                                                    .postModel.likers!.isEmpty
                                                ? FieldValue.arrayRemove(
                                                    widget.postModel.likers!)
                                                : FieldValue.arrayRemove(
                                                    [_currentUser!.uid])
                                          });
                                          //subtract 1 from likes
                                          await FirebaseFirestore.instance
                                              .collection("Posts")
                                              .doc(widget.postModel.postID)
                                              .update({
                                            "likes": widget.postModel.likes! - 1
                                          });
                                          setState(() {});
                                        } else {
                                          // add like
                                          widget.postModel.likers!
                                              .add(_currentUser!.uid);
                                          await FirebaseFirestore.instance
                                              .collection("Posts")
                                              .doc(widget.postModel.postID)
                                              .update({
                                            "likers": widget
                                                    .postModel.likers!.isEmpty
                                                ? FieldValue.arrayUnion(
                                                    widget.postModel.likers!)
                                                : FieldValue.arrayUnion(
                                                    [_currentUser!.uid])
                                          });
                                          //add 1 to likes
                                          await FirebaseFirestore.instance
                                              .collection("Posts")
                                              .doc(widget.postModel.postID)
                                              .update({
                                            "likes": widget.postModel.likes! + 1
                                          });
                                          setState(() {});
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            widget.postModel.likers!
                                                    .contains(_currentUser!.uid)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: widget.postModel.likers!
                                                    .contains(_currentUser!.uid)
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              widget.postModel.likes.toString())
                                        ],
                                      ),
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero))),
                              Expanded(
                                  flex: 3,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FeedDetails(
                                                    postModel: widget.postModel,
                                                    user: _userModel ??
                                                        UserModel(),
                                                  )));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.comment,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: TextButton(
                                onPressed: () {},
                                child: const Icon(Icons.share,
                                    color: Colors.black),
                              )),
                            ],
                          )
                        ],
                      ),
                    ))
                  ])
                ]),
              ),
            ),
          );
        });
  }
}
