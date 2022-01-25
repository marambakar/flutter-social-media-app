import 'package:flutter/material.dart';

class ButtonWidget1 extends StatelessWidget {
  final String text;
  final Function method;
  final bool hasBeenPressed;
  final bool hasBeenPressed1;
  final Color color;
  ButtonWidget1(
      {this.text,
      this.method,
      this.hasBeenPressed = false,
      this.hasBeenPressed1 = false,
      this.color});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: MediaQuery.of(context).size.height / 19,
      minWidth: MediaQuery.of(context).size.width / 2.3,
      color: color,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(Radius.circular(10))),
      onPressed: method,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
