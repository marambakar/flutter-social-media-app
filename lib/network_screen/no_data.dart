import 'package:flutter/material.dart';

class NoData extends StatelessWidget {

  String text;
  NoData({Key key,@required this.text}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Icon(Icons.add,color: Colors.black26,size: 125,),
              ),
              Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black26),textAlign: TextAlign.center,),
            ],
          ),
        )
    );
  }
}
