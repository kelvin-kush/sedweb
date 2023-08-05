import 'package:sedweb/Screens/Login/Components/background.dart';
import 'package:sedweb/Screens/SignUp/signup.dart';
import 'package:sedweb/components/Rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
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

   @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  Future loginPage() async {
    setState(() => isLoading = true);
    await AuthController().login(
        context, emailController.text.trim(), passwordController.text.trim());
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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Lottie.asset(
              "assets/icons/learningl.zip",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.01),
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
            SizedBox(height: size.height * 0.05),
            isLoading
                ? CircularProgressIndicator()
                : RoundedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6F35A5)),
                    ),
                    text: "LOGIN",

                    press: () async => await loginPage(),
                    // AuthController.instance.login(emailController.text.trim(),
                    // passwordController.text.trim());

                    textColor: Colors.black, color: Colors.blue,
                  ),
            SizedBox(height: size.height * 0.02),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: RichText(
                    text: TextSpan(
                        text: "Don\'t have an account? ",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[500],
                        ),
                        children: const [
                      TextSpan(
                        text: "SignUp",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
