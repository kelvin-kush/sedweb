import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/comment_model.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key, required this.comment}) : super(key: key);
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(comment.sender)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserModel _userModel = UserModel.fromMap(snapshot.data);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                        color: Colors.white24,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                              imageUrl: _userModel.profile!,
                              fit: BoxFit.cover,
                              width: 30,
                              height: 30,
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
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userModel.name!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          timeago.format(comment.postDate!),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  // COmment of person
                  Text(comment.comment!)
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
