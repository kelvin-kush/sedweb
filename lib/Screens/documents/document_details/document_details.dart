import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoucumentDetails extends StatefulWidget {
  const DoucumentDetails(
      {Key? key, required this.color, required this.documentType})
      : super(key: key);
  final Color color;
  final String documentType;

  @override
  State<DoucumentDetails> createState() => _DoucumentDetailsState();
}

class _DoucumentDetailsState extends State<DoucumentDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Documents')
            .where('docType', isEqualTo: widget.documentType)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: widget.color,
                title: Text(widget.documentType,
                    style: const TextStyle(
                      color: Colors.white,
                    ))),
            drawer: ListView.builder(
                itemCount: snapshot.data,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      "Hi",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                })),
            body: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                return Column(
                  children: const [
                    Text("Title",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Information")
                  ],
                );
              },
            ),
          );
        });
  }
}
