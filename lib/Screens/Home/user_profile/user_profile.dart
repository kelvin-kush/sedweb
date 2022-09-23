import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:sedweb/Screens/Home/profile/followers/followers.dart';
import 'package:sedweb/Screens/Home/profile/following/following.dart';
import 'package:sedweb/Screens/Home/profile/picture_box.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/database/feed_database.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Profile',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: kPrimaryColor,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
                      .snapshots(),
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
                              const Icon(
                                Icons.donut_large,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                userModel.bio!,
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              attributes(
                                  title: 'Followers: ',
                                  value: '${userModel.followers!.length}',
                                  onTap: () {
                                    userModel!.followers!.isNotEmpty
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    FollowersScreen(
                                                        followersUid: userModel!
                                                            .followers!)))
                                        : () {};
                                  }),
                              attributes(
                                title: 'Following: ',
                                value: '${userModel.following!.length}',
                                onTap: () {
                                  userModel!.following!.isNotEmpty
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => FollowingScreen(
                                                  followingUid:
                                                      userModel!.following!)))
                                      : () {};
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Card(
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
                                                builder: ((context) =>
                                                    ChatScreen(
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
                                                child:
                                                    CircularProgressIndicator(
                                                  color: kPrimaryColor,
                                                )),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.mail,
                                                color: kPrimaryColor,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Message',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Card(
                                    child: TextButton(
                                  onPressed: userModel.followers!
                                          .contains(currentUser!.uid)
                                      ? () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userModel!.id)
                                              .update({
                                            'followers': FieldValue.arrayRemove(
                                                [currentUser!.uid])
                                          }).then((value) async {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(currentUser!.uid)
                                                .update({
                                              'following':
                                                  FieldValue.arrayRemove(
                                                      [userModel!.id])
                                            });
                                          });
                                        }
                                      : () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userModel!.id)
                                              .update({
                                            'followers': FieldValue.arrayUnion(
                                                [currentUser!.uid])
                                          }).then((value) async {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(currentUser!.uid)
                                                .update({
                                              'following':
                                                  FieldValue.arrayUnion(
                                                      [userModel!.id])
                                            });
                                          });
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        userModel.followers!
                                                .contains(currentUser!.uid)
                                            ? Icons.person_pin
                                            : Icons.person_add,
                                        color: kPrimaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        userModel.followers!
                                                .contains(currentUser!.uid)
                                            ? 'Following'
                                            : 'Follow',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )),
                              ),
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
                                  .where('senderID', isEqualTo: widget.userId)
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
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemBuilder: (context, index) {
                                        PostModel myPosts = PostModel.fromMap(
                                            snapshot.data.docs[index]);
                                        return PictureBox(
                                          post: myPosts,
                                          user: userModel!,
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

  Widget attributes({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          visualDensity: VisualDensity.compact, padding: EdgeInsets.zero),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: title),
        TextSpan(
            text: value,
            style: const TextStyle(
                color: kPrimaryColor, fontWeight: FontWeight.bold))
      ], style: const TextStyle(fontSize: 17, color: Colors.black))),
    );
  }
}
