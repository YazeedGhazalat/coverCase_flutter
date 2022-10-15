import 'package:case_store/components/alerts.dart';
import 'package:case_store/components/storeWidget.dart';
import 'package:case_store/screens/WelcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
      drawerEdgeDragWidth: 150,
      drawer: Drawer(
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: [
                Row(
                  children: [
                    Image(
                      height: 150,
                      image: AssetImage(
                        "images/${i + 1}.jpg",
                      ),
                    ),
                    Text(
                      "Image number ${i + 1}",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                )
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Ionicons.image),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text("MAY Case Store"),
        automaticallyImplyLeading: true,
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
