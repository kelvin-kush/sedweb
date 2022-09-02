import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/Feed/component/comment_card.dart';
import 'package:sedweb/Screens/Home/user_profile/user_profile.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedDetails extends StatefulWidget {
  const FeedDetails({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;

  @override
  State<FeedDetails> createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot<Map<String, dynamic>>? snapshot;
  TextEditingController comment = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      snapshot = value;
    });
    print(widget.postModel.postID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Feed',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => UserProfile(
                                      userId: (widget.postModel.sender
                                          as Map)['uid']!))));
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
                                child: (widget.postModel.sender
                                                as Map)['profile'] !=
                                            null &&
                                        (widget.postModel.sender
                                                as Map)['profile'] !=
                                            ''
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl: (widget.postModel.sender
                                              as Map)['profile'],
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                          //'${postModel.sender}',
                                          placeholder: (context, url) {
                                            return const ColoredBox(
                                                color: Colors.white24,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                        '${(widget.postModel.sender as Map)['name']}',
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
                                        timeago
                                            .format(widget.postModel.postDate!),
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
                    widget.postModel.message != null &&
                            widget.postModel.message!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(widget.postModel.message!,
                                style: const TextStyle(fontSize: 19)),
                          )
                        : Container(),
                    const SizedBox(height: 5),
                    (widget.postModel.image != null &&
                            widget.postModel.image!.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: widget.postModel.image!,
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
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero))),
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
                    const Divider(
                      thickness: 2,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('comments')
                          .where('postID', isEqualTo: widget.postModel.postID)
                          .orderBy('timeStamp', descending: true)
                          .snapshots(),
                      builder: (
                        BuildContext context,
                        snapshot,
                      ) {
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          //error
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No Comments'),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //loading
                          return const Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                //postID = data['postID'];
                                return CommentCard(
                                  commentID: data['commentID'],
                                  senderUid: data['sender.uid'],
                                  comment: data['comment'],
                                  senderName: data['sender.name'],
                                  senderImage: data['sender.profile'],
                                  timeStamp: (data['timeStamp'] as Timestamp)
                                      .toDate(),
                                );
                                // _controller!.setLooping(true);
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, bottom: 10, top: 10, right: 10),
                //  height: 65,
                width: double.infinity,
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: comment,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (v) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 5, bottom: 5),
                            hintText: "Add comment ...",
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.black, fontFamily: 'fantasy'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor))),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 45,
                        height: 45,
                        child: FloatingActionButton(
                          onPressed: () async {
                            setState(() {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final ref = FirebaseFirestore.instance
                                  .collection("comments")
                                  .doc();
                              if (comment.text != '') {
                                ref.set({
                                  'comment': comment.text.trim(),
                                  'postID': widget.postModel.postID,
                                  'sender': {
                                    'uid': snapshot!.data()!['uid'],
                                    'name': snapshot!.data()!['username'],
                                    'profile': snapshot!.data()!['profile'],
                                  },
                                  'commentID': ref.id,
                                  'timeStamp': DateTime.now(),
                                }).then((value) {
                                  setState(() {
                                    showSnackBar(
                                        context, "Comment posted successfully");
                                    comment.clear();
                                  });
                                });
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          backgroundColor: kPrimaryColor,
                          elevation: 0,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
