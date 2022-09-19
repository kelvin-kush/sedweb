import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/profile/followers/components/follower_card.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key, required this.followingUid})
      : super(key: key);
  final List<dynamic>? followingUid;
  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following'),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('uid', whereIn: widget.followingUid)
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
                    scrollDirection: Axis.vertical,
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
