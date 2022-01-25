import 'package:flutter/material.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'First_page.dart';
class hom extends StatefulWidget {

  @override
  _hom createState() => _hom();
}
class _hom extends State<hom> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlatButton (
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder : (context)=>First_page()));
            },
        ),
      ),
    );
  }
}