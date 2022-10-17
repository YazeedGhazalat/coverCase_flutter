import 'package:case_store/components/my_button.dart';

import 'package:case_store/screens/login&register/loginPage.dart';
import 'package:case_store/screens/login&register/registerPage.dart';

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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Home.jpg"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
              ),
              MyButton(
                  fontsize: 20,
                  Fontcolor: Colors.black,
                  color: Color.fromRGBO(239, 239, 239, 1),
                  onPressed: (() {
                    Navigator.pushNamed(context, LoginPage.screenRoute);
                  }),
                  title: "Login"),
              MyButton(
                  fontsize: 20,
                  Fontcolor: Colors.black,
                  color: Color.fromRGBO(239, 239, 239, 1),
                  onPressed: (() {
                    Navigator.pushNamed(context, RegisterPage.screenRoute);
                  }),
                  title: "Sign up"),
            ],
          ),
        ),
      ),
    );
  }
}
