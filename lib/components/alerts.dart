import 'package:case_store/screens/storePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'my_button.dart';

final _firestore = FirebaseFirestore.instance;

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
      title: Column(
        children: [
          TextField(
            onChanged: ((value) {
              picUrl = value;
            }),
            controller: imageUrlControl,
            decoration: InputDecoration(
              hintText: "Add picture #",
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
          SizedBox(
            height: 10,
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
              fontsize: 20,
              Fontcolor: Colors.white,
              color: Colors.green,
              onPressed: (() {
                print(signInUser.email);
                print("${picPrice}     $picUrl");
                imageUrlControl.clear();
                priceConrol.clear();
                // _firestore.collection("stuff").add(
                //   {
                //     'price': picPrice.toString(),
                //     'url': picUrl.toString(),
                //   },
                // );
                //
                final docUser =
                    FirebaseFirestore.instance.collection("stuff").doc();
                docUser.set({
                  'id': docUser.id,
                  'url': picUrl,
                  'price': picPrice,
                });
              }),
              title: "Add to store")
        ],
      ),
    );
  }
}

class AlertUpdate extends StatefulWidget {
  AlertUpdate({
    this.ID,
    Key? key,
  }) : super(key: key);
  String? ID;

  @override
  State<AlertUpdate> createState() => _AlertUpdateState();
}

class _AlertUpdateState extends State<AlertUpdate> {
  final imageUrlControl = TextEditingController();

  final priceConrol = TextEditingController();

  @override
  late String picUrl;
  //this give us the URL for the pic
  late String picPrice;
  //this give us the Pricefor the pic
  bool PriceCheck = false;

  bool PicChek = false;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Checkbox(
                value: PicChek,
                onChanged: ((value) {
                  setState(() {
                    PicChek = !PicChek;
                  });
                })),
          ),
          TextField(
            onChanged: ((value) {
              picUrl = value;
            }),
            controller: imageUrlControl,
            decoration: InputDecoration(
              hintText: "Add picture #",
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Checkbox(
                value: PriceCheck,
                onChanged: ((value) {
                  setState(() {
                    PriceCheck = !PriceCheck;
                  });
                })),
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
              fontsize: 20,
              Fontcolor: Colors.white,
              color: Colors.green,
              onPressed: (() {
                if (PicChek && !PriceCheck) {
                  final updatedPic =
                      _firestore.collection("stuff").doc(widget.ID);
                  updatedPic.update({"url": "$picUrl"}).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                } else if (!PicChek && PriceCheck) {
                  final updatedPrice =
                      _firestore.collection("stuff").doc(widget.ID);
                  updatedPrice.update({
                    "price": "$picPrice",
                  }).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                } else if (PriceCheck == true && PicChek == true) {
                  final updatedPrice =
                      _firestore.collection("stuff").doc(widget.ID);
                  updatedPrice.update({
                    "url": "$picUrl",
                    "price": "$picPrice",
                  }).then(
                      (value) =>
                          print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e"));
                }
              }),
              title: "Update item")
        ],
      ),
    );
  }
}
