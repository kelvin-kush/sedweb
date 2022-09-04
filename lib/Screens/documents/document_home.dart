import 'package:flutter/material.dart';
import 'package:sedweb/Screens/documents/components/document_list_card.dart';
import 'package:sedweb/Screens/documents/document_details/document_details.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/data/sedweb_data.dart';

class DocumentHome extends StatefulWidget {
  const DocumentHome({Key? key}) : super(key: key);

  @override
  State<DocumentHome> createState() => _DocumentHomeState();
}

class _DocumentHomeState extends State<DocumentHome> {
  int _selectedCard = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            'Course Materials',
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_book_sharp,
                  color: kPrimaryColor,
                ))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: kDocumentdata.length,
              itemBuilder: ((context, index) {
                return DocumentListCard(
                  text: '${kDocumentdata[index]["name"]}',
                  isOpened: _selectedCard == index,
                  onTap: () {
                    setState(() {
                      if (_selectedCard == index) {
                        _selectedCard = 10000;
                      } else {
                        _selectedCard = index;
                      }
                    });
                  },
                );
              }),
            ),
          ),
        ));
  }
}
