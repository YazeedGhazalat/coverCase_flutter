import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/textbox.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return AlertPage();
              }));
        },
      ),
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
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                storeButtton(myicon: Icons.favorite, onpressed: () {}),
                Divider(
                  indent: 10,
                  thickness: 0,
                ),
                storeButtton(myicon: Icons.info, onpressed: () {}),
                Divider(
                  indent: 10,
                  thickness: 0,
                ),
                SizedBox(
                  height: 20,
                ),
                storeButtton(myicon: Icons.add_shopping_cart, onpressed: () {}),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class AlertPage extends StatelessWidget {
  AlertPage({
    Key? key,
  }) : super(key: key);
  final imageUrlControl = TextEditingController();
  final priceConrol = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  String? picUrl; //this give us the URL for the pic
  String? picPrice; //this give us the Pricefor the pic
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          TextField(
            onChanged: ((value) {
              picUrl = value;
            }),
            controller: imageUrlControl,
            decoration: InputDecoration(
              hintText: "Add price",
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ),
          TextField(
            onChanged: ((value) {
              picPrice = value;
            }),
            controller: priceConrol,
            decoration: InputDecoration(
              hintText: "Add price",
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ),
          MyButton(
              color: Colors.green,
              onPressed: (() {
                print(signInUser.email);
                print("${picPrice}     $picUrl");
                imageUrlControl.clear();
                priceConrol.clear();
                _firestore.collection("stuff").add(
                  {
                    'price': picPrice.toString(),
                    'url': picUrl.toString(),
                  },
                );
              }),
              title: "Add to store")
        ],
      ),
    );
  }
}
