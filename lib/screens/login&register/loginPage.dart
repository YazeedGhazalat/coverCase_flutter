import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
import 'package:case_store/screens/login&register/registerPage.dart';
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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 24, 74, 1),
        elevation: 0,
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
                      onsubmet: (p0) async {
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
                      contlr: password,
                      hintText: "Enter your password",
                      scureText: true),
                ),
                SizedBox(height: 30),
                MyButton(
                  fontsize: 15,
                  Fontcolor: Colors.white,
                  color: Color.fromRGBO(4, 24, 74, 1),
                  title: "Login",
                  onPressed: () async {
                    try {
                      var authenticationobject = FirebaseAuth.instance;

                      UserCredential myUser =
                          await authenticationobject.signInWithEmailAndPassword(
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
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                        context, RegisterPage.screenRoute);
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
