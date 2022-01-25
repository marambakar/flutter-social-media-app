import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/app_locale.dart';
import 'package:easy_localization/easy_localization.dart';

class RaesdButtom extends StatefulWidget {
  String title;
  Function method;
  RaesdButtom(this.title , this.method);

  RaesdButtomState createState() => RaesdButtomState();
}

class RaesdButtomState extends State<RaesdButtom>{

  Widget build(BuildContext context) {

    return  Scaffold(
            backgroundColor: Colors.white,
            body:  context.locale==Locale('en')?

            RaisedButton(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(

                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),

                onPressed:  widget.method,
                textColor: Colors.white,
                color: Colors.black54,
               // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child:Container(
                          // padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                          child: Text(

                            widget.title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),),



                     Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),

// alignment: Alignment.topRight,
                        )

// alignment: Alignment.topRight,

                      ],
                    ))):
            RaisedButton(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(

                        bottomLeft: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0))),

                onPressed:  widget.method,
                textColor: Colors.white,
                color: Colors.black54,
                // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child:  Container(
                          // padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                          child: Text(

                            widget.title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),),



                      Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
// alignment: Alignment.topRight,

                      ],
                    )))
    );
  }
}
