import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:sedweb/Screens/Home/profile/picture_box.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/models/user_model.dart';

import '../chats/chat_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _database = FirebaseDatabase.instance.ref();
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool _isCreatingChat = false;
  String groupChatId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    UserModel? userModel;
                    if (snapshot.hasData) {
                      userModel = UserModel.fromMap(snapshot.data);
                      return Column(
                        children: [
                           Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white),
                                  color: Colors.white24,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                        imageUrl: userModel.profile!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                        //'${postModel.sender}',
                                        placeholder: (context, url) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, error, url) {
                                          return const CircleAvatar(
                                            child: Icon(Icons.person),
                                            radius: 50,
                                          );
                                        })),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                userModel.name!,
                                style: const TextStyle(fontSize: 19),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.donut_large,size: 20,),
                                  SizedBox(width: 5,),
                                  Text(
                                    userModel.bio!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              attributes('Followers: ', '1.5k'),
                              attributes('Following: ', '1k'),
                              Card(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isCreatingChat = true;
                                    });
                                    try {
                                      if (currentUser!.uid
                                              .compareTo(widget.userId) ==
                                          -1) {
                                        groupChatId =
                                            "${currentUser!.uid}-${widget.userId}";
                                      } else {
                                        groupChatId =
                                            "${widget.userId}-${currentUser!.uid}";
                                      }
                                      final chatroom = _database.child(
                                          '/chatRoom/$groupChatId/members');
                                      chatroom.set({
                                        widget.userId: true,
                                        currentUser!.uid: true,
                                      });
                                      final chatroomUser1 = _database.child(
                                          '/chatRoomUsers/${widget.userId}/$groupChatId');
                                      chatroomUser1.set({
                                        'person': currentUser!.uid,
                                      });
                                      final chatroomUser2 = _database.child(
                                          '/chatRoomUsers/${currentUser!.uid}/$groupChatId');
                                      chatroomUser2.set({
                                        'person': widget.userId,
                                      });
                                      setState(() {
                                        _isCreatingChat = false;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => ChatScreen(
                                                    user: userModel!,
                                                    groupChatId: groupChatId,
                                                  ))));
                                    } catch (e) {
                                      setState(() {
                                        _isCreatingChat = false;
                                      });
                                    }
                                  },
                                  child: _isCreatingChat
                                      ? const Center(
                                          child: SizedBox(
                                              height: 29,
                                              width: 29,
                                              child: CircularProgressIndicator(
                                                color: kPrimaryColor,
                                              )),
                                        )
                                      : const Icon(Icons.mail),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Posts',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection('Posts')
                                  .where('sender.uid', isEqualTo: widget.userId)
                                  // .orderBy('postDate', descending: true)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  // print(snapshot.data.docs[0]["postID"]);
                                  return GridView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemBuilder: (context, index) {
                                        PostModel myPosts = PostModel.fromMap(
                                            snapshot.data.docs[index]);
                                        return PictureBox(
                                          post: myPosts,
                                        );
                                      });
                                } else {
                                  return const SizedBox(
                                    child:
                                        Center(child: Text('No posts found')),
                                  );
                                }
                              }),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),
        ),
      ),
    );
  }

  Widget attributes(String title, String value) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: title),
      TextSpan(
          text: value,
          style: const TextStyle(
              color: kPrimaryColor, fontWeight: FontWeight.bold))
    ], style: const TextStyle(fontSize: 17, color: Colors.black)));
  }
}
