import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/homescreen.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
import 'package:sedweb/Screens/welcome/welcome.dart';
import 'package:sedweb/components/constraints.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp();
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sedweb',

      //  theme: ThemeData.dark()
      //   .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      //  home: ResponsiveLayout(
      //  webScreenLayout: WebScreenLayout(),
      //  mobileScreenLayout: MobileScreenLayout()),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
      )),
     
      home: isLoggedIn ? Homescreen() : const LoginScreen(),
    );
  }
}
