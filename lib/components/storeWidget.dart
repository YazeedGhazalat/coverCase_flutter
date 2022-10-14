import 'package:case_store/components/my_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class itemPicPrice extends StatelessWidget {
  itemPicPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("stuff").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("there is an error");
              }
              if (snapshot.hasData) {
                final stuffs = snapshot.data!.docs;
                List<PicWidget> stuffWidgets = [];
                for (var stuff in stuffs) {
                  final stuffPrice = stuff['price'];
                  final stuffUrl = stuff['url'];
                  final stuffID = stuff['id'];
                  final stuffWidget = PicWidget(
                    picURL: stuffUrl,
                    pricePic: stuffPrice,
                    ID: stuffID,
                  );
                  stuffWidgets.add(stuffWidget);
                }
                return Column(
                  children: stuffWidgets,
                );
              }
              return const CircularProgressIndicator.adaptive();
            }),
      ],
    );
  }
}

class PicWidget extends StatelessWidget {
  PicWidget({super.key, required this.picURL, required this.pricePic, this.ID});
  String? picURL;
  String? pricePic;
  String? ID;
  @override
  Widget build(BuildContext context) {
    return Column(
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
            border: Border.all(
              width: 0,
              strokeAlign: StrokeAlign.outside,
            ),
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Colors.black,
                  blurRadius: 25.0,
                  spreadRadius: 10.0,
                  offset: Offset.zero)
            ],
          ),
          child: Hero(
            tag: "Image",
            child: Image.asset(
              "images/$picURL.jpg",
              height: double.maxFinite,
              width: double.maxFinite,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                  offset: Offset.zero)
            ],
            border: Border.all(
              width: 0,
              strokeAlign: StrokeAlign.outside,
            ),
          ),
          child: Text(
            "$pricePic\$",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
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
            storeButtton(
                myicon: Icons.delete,
                onpressed: () async {
                  await _firestore.collection("stuff").doc(ID).delete().then(
                        (doc) => print("Document deleted"),
                        onError: (e) => print("Error updating document $e"),
                      );
                }),
            Divider(
              indent: 10,
              thickness: 0,
            ),
            SizedBox(
              height: 20,
            ),
            storeButtton(
                myicon: Icons.update,
                onpressed: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertPage(
                          ID: ID,
                        );
                      }));
                }),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class AlertPage extends StatefulWidget {
  AlertPage({
    this.ID,
    Key? key,
  }) : super(key: key);
  String? ID;

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
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
