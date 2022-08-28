import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:sedweb/Screens/Home/profile/picture_box.dart';
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          currentUSer = UserModel.fromMap(snapshot.data!);
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
                                  const Icon(Icons.donut_large,size: 20,),
                                 const SizedBox(width: 5,),
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
                                  attributes('Followers: ', '1.5k'),
                                  attributes('Following: ', '1k')
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
                                      .where('sender.uid',
                                          isEqualTo: currentUSer.id)
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
                                            PostModel myPosts =
                                                PostModel.fromMap(
                                                    snapshot.data.docs[index]);
                                            return PictureBox(
                                              post: myPosts,
                                            );
                                          });
                                    } else {
                                      return const SizedBox(
                                        child: Center(
                                            child: Text('No posts found')),
                                      );
                                    }
                                  }),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 100,
                            child:  Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Card(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EnterDocument()));
                      },
                      icon: const Icon(Icons.create),
                    ),
                  ))
            ],
          ),
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
