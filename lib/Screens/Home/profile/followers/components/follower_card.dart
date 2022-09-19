import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/homescreen.dart';
import 'package:sedweb/Screens/Home/user_profile/user_profile.dart';

class FollowerCard extends StatefulWidget {
  const FollowerCard(
      {Key? key, required this.name, required this.imageUrl, required this.uid})
      : super(key: key);
  final String name;
  final String imageUrl;
  final String uid;
  @override
  State<FollowerCard> createState() => _FollowerCardState();
}

class _FollowerCardState extends State<FollowerCard> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.uid == user!.uid) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homescreen()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfile(
                        userId: widget.uid,
                      )));
        }
      },
      leading: widget.imageUrl != null
          ? profilePic(
              profileRadius: 17, // const SizedBox(
              image: '${widget.imageUrl}')
          : Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircularProgressIndicator(),
            ),
      title: Text(widget.name),
    );
  }

  Widget profilePic({double? profileRadius, required String image}) {
    return Container(
      height: 34,
      width: 34,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(profileRadius ?? 9),
        child: Container(
          child: CachedNetworkImage(
            imageUrl: image,
            height: 34,
            width: 34,
            fit: BoxFit.cover,
          ),
          decoration: BoxDecoration(
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
