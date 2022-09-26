import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sedweb/Screens/Home/profile/picture_box.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/models/user_model.dart';

User? user = FirebaseAuth.instance.currentUser;

class PostStuff extends StatelessWidget {
  const PostStuff({Key? key, required this.currentUSer}) : super(key: key);
  final UserModel currentUSer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .where('senderID', isEqualTo: currentUSer.id)
            // .orderBy('postDate', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs.length > 0) {
            // print(snapshot.data.docs[0]["postID"]);
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  PostModel myPosts =
                      PostModel.fromMap(snapshot.data.docs[index]);
                  return PictureBox(
                    post: myPosts,
                    user: currentUSer,
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
              child: Center(child: Text('No posts found')),
            );
          }
        });
  }
}
