import 'package:flutter/material.dart';
import 'package:sedweb/Screens/documents/components/document_list_card.dart';
import 'package:sedweb/Screens/documents/document_details/document_details.dart';
import 'package:sedweb/data/sedweb_data.dart';

class DocumentHome extends StatelessWidget {
  const DocumentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: kDocumentdata.length,
          itemBuilder: ((context, index) {
            return DocumentListCard(
              color: kDocumentdata[index]["color"] as Color,
              text: '${kDocumentdata[index]["name"]}',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoucumentDetails(
                            color: kDocumentdata[index]["color"] as Color,
                            documentType: '${kDocumentdata[index]["name"]}')));
              },
            );
          }),
        ),
      ),
    ));
  }
}
