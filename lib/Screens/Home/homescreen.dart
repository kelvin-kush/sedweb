import 'package:flutter/cupertino.dart';
import 'package:sedweb/Screens/Login/Components/background.dart';
import 'package:sedweb/components/Rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/constraints.dart';
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

  // late PageController pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   pageController = PageController();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   pageController.dispose();
  // }

  // void navigationTapped(int page) {
  //   pageController.jumpToPage(page);
  // }

  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenItems[_page],

      /* Center(
        child: Text(_firebaseAuth.currentUser!.email ?? ''),
      ),*/
      /*  RoundedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF6F35A5)),
            ),
            text: "SIGN OUT",
            press: () {
              AuthController.instance.signout();
            },
            textColor: Colors.black, color: Colors.blue,
          ),*/
      bottomNavigationBar: BottomNavigationBar(
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
              Icons.add_circle,
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
