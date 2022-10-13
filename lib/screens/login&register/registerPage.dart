import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
    return AlertDialog(
        content: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text("Welcome to our app"),
            ),
            Divider(
              height: 25,
            ),
            Text("email"),
            MyTextBox(
                textType: TextInputType.emailAddress,
                contlr: email,
                hintText: "Enter your email",
                scureText: false),
            SizedBox(
              height: 30,
            ),
            Text("password"),
            MyTextBox(
                contlr: password,
                hintText: "Enter your password",
                scureText: true),
            Divider(height: 25),
            MyButton(
              color: Colors.green[800]!,
              title: "Sign up",
              onPressed: () async {
                try {
                  var authenticationobject = FirebaseAuth.instance;

                  UserCredential myUser =
                      await authenticationobject.createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                  if (myUser != null) {
                    Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("added successfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$e")));
                }
              },
            ),
          ]),
    ));
  }
}
