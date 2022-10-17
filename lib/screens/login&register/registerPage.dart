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
  bool scureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(4, 24, 74, 1),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          color: Color.fromRGBO(4, 24, 74, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: Container(
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
                height: 150,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    )),
                height: 650,
                width: 400,
                child: Column(children: [
                  SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: MyTextBox(
                        textInputAction: TextInputAction.next,
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
                      textInputAction: TextInputAction.done,
                      label: "Password",
                      iconButton: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          scureText ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            scureText = !scureText;
                          });
                        },
                      ),
                      scureText: scureText,
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid Email or Used before")));
                        }
                      },
                      contlr: password,
                      hintText: "Enter your password",
                    ),
                  ),
                  SizedBox(height: 30),
                  MyButton(
                    fontsize: 15,
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invalid Email or Used before")));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
