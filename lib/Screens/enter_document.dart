import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/data/sedweb_data.dart';
import 'package:sedweb/models/document_model.dart';
import 'package:sedweb/utils/utils.dart';

class EnterDocument extends StatefulWidget {
  const EnterDocument({Key? key}) : super(key: key);

  @override
  State<EnterDocument> createState() => _EnterDocumentState();
}

class _EnterDocumentState extends State<EnterDocument> {
  TextEditingController titleController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  String? documentType;
  List<String> documenTypeList = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocumentTypes();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 30,
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter document title",
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  maxLines: 15,
                  controller: infoController,
                  decoration: const InputDecoration(
                    hintText: "Enter document informationIs",
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                    hint: const Text(
                      "Select document type",
                    ),
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey[400]),
                    isExpanded: true,
                    items: documenTypeList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (val) {
                      documentType = val;
                    }),
                const SizedBox(
                  height: 40,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                final ref = firebaseFirestore
                                    .collection('Documents')
                                    .doc();
                                DocumentModel doc = DocumentModel(
                                    title: titleController.text,
                                    information: infoController.text,
                                    docID: ref.id,
                                    docType: documentType);
                                ref.set(doc.toMap()).then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showSnackBar(
                                      context, 'Document posted successful');
                                  titleController.clear();
                                  infoController.clear();
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });

                                showSnackBar(context, 'Post upload failed');
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Add Document',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDocumentTypes() {
    kDocumentdata.forEach((element) {
      documenTypeList.add('${element["name"]}');
    });
  }
}
