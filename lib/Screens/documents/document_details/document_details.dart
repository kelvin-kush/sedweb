import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/widgets/comment_card.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/comment_model.dart';
import 'package:sedweb/models/document_model.dart';
import 'package:sedweb/utils/utils.dart';

class DoucumentDetails extends StatefulWidget {
  const DoucumentDetails({Key? key, required this.document}) : super(key: key);
  final DocumentModel document;

  @override
  State<DoucumentDetails> createState() => _DoucumentDetailsState();
}

class _DoucumentDetailsState extends State<DoucumentDetails> {
  final GlobalKey<FormState> _commentFormKKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(widget.document.docType!,
                style: const TextStyle(
                  color: Colors.white,
                ))),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.document.title!,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.document.information!,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Comments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('DocComments')
                        .where('postID', isEqualTo: widget.document.docID)
                        .orderBy('postDate', descending: true)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data.docs.length > 0) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, _index) {
                              CommentModel commentModel = CommentModel.fromMap(
                                  snapshot.data.docs[_index]);
                              return CommentCard(comment: commentModel);
                            }));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('No comments'),
                        );
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
