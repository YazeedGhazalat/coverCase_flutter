import 'package:case_store/components/alerts.dart';
import 'package:case_store/components/storeWidget.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser; //this give us the email

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  static const String screenRoute = "StorePage";
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void PcStream() async {
    await for (var snapshot in _firestore.collection("stuff").snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void getMessages() async {
    final pics = await _firestore.collection('stuff').get();

    for (var pic in pics.docs) {
      print(pic.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MAY Case Store"),
        automaticallyImplyLeading: false,
        elevation: 5,
        backgroundColor: Color.fromRGBO(4, 24, 74, 1),
        actions: [
          IconButton(
              onPressed: (() {
                _auth.signOut();
                Navigator.pushReplacementNamed(
                    context, WelcomeScreen.screenRoute);
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(4, 24, 74, 1),
        elevation: 20,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return AlertPage();
              }));
        },
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: itemPicPrice(),
        ),
      )),
    );
  }
}
