import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/utils/colors.dart';
import 'package:sedweb/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  File file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  File file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    /* return _file == null
        ? Center(
            child: IconButton(
                icon: Icon(Icons.upload),
                onPressed: () => _selectImage(context)),
          )
        :
        */
    //final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileSearchColor,
          leading:
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
          title: const Text('Post to'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('assets/images/ove2.jpg')),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Share your ideas...',
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/ove2.jpg'),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter)),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
            Center(
              child: IconButton(
                  icon: Icon(Icons.upload),
                  onPressed: () => _selectImage(context)),
            ),
          ],
        ));
  }
}
