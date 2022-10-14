import 'package:case_store/components/my_button.dart';
import 'package:case_store/components/storeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class itemPicPrice extends StatelessWidget {
  itemPicPrice({super.key, required this.picURL, required this.pricePic});
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
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("stuff").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("there is an error");
              }
              if (snapshot.hasData) {
                final stuffs = snapshot.data!.docs;
                List<Text> stuffWidgets = [];
                for (var stuff in stuffs) {
                  final stuffPrice = stuff['price'];
                  final stuffUrl = stuff['url'];
                  final stuffWidget = Text('$stuffPrice from $stuffUrl');
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
