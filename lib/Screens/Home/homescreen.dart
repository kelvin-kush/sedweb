import 'package:flutter/cupertino.dart';
import 'package:sedweb/Screens/Home/Feed/feed.dart';
import 'package:sedweb/Screens/Home/articles/articles_tab.dart';
import 'package:sedweb/Screens/Home/chats/chat.dart';
import 'package:sedweb/Screens/Home/profile/profile_screen.dart';
import 'package:sedweb/Screens/documents/document_home.dart';
import 'package:sedweb/components/Rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/resources/auth_methods.dart';
import 'package:sedweb/utils/colors.dart';
import 'package:sedweb/utils/global_variables.dart';

class Homescreen extends StatefulWidget {
  Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  int _page = 0;

  List<Widget> homeScreenItems = const [
    Feed(),
    DocumentHome(),
    ArticlesTab(),
    Chats(),
    ProfileScreen(),
    //PostScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: homeScreenItems.elementAt(_page)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? Colors.orange : primaryColor,
            ),
            label: '',
            backgroundColor: kPrimaryColor,
          ),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              color: _page == 1 ? Colors.orange : primaryColor,
            ),
            label: '',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
              color: _page == 2 ? Colors.orange : primaryColor,
            ),
            label: '',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              color: _page == 3 ? Colors.orange : primaryColor,
            ),
            label: '',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? Colors.orange : primaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
