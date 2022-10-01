import 'package:sedweb/Screens/Login/Components/background.dart';
import 'package:sedweb/Screens/Login/login_screen.dart';
//import 'package:sedweb/auth_controller.dart';
import 'package:flutter/material.dart';
//import 'package:final_project/Screens/SignUp/signup.dart';
import 'package:sedweb/components/Rounded_button.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:sedweb/components/constraints.dart';
import 'package:sedweb/resources/auth_methods.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController bioController = TextEditingController(text: '');

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  Future signupPage() async {
    setState(() => isLoading = true);
    await AuthController().register(
        context,
        emailController.text.trim(),
        passwordController.text.trim(),
        bioController.text.trim(),
        usernameController.text.trim());
    setState(() => isLoading = false);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Lottie.asset(
              "assets/icons/css.zip",
              height: size.height * 0.3,
            ),
            /*  SvgPicture.asset(
              "assets/icons/learnigs.svg",
              height: size.height * 0.35,
            ),*/
            SizedBox(height: size.height * 0.01),
            SizedBox(height: size.height * 0.02),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ]),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ]),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ]),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ]),
              child: TextField(
                controller: bioController,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Bio",
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            isLoading
                ? CircularProgressIndicator()
                : RoundedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6F35A5)),
                    ),
                    text: "SIGNUP",
                    press: () async => await signupPage(),

                    //AuthController.instance.register(emailController.text.trim(),
                    // passwordController.text.trim());

                    textColor: Colors.black, color: Colors.blue,
                  ),
            Center(
              child: RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                      ),
                      children: [
                    TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => LoginScreen()),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
