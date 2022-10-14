import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.color, required this.onPressed, required this.title});
  final Color color;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          height: 42,
          minWidth: 200,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class storeButtton extends StatelessWidget {
  storeButtton({
    required this.myicon,
    required this.onpressed,
    Key? key,
  }) : super(key: key);
  final IconData? myicon;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: onpressed,
      height: 40,
      splashColor: Colors.amber,
      color: Colors.white,
      child: Icon(
        myicon,
        color: Colors.black,
      ),
      elevation: 20,
    );
  }
}
