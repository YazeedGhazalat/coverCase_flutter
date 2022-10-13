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
  final _auth = FirebaseAuth.instance; //to Connect To the firebase
  String? picUrl; //this give us the URL for the pic
  String? picPrice; //this give us the Pricefor the pic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.black,
                        blurRadius: 25.0,
                        spreadRadius: 5.0,
                        offset: Offset.zero)
                  ],
                  border: Border.all(
                    width: 3,
                    strokeAlign: StrokeAlign.center,
                  ),
                ),
                child: Hero(
                  tag: "Image",
                  child: Image.network(
                    "https://cdn.cliqueinc.com/posts/294899/designer-phone-cases-294899-1650040053070-main.1200x0c.jpg?interlace=true&quality=70",
                    height: double.maxFinite,
                    width: double.maxFinite,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  height: 40,
                  splashColor: Colors.amber,
                  color: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.black),
                  elevation: 20,
                ),
                Divider(
                  indent: 10,
                  thickness: 0,
                ),
                MaterialButton(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  height: 40,
                  splashColor: Colors.amber,
                  color: Colors.white,
                  child: Icon(Icons.info, color: Colors.black),
                  elevation: 20,
                ),
                Divider(
                  indent: 10,
                  thickness: 0,
                ),
                MaterialButton(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  height: 40,
                  splashColor: Colors.amber,
                  color: Colors.white,
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                  ),
                  elevation: 20,
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
