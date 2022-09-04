import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/documents/document_details/document_details.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/document_model.dart';

class DocumentListCard extends StatelessWidget {
  const DocumentListCard(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.isOpened})
      : super(key: key);
  final String text;
  final bool isOpened;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            color: isOpened ? kPrimaryColor.withOpacity(0.6) : Colors.grey[100],
            elevation: 3,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(
                  child: Text(
                text,
                style: TextStyle(
                    color: isOpened ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
            ),
          ),
        ),
        isOpened
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Documents')
                    .where('docType', isEqualTo: text)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, _index) {
                          final _document =
                              DocumentModel.fromMap(snapshot.data.docs[_index]);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoucumentDetails(
                                            document: _document,
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.0),
                                child: Text(
                                  _document.title!.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          );
                        }));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'No Document found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                })
            : Container(),
      ],
    );
  }
}
