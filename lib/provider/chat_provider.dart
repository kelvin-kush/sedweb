import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sedweb/models/chart_message.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider();

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final database = FirebaseDatabase.instance.ref();
  final User? auth = FirebaseAuth.instance.currentUser;

  UploadTask uploadImageFile(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> addMessage(ChatMessage message) async {
    var chatroom = database.child('/chatRoom/${message.messageSender}');
    chatroom = chatroom.push();
    chatroom.set({
      'id': chatroom.key,
      'messageContent': message.messageContent,
      'messageSender': message.messageSender,
      'sendDate': message.sendDate.millisecondsSinceEpoch,
    });
  }

  Future<void> addImageMessage(ChatMessage message) async {
    var chatroom = database.child('/chatRoom/${message.messageSender}');
    chatroom = chatroom.push();
    chatroom.set({
      'id': chatroom.key,
      'messageContent': message.messageContent,
      'messageSender': message.messageSender,
      'sendDate': message.sendDate.millisecondsSinceEpoch,
      'imageUrl': message.imageUrl,
    });
  }
}
