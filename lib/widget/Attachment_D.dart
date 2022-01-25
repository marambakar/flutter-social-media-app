import 'package:flutter/material.dart';

class AttD extends StatelessWidget {
  final String text;
  final Function method;
  final IconData icon;

  AttD({this.text, this.method, this.icon});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: method,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
