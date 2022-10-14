import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  MyTextBox({
    Key? key,
    required this.contlr,
    required this.hintText,
    required this.scureText,
    this.onsubmet,
    this.textType,
    this.onChanged,
  }) : super(key: key);
  String? picUrl; //this give us the URL for the pic
  String? picPrice; //this give us the Pricefor the pic
  final TextEditingController contlr;
  final String? hintText;
  bool scureText = false;
  TextInputType? textType;
  Function? onChanged;
  void Function(String)? onsubmet = (value) {};
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onsubmet,
      keyboardType: textType,
      obscureText: scureText,
      controller: contlr,
      decoration: InputDecoration(
        hintText: "$hintText",
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
          borderSide: BorderSide(color: Colors.black, width: 1),
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
    );
  }
}
