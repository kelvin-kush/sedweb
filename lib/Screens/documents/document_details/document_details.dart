import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/widgets/comment_card.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/comment_model.dart';
import 'package:sedweb/models/document_model.dart';
import 'package:sedweb/utils/utils.dart';

class DoucumentDetails extends StatefulWidget {
  const DoucumentDetails(
      {Key? key, required this.color, required this.documentType, this.index})
      : super(key: key);
  final Color color;
  final String documentType;
  final int? index;

  @override
  State<DoucumentDetails> createState() => _DoucumentDetailsState();
}

class _DoucumentDetailsState extends State<DoucumentDetails> {
  final GlobalKey<FormState> _commentFormKKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  bool isLoading = false;
  List<DocumentModel> allDocs = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Documents')
            .where('docType', isEqualTo: widget.documentType)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.docs.length; i++) {
              allDocs.add(DocumentModel.fromMap(snapshot.data.docs[i]));
            }
            allDocs = allDocs.reversed.toList();
          }
          return Scaffold(
            appBar: AppBar(
                backgroundColor: widget.color,
                title: Text(widget.documentType,
                    style: const TextStyle(
                      color: Colors.white,
                    ))),
            drawer: allDocs.isNotEmpty
                ? SafeArea(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      width: width * 0.9,
                      child: ListView.builder(
                          itemCount: allDocs.length,
                          itemBuilder: ((context, _index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DoucumentDetails(
                                              color: widget.color,
                                              documentType: widget.documentType,
                                              index: _index,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: index == _index
                                        ? widget.color.withOpacity(0.5)
                                        : Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: index == _index
                                          ? widget.color
                                          : Colors.black45,
                                    ))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                  child: Text(
                                    allDocs[_index].title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  )
                : null,
            body: allDocs.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(allDocs[index].title!,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            allDocs[index].information!,
                            style: const TextStyle(fontSize: 17),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Comments',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.color),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('DocComments')
                                  .where('postID',
                                      isEqualTo: allDocs[index].docID)
                                  .orderBy('postDate', descending: true)
                                  .get(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data.docs.length > 0) {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: ((context, _index) {
                                        CommentModel commentModel =
                                            CommentModel.fromMap(
                                                snapshot.data.docs[_index]);

                                        print(commentModel.sender);
                                        return CommentCard(
                                            comment: commentModel);
                                      }));
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: widget.color,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('No comments'),
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),

                          // ListView.builder(
                          //     itemCount: allDocs.length,
                          //     itemBuilder: ((context, _index) {
                          //       return GestureDetector(
                          //         onTap: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       DoucumentDetails(
                          //                         color: widget.color,
                          //                         documentType:
                          //                             widget.documentType,
                          //                         index: _index,
                          //                       )));
                          //         },
                          //       );
                          //     }))

                        ],
                      ),
                    ),
                  )
                : Container(),
          );
        });
  }
}
