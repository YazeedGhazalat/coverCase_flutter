import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/storeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class itemPicPrice extends StatelessWidget {
  late DocumentReference _documentReference =
      FirebaseFirestore.instance.collection("stuff").doc();
  late Future<DocumentSnapshot> _futureDocument = _documentReference.get();
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
                  final stuffWidget = PicWidget(
                    picURL: stuffUrl,
                    pricePic: stuffPrice,
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
  PicWidget({super.key, required this.picURL, required this.pricePic});
  String? picURL;
  String? pricePic;
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
            storeButtton(myicon: Icons.delete, onpressed: () {}),
            Divider(
              indent: 10,
              thickness: 0,
            ),
            SizedBox(
              height: 20,
            ),
            storeButtton(myicon: Icons.update, onpressed: () {}),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
