import 'package:flutter/material.dart';
import 'package:pronz/config.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function method;
  ButtonWidget({this.text, this.method});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Color_green,
      textColor: Colors.white,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            "Done",
            style: TextStyle(fontSize: 18),
          )),
      onPressed: method,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
    );
  }
}
