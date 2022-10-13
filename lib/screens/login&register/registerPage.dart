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
        content: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: email,
          decoration: InputDecoration(
              suffixIcon: const Icon(Ionicons.at),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              label: const Text("Email"),
              hintText: "example@gmail.com"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: visible,
          controller: password,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: (() {
                  setState(() {
                    visible = !visible;
                  });
                }),
                icon: Icon(
                  visible ? Ionicons.eye_off : Ionicons.eye,
                )),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            label: const Text("Password"),
          ),
        ),
        TextButton(
            onPressed: () async {
              try {
                var authenticationobject = FirebaseAuth.instance;

                UserCredential myUser =
                    await authenticationobject.createUserWithEmailAndPassword(
                        email: email.text, password: password.text);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("added successfully")));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Email Already in use")));
              }
            },
            child: Text("sign up "))
      ],
    ));
  }
}
