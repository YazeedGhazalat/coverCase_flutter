import 'package:case_store/components/my_button.dart';
import 'package:flutter/material.dart';

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
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 25.0,
                  spreadRadius: 20.0,
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
              "$picURL",
              height: double.maxFinite,
              width: double.maxFinite,
            ),
          ),
        ),
        SizedBox(
          height: 10,
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
              strokeAlign: StrokeAlign.center,
            ),
          ),
          child: Text(
            "$pricePic",
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
        )
      ],
    );
  }
}
