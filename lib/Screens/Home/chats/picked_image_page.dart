import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sedweb/Screens/Home/chats/chat_screen.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/models/chart_message.dart';
import 'package:sedweb/models/user_model.dart';
import 'package:sedweb/provider/chat_provider.dart';

class ViewPickedPicture extends StatefulWidget {
  const ViewPickedPicture(
      {Key? key,
      required this.chatFile,
      required this.user,
      required this.groupChatId,
      required this.sender})
      : super(key: key);
  final File chatFile;
  final UserModel user;
  final String sender;
  final String groupChatId;

  @override
  State<ViewPickedPicture> createState() => _ViewPickedPictureState();
}

class _ViewPickedPictureState extends State<ViewPickedPicture> {
  TextEditingController message = TextEditingController();
  ChatProvider chatProvider = ChatProvider();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(widget.chatFile),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              ////////////////// Chat TextFeild ////////////////////////
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 20, top: 10, right: 10),
                         color: Colors.grey[200],
                  width: double.infinity,
                  // decoration: BoxDecoration(color: Colors.transparent),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: message,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (v) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              contentPadding:  EdgeInsets.only(
                                  left: 20, top: 5, bottom: 5),
                              hintText: "Send message ...",
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle:  TextStyle(
                                  color: Colors.black, fontFamily: 'fantasy'),
                              border: OutlineInputBorder(
                                  borderSide:
                                       BorderSide(color: Colors.black45)),
                              focusedBorder:  OutlineInputBorder(
                                  borderSide:
                                       BorderSide(color: kPrimaryColor))),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: 48,
                          height: 48,
                          child: FloatingActionButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                uploadFile(widget.chatFile).then((value) {
                                  chatProvider
                                      .addImageMessage(
                                          ChatMessage(
                                              message: message.text,
                                              sender: widget.sender,
                                              sendDate: DateTime.now(),
                                              fileUrl: value,
                                              messageType: 'image'),
                                          widget.groupChatId)
                                      .onError((error, stackTrace) {
                                    Navigator.pop(context);
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => ChatScreen(
                                                groupChatId: widget.groupChatId,
                                                user: widget.user,
                                              ))));
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                // Fluttertoast.showToast(
                                //     msg: "Failed to send file");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            backgroundColor: kPrimaryColor,
                            elevation: 0,
                          )),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadFile(File _image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${path.basename(_image.path)}}');
    try {
      UploadTask uploadTask = ref.putFile(_image);
      await uploadTask.whenComplete(() => print('File Uploaded'));
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String? returnURL;
    await ref.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
      // NickNameAvatar.updateURl = fileURL;
    });
    return returnURL!;
  }
}
