import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:sedweb/utils/utils.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {Key? key, required this.userDetails, required this.currentUser})
      : super(key: key);
  final dynamic userDetails;
  final String currentUser;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel currentUSer = UserModel();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.currentUser)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                currentUSer = UserModel.fromMap(snapshot.data!);
                return SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white),
                                color: Colors.white24,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl: currentUSer.profile!,
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                        //'${postModel.sender}',
                                        placeholder: (context, url) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, error, url) {
                                          return const CircleAvatar(
                                            child: Icon(Icons.person),
                                            radius: 50,
                                          );
                                        }),
                                    _isLoading
                                        ? const Positioned(
                                            top: 30,
                                            left: 30,
                                            right: 30,
                                            bottom: 30,
                                            child: CircularProgressIndicator(
                                                color: kPrimaryColor),
                                          )
                                        : Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              child: TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  try {
                                                    File picture =
                                                        await pickImage(
                                                            ImageSource
                                                                .gallery);
                                                    if (picture
                                                        .path.isNotEmpty) {
                                                      uploadImage(
                                                              context, picture)
                                                          .then((value) {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(widget
                                                                .currentUser)
                                                            .update({
                                                          'profile': value
                                                        });
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                      });
                                                    }
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    print(picture.path);
                                                  } catch (e) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    showSnackBar(context,
                                                        'Error in picking image');
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Username',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: currentUSer.name,
                                  onFieldSubmitted: (val) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.currentUser)
                                        .update({'name': val}).then((value) {
                                      showSnackBar(context, 'user name updated');
                                    }).onError((error, stackTrace) {
                                      showSnackBar(
                                          context, 'Failed to update user name');
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Bio',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: currentUSer.bio,
                                  onFieldSubmitted: (val) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.currentUser)
                                        .update({'bio': val}).then((value) {
                                      showSnackBar(context, 'bio updated');
                                    }).onError((error, stackTrace) {
                                      showSnackBar(
                                          context, 'Failed to update bio');
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              } else {
                return const Center(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  )),
                );
              }
            }),
      ),
    );
  }

  Future<String> uploadImage(BuildContext context, File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';
    try {
      final ref = storage.ref(destination).child('posts/');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      showSnackBar(context, 'Couldn\'t upload image');
      rethrow;
    }
  }
}
