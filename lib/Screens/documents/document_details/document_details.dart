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
                const Text(
                  'Add comments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _commentFormKKey,
                    child: TextFormField(
                      maxLines: 4,
                      maxLength: 150,
                      controller: commentController,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Feild is empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Add comment here",
                        enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              User? currentUser =
                                  FirebaseAuth.instance.currentUser;
                              setState(() {
                                isLoading = true;
                              });
                              if (_commentFormKKey.currentState!.validate()) {
                                _commentFormKKey.currentState!.save();
                                try {
                                  final ref = firebaseFirestore
                                      .collection('DocComments')
                                      .doc();
                                  CommentModel doc = CommentModel(
                                      commentId: ref.id,
                                      comment: commentController.text.trim(),
                                      sender: currentUser != null
                                          ? currentUser.uid
                                          : '',
                                      postDate: DateTime.now(),
                                      postID: widget.document.docID);
                                  ref.set(doc.toMap()).then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackBar(
                                        context, 'Comment added successfully');
                                    commentController.clear();
                                  });
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });

                                  showSnackBar(context, 'Comment failed');
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Comment',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
