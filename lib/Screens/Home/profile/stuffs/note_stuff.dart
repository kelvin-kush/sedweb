import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/profile/stuffs/note_details.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/note_model.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:sedweb/utils/utils.dart';

User? user = FirebaseAuth.instance.currentUser;

class NoteStuff extends StatelessWidget {
  const NoteStuff({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('Notes')
            .where('senderID', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.docs.length > 0) {
            // print(snapshot.data.docs[0]["postID"]);
            return GridView.builder(
                itemCount: snapshot.data!.docs.length + 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index < snapshot.data!.docs.length) {
                    NoteModel note =
                        NoteModel.fromMap(snapshot.data.docs[index]);
                    return NoteCard(
                      note: note,
                    );
                  } else {
                    return AddNote(
                      userID: userId,
                    );
                  }
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          } else {
            return SizedBox(
              child: Center(
                  child: AddNote(
                userID: userId,
              )),
            );
          }
        });
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => NoteDetails(note: note))));
      },
      child: Card(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/note1.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 25, left: 8, right: 8, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    note.message!,
                    maxLines: 5,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // const Positioned(
            //     right: 5,
            //     top: 5,
            //     child: Icon(
            //       Icons.edit,
            //       size: 20,
            //       color: Color.fromARGB(255, 43, 90, 129),
            //     )),
          ],
        ),
      ),
    );
  }
}

class AddNote extends StatefulWidget {
  const AddNote({Key? key, required this.userID}) : super(key: key);
  final String userID;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> _addFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width * 0.3,
        height: width * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 192, 192, 192), width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Add Note'),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          content: Form(
                            key: _addFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  validator: ((value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Feild should not be empty';
                                    }
                                    return null;
                                  }),
                                  decoration: InputDecoration(
                                    label: const Text('Title'),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  minLines: 1,
                                  maxLines: 7,
                                  controller: detailsController,
                                  validator: ((value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Feild should not be empty';
                                    }
                                    return null;
                                  }),
                                  decoration: InputDecoration(
                                      label: const Text('Note Details'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: kPrimaryColor),
                                        )
                                      : TextButton(
                                          onPressed: () {
                                            if (_addFormKey.currentState!
                                                .validate()) {
                                              _addFormKey.currentState!.save();
                                              uploadNote(
                                                  context,
                                                  NoteModel(
                                                      senderID: widget.userID,
                                                      title:
                                                          titleController.text,
                                                      message: detailsController
                                                          .text,
                                                      noteDate:
                                                          DateTime.now()));
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: kPrimaryColor,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'SAVE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Icon(Icons.add, color: Colors.grey))),
      ),
    );
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> uploadNote(BuildContext context, NoteModel _note) async {
    try {
      final ref = firebaseFirestore.collection('Notes').doc();
      _note.noteID = ref.id;
      ref.set(_note.toMap()).then((value) {
        setState(() {
          isLoading = false;
        });

        showSnackBar(context, 'Note added successfully');
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showSnackBar(context, 'Note upload failed');
    }
  }
}
