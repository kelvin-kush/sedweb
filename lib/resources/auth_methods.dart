import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
import 'package:sedweb/Screens/welcome/welcome.dart';
import 'package:sedweb/utils/utils.dart';

import '../Screens/Home/homescreen.dart';

class AuthController {
  //An instance of authcontoller
  AuthController();
  // A variable of our firebase user like email,...

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

  _initialScreen(BuildContext context, User? user) {
    if (user == null) {
      //forward user to login  page
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    }
  }

  Future<void> signout(BuildContext context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false);
  }

  login(BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()),
          ((route) => false));

    } on FirebaseAuthException catch (e) {
      // account creation failed
      showSnackBar(
        context,
        e.message ?? 'Error while Logging In',
      );
    }
  }

  register(BuildContext context, String email, password, bio, username) async {
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
          email: email, password: password);
      //addiing to  our database
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'bio': bio,
        'profile': '',
        'followers': [],
        'following': [],
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } on FirebaseAuthException catch (e) {
      // account creation failed
      showSnackBar(
        context,
        e.message ?? 'Account creation failed',
      );
    }
  }
}
