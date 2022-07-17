import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/homescreen.dart';
import 'package:sedweb/models/post_model.dart';
import 'package:sedweb/utils/utils.dart';

User? user = FirebaseAuth.instance.currentUser;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
