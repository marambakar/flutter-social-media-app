import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Register4.dart';

class Register3 extends StatefulWidget {
  Userr temp ;
  Register3({this.temp});

  @override
  _register createState() => _register();
}

class _register extends State<Register3> {
  String account_type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[49],
      appBar: AppBar(
        title: Text(
          "Social App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: FlatButton(
                color: Color_green,
                textColor: Colors.white,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      LocaleKeys.Register.tr(),
                      style: TextStyle(fontSize: 18),
                    )),
               onPressed: () {
                //   Navigator.of(context).push(
                //       MaterialPageRoute(builder: (context) => Register4(temp:widget.temp)));
                 },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              LocaleKeys.Youraccountis.tr(),
              style: TextStyle(color: Colors.black, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Image.asset(
                    'images/cc2.PNG',
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  onPressed: (){

                   widget.temp.uPublic = 1;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register4(temp:widget.temp)));
                  },
                ),
                FlatButton(
                    child: Image.asset(
                  'images/dd.PNG',
                  height: MediaQuery.of(context).size.height / 6,
                ),
                  onPressed: (){
                    widget.temp.uPublic = 0;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register4(temp:widget.temp)));

                  },

                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(LocaleKeys.PrivacyPolicy.tr(),
                          style: TextStyle(color: Colors.black, fontSize: 15)),
                      Text(LocaleKeys.Termsofuse.tr(),
                          style: TextStyle(color: Colors.black, fontSize: 15))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
