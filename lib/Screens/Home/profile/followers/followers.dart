import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/profile/followers/components/follower_card.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key, required this.followersUid})
      : super(key: key);
  final List<dynamic>? followersUid;
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('uid', whereIn: widget.followersUid)
                .get(),
            builder: (
              BuildContext context,
              snapshot,
            ) {
              if (!snapshot.hasData) {
                return Container();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 30),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return ListView.builder(

                    //  shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      //totalPost = snapshot.data!.docs.length;
                      return FollowerCard(
                        uid: data['uid'],
                        imageUrl: data['profile'],
                        name: data['username'],
                      );
                    });
              }
            }),
      ),
    );
  }
}
