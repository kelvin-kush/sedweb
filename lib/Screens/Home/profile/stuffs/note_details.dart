import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/note_model.dart';

class NoteDetails extends StatefulWidget {
  const NoteDetails({Key? key, required this.note}) : super(key: key);
  final NoteModel note;

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text('Note Details',
                style: TextStyle(
                  color: Colors.white,
                ))),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.note.title,
                      style: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Date : ${DateFormat.yMMMMEEEEd().format(widget.note.noteDate!)}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.note.message!,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )),
        ));
  }
}
