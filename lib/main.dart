import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:case_store/screens/login&register/loginPage.dart';
import 'package:case_store/screens/login&register/registerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    routes: {
      LoginPage.screenRoute: (context) => LoginPage(),
      RegisterPage.screenRoute: (context) => RegisterPage(),
      WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
