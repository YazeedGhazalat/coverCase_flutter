import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:case_store/screens/storePage.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.black,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                      )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Divider(
                          height: 25,
                        ),
                        Text(
                          "email",
                          style: TextStyle(fontSize: 18),
                        ),
                        MyTextBox(
                            textType: TextInputType.emailAddress,
                            contlr: email,
                            hintText: "Enter your email",
                            scureText: false),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "password",
                          style: TextStyle(fontSize: 18),
                        ),
                        MyTextBox(
                            contlr: password,
                            hintText: "Enter your password",
                            scureText: true),
                        SizedBox(height: 30),
                        MyButton(
                          color: Colors.black,
                          title: "Login",
                          onPressed: () async {
                            try {
                              var authenticationobject = FirebaseAuth.instance;

                              UserCredential myUser = await authenticationobject
                                  .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("added successfully")));
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
