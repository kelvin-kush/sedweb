//import 'package:sedweb/Screens/Homescreen.dart';
//import 'package:sedweb/Screens/Welcome/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
import 'package:sedweb/Screens/welcome/welcome.dart';

import '../Screens/Home/homescreen.dart';

class AuthController extends GetxController {
  //An instance of authcontoller
  static AuthController instance = Get.find();
  // A variable of our firebase user like email,...
  late Rx<User> _user;

  //for our authentification and navigating to different pages
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

 /* @override
  void onReady() {
    super.onReady();

    _user = Rx<User>(auth.currentUser);
    //whenever things like login changes, the user will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }*/

  _initialScreen(User user) {
    if (user == null) {
      print("login Page");
      //forward user to login  page
      Get.offAll(() => WelcomeScreen());
    } else {
      Get.offAll(() => Homescreen());
      //email: user.email
    }
  }

  Future<void> signout() async {
    await auth.signOut();
    Get.offAll(() => WelcomeScreen());
  }

   login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => Homescreen());
    } on FirebaseAuthException catch (e) {
      // account creation failed
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            e.message ?? 'Error while Logging In',
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  register(String email, password, username, bio) async {
    String res = "Some error Occurred";
    try {
    /* if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||)
         // file != null
         */
          
         //{
        // registering user in auth with email and password
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email,
           password: password);
      print(cred.user!.uid);

      //addiing to  our database
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'bio': bio,
        'followers':[],
        'following' :[],
      });
      Get.offAll(() => Homescreen());
     }
     on FirebaseAuthException catch (e) {
      // account creation failed
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            e.message ?? "Account creation failed",
            style: TextStyle(color: Colors.white),
          ));

     }
  }
  
}
