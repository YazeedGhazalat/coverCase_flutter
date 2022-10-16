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
        elevation: 0,
        backgroundColor: Color.fromRGBO(4, 24, 74, 1),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(4, 24, 74, 1),
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
              child: Column(children: [
                SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyTextBox(
                      label: "Email",
                      textType: TextInputType.emailAddress,
                      contlr: email,
                      hintText: "Enter your email",
                      scureText: false),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyTextBox(
                    label: "Password",
                    contlr: password,
                    hintText: "Enter your password",
                    scureText: true,
                    onsubmet: (p0) async {
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
                ),
                SizedBox(height: 30),
                MyButton(
                  fontsize: 20,
                  Fontcolor: Colors.white,
                  color: Color.fromRGBO(4, 24, 74, 1),
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
                  child: Text("Already have an account ? login",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                        context, LoginPage.screenRoute);
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
