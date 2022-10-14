import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:case_store/screens/login&register/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../storePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String screenRoute = "register";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool visible = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          Positioned(
            top: 150,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  )),
              height: 700,
              width: 400,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: MyTextBox(
                          textType: TextInputType.emailAddress,
                          contlr: email,
                          hintText: "Enter your email",
                          scureText: false),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: MyTextBox(
                          contlr: password,
                          hintText: "Enter your password",
                          scureText: true),
                    ),
                    SizedBox(height: 30),
                    MyButton(
                      color: Colors.black,
                      title: "Register",
                      onPressed: () async {
                        try {
                          var authenticationobject = FirebaseAuth.instance;

                          UserCredential myUser = await authenticationobject
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("added successfully")));
                          if (myUser != null) {
                            Navigator.pushNamed(context, StorePage.screenRoute);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("$e")));
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    TextButton(
                      child: Text("Already have an account ! login",
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        Navigator.pushNamed(context, LoginPage.screenRoute);
                      },
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
