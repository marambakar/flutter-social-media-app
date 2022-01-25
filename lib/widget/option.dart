import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/option.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Options extends StatefulWidget {
  final String optnumber;
  List <Option> Optionn;

  Option op;
  String result;

  Options({
    @required this.optnumber,
    this.Optionn
  });

  OptionsState createState() => OptionsState();
}

class OptionsState extends State<Options>{
  double widthscreen, heightscreen;
//static TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: heightscreen / 20,
        width: widthscreen / 1.8,
        child: TextFormField(
         // controller: myController,
        onChanged: (value)
          {

                widget.op  = new Option(text: value);
               // widget.Optionn.add(widget.op);


          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            hintText: LocaleKeys.wordop.tr() + widget.optnumber,
          ),
        ),
      ),
    );
  }
}
