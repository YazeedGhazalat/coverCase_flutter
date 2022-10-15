import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool alreadyUsed = false;
  void getData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    alreadyUsed = prefs.getBool("alreadyUsed") ?? false;
  }

  @override
  void initState() {
    super.initState();
    getData();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return WelcomeScreen();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "images/Home.jpg",
            ),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              // Container(
              //   height: 200,
              //   width: 200,
              //   child: Image.asset(
              //       'images/apple-7446229_1280-removebg-preview.png'),
              // ),
              SizedBox(
                height: 350,
              ),
              // Center(
              //   child: Text(
              //     "Apple Case Store ",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: Color.fromARGB(255, 0, 0, 0),
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Image(
                  width: 200,
                  height: 200,
                  image: AssetImage("images/giphy-unscreen.gif")),
            ],
          ),
        ),
      ),
    );
  }
}
