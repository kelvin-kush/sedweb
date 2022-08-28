import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/document_model.dart';

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
                                    allDocs[widget.index ?? 0].title!,
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
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            allDocs[index].information!,
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          );
        });
  }
}
