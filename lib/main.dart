import 'package:case_store/firebase_options.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:case_store/screens/login&register/loginPage.dart';
import 'package:case_store/screens/login&register/registerPage.dart';
import 'package:case_store/screens/storePage.dart';
import 'package:case_store/screens/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    routes: {
      LoginPage.screenRoute: (context) => LoginPage(),
      RegisterPage.screenRoute: (context) => RegisterPage(),
      WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
      StorePage.screenRoute: (context) => StorePage(),
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
