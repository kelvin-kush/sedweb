import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:sedweb/Screens/Home/profile/edit_profile.dart';
import 'package:sedweb/Screens/Home/profile/followers/followers.dart';
import 'package:sedweb/Screens/Home/profile/following/following.dart';
import 'package:sedweb/Screens/Home/profile/picture_box.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
import 'package:sedweb/Screens/enter_document.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel currentUSer = UserModel();
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data);
                    currentUSer = UserModel.fromMap(snapshot.data!);
                    return Stack(children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
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
                                        imageUrl: currentUSer.profile!,
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
                                currentUSer.name!,
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    currentUSer.bio!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  attributes(
                                      title: 'Followers: ',
                                      value: '${currentUSer.followers!.length}',
                                      onTap: () {
                                        currentUSer.followers!.isNotEmpty
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        FollowersScreen(
                                                            followersUid:
                                                                currentUSer
                                                                    .followers!)))
                                            : () {};
                                      }),
                                  attributes(
                                    title: 'Following: ',
                                    value: '${currentUSer.following!.length}',
                                    onTap: () {
                                      currentUSer.following!.isNotEmpty
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      FollowingScreen(
                                                          followingUid:
                                                              currentUSer
                                                                  .following!)))
                                          : () {};
                                    },
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
                                      .where('senderID',
                                          isEqualTo: currentUSer.id)
                                      // .orderBy('postDate', descending: true)
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data.docs.length > 0) {
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
                                            PostModel myPosts =
                                                PostModel.fromMap(
                                                    snapshot.data.docs[index]);
                                            return PictureBox(
                                              post: myPosts,
                                              user: currentUSer,
                                            );
                                          });
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        child: Center(
                                            child: Text('No posts found')),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 0,
                          child: Card(
                            child: IconButton(
                              tooltip: "Edit Profile",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                              userDetails: snapshot,
                                              currentUser: user!.uid,
                                            )
                                        // const EnterDocument(),
                                        ));
                              },
                              icon: const Icon(Icons.create),
                            ),
                          )),
                      Positioned(
                          top: 80,
                          right: 0,
                          child: Card(
                            child: IconButton(
                              color: Colors.red,
                              tooltip: "Log Out",
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()
                                        // const EnterDocument(),
                                        ),
                                    ((route) => false));
                              },
                              icon: const Icon(Icons.exit_to_app),
                            ),
                          ))
                    ]);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })),
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
