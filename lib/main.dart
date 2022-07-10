import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sedweb/Screens/Home/homescreen.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
import 'package:sedweb/Screens/SignUp/signup.dart';
import 'package:sedweb/Screens/welcome/welcome.dart';
import 'package:sedweb/resources/auth_methods.dart';
import 'package:sedweb/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyALOc_iVXTs8_ogJl2Gx2SV6LZ0T9A8wLE",
          appId: "1:212207593132:web:389a951416e776977fe109",
          messagingSenderId: "212207593132",
          projectId: "sedweb-34b77",
          storageBucket: "sedweb-34b77.appspot.com"),
    );
  }
  // await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

      home: Homescreen(),
    );
  }
}
