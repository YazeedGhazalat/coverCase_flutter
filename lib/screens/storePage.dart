import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/storeWidget.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (() {}), icon: Icon(Ionicons.add_circle))
        ],
      ),
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
      body: SafeArea(
          child: Center(
        child: itemPicPrice(
            picURL:
                "https://w7.pngwing.com/pngs/870/532/png-transparent-apple-smart-case-for-9-7-inch-ipad-pro-iphone-7-apple-iphone-x-silicone-case-apple-iphone-x-leather-case-mobile-phone-accessories-mobile-case-rectangle-mobile-phone-case-mobile-phone-thumbnail.png",
            pricePic: "20\$"),
      )),
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
  late String picUrl; //this give us the URL for the pic
  late String picPrice; //this give us the Pricefor the pic
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
              hintText: "Add picture Url",
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
