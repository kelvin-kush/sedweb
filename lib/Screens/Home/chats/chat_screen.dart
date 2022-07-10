import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sedweb/Screens/Home/chats/components/message_card.dart';
import 'package:sedweb/constraints.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sedweb/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();
  ChatProvider chatProvider = ChatProvider();
  final _database = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker _imagePicker = ImagePicker();
  File? profileFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: const Padding(
          padding:  EdgeInsets.all(8.0),
          child:  CircleAvatar(
            child: Icon(Icons.person),
            radius: 10,
          ),
        ),
        title: Text(widget.username,style:const TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          /////////////////////////////////////////////////////
          //////////////////Messages screen //////////////////

          Expanded(
            child: StreamBuilder(
                stream: _database
                    .child('chatRoom/')
                    .orderByKey()
                    .onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    final data = snapshot.data!.snapshot.children
                        .toList()
                        .reversed
                        .toList();
                    return GroupedListView<DataSnapshot, String>(
                      elements: data,
                      groupBy: (element) =>
                          (DateFormat.yMMMMEEEEd().format(DateTime.now()) ==
                                  DateFormat.yMMMMEEEEd().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        element.child('sendDate').value as int),
                                  ))
                              ? "Today"
                              : DateFormat.yMMMMEEEEd().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      element.child('sendDate').value as int),
                                ),
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      order: GroupedListOrder.ASC,
                      useStickyGroupSeparators: true,
                      stickyHeaderBackgroundColor: Colors.transparent,
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      groupSeparatorBuilder: (String value) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              value,
                              // textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      itemBuilder: (c, message) {
                        return MessageCard(
                          id: message.child('id').value.toString(),
                          isSender:
                              message.child('messageSender').value == user!.uid,
                          text:
                              message.child('messageContent').value.toString(),
                          time: DateTime.fromMillisecondsSinceEpoch(
                              message.child('sendDate').value as int),
                          imageUrl: message.child('imageUrl').value.toString(),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          ////////////////////////////////////////////////////
          /////////// Typing Area /////////////////////////
          Container(
            padding:
                const EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 10),
            //  height: 65,
            width: double.infinity,
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
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        hintText: "Write message ...",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(
                            color: Colors.black, fontFamily: 'fantasy'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: const Icon(
                                              Icons.camera,
                                              color: kPrimaryColor,
                                            ),
                                            title: const Text('Camera'),
                                            onTap: () {
                                              _getChatFile(ImageSource.camera);
                                            },
                                          ),
                                          const Divider(
                                            color: kPrimaryColor,
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.image,
                                              color: kPrimaryColor,
                                            ),
                                            title: const Text('Gallery'),
                                            onTap: () {
                                              _getChatFile(ImageSource.gallery);
                                            },
                                          ),
                                          const Divider(
                                            color: kPrimaryColor,
                                          ),
                                          const ListTile(
                                              leading: Icon(
                                                Icons.file_open_rounded,
                                                color: kPrimaryColor,
                                              ),
                                              title: Text('Documents')),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              color: kPrimaryColor,
                              size: 25,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.black45)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: kPrimaryColor))),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 45,
                    height: 45,
                    child: FloatingActionButton(
                            onPressed: () async {
                              setState(() {});
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
        ],
      ),
    );
  }

  Future _getChatFile(ImageSource source) async {
    try {
      profileFile = File(
        await _imagePicker.pickImage(source: source).then(
              (pickedFile) => pickedFile!.path,
            ),
      );
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => ViewPickedPicture(
      //               chatFile: profileFile!,
      //               user: user!.uid,
      //             ))));
    } catch (e) {
      setState(() {
        // Fluttertoast.showToast(msg: "Image upload failed");
      });
    }
    // try {
    //
  }
}
