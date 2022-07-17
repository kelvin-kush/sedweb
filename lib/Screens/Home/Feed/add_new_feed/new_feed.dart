import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/utils/utils.dart';

class AddNewFeed extends StatefulWidget {
  const AddNewFeed({Key? key}) : super(key: key);

  @override
  State<AddNewFeed> createState() => _AddNewFeedState();
}

class _AddNewFeedState extends State<AddNewFeed> {
  TextEditingController controller = TextEditingController();
  List<File> chosenPictures = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new feed'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              maxLines: 6,
              controller: controller,
              decoration: InputDecoration(
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.white,
                  hintText: 'Share your ideas'),
            ),
            chosenPictures.isNotEmpty
                ? Container(
                    height: 140,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: chosenPictures.length,
                        itemBuilder: ((context, index) {
                          return pictureBox(
                              file: chosenPictures[index],
                              onPressed: () {
                                setState(() {
                                  chosenPictures.removeAt(index);
                                });
                              });
                        })),
                  )
                : Container(),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF666666), width: 0.5))),
              child: ListTile(
                onTap: () async {
                  try {
                    File picture = await pickImage(ImageSource.camera);
                    if (picture.path.isNotEmpty) {
                      chosenPictures.add(picture);
                    }

                    setState(() {});
                    print(picture.path);
                  } catch (e) {
                    showSnackBar(context, 'Error in picking image');
                  }
                },
                leading: const Icon(
                  Icons.camera,
                  color: Colors.grey,
                ),
                title: const Text('Camera'),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFF666666), width: 0.5))),
              child: ListTile(
                onTap: () async {
                  try {
                    File picture = await pickImage(ImageSource.gallery);
                    if (picture.path.isNotEmpty) {
                      chosenPictures.add(picture);
                    }

                    setState(() {});
                    print(picture.path);
                  } catch (e) {
                    showSnackBar(context, 'Error in picking image');
                  }
                },
                leading: const Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
                title: const Text('Picture/Video'),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    'Post',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor, primary: Colors.white),
              ),
            )
          ]),
        ),
      )),
    );
  }

  Widget pictureBox({required File file, required VoidCallback onPressed}) {
    return Card(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              right: -5,
              top: -5,
              child: SizedBox(
                height: 25,
                width: 25,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                  ),
                  onPressed: onPressed,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
