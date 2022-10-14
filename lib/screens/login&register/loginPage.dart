import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:case_store/screens/storePage.dart';
import 'package:case_store/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String screenRoute = "login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              "LOGIN",
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
                          onsubmet: (p0) async {
                            try {
                              var authenticationobject = FirebaseAuth.instance;

                              UserCredential myUser = await authenticationobject
                                  .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("login successfully")));
                              if (myUser != null) {
                                Navigator.pushNamed(
                                    context, StorePage.screenRoute);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("$e")));
                            }
                          },
                          contlr: password,
                          hintText: "Enter your password",
                          scureText: true),
                    ),
                    SizedBox(height: 30),
                    MyButton(
                      color: Colors.black,
                      title: "Login",
                      onPressed: () async {
                        try {
                          var authenticationobject = FirebaseAuth.instance;

                          UserCredential myUser = await authenticationobject
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("login successfully")));
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
                      child: Text("Don't have any account ! Sign Up",
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {},
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
