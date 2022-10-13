import 'package:case_store/components/my_button.dart';
import 'package:case_store/screens/login&register/loginPage.dart';
import 'package:case_store/screens/login&register/registerPage.dart';
import 'package:case_store/screens/storePage.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String screenRoute = "welcome";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
                color: Colors.blue,
                onPressed: (() {
                  Navigator.pushNamed(context, LoginPage.screenRoute);
                }),
                title: "Login"),
            MyButton(
                color: Colors.blue,
                onPressed: (() {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return RegisterPage();
                      }));
                }),
                title: "Sign up"),
            MyButton(
                color: Colors.blue,
                onPressed: (() {
                  Navigator.pushNamed(context, StorePage.screenRoute);
                }),
                title: "Test")
          ],
        ),
      ),
    );
  }
}
