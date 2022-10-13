import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  MyTextBox({
    Key? key,
    required this.contlr,
    required this.hintText,
    required this.scureText,
    this.textType,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController contlr;
  final String? hintText;
  bool scureText = false;
  TextInputType? textType;
  Function? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: ((value) {}),
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
    );
  }
}
