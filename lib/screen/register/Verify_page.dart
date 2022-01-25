import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/screen/register/Register2.dart';
import 'package:pronz/screen/register/Register4.dart';
import 'package:pronz/validate/validate_number.dart';
import 'package:pronz/network/network_client.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pronz/widget/button_done.dart';
class Verify_page extends StatefulWidget {
  Userr temp;
  Verify_page({this.temp});
  @override
  _Verify createState() => _Verify();
}

class _Verify extends State<Verify_page> {
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[49],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Social App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              // ignore: deprecated_member_use
              autovalidate: _validate,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      color: Color_green,
                      textColor: Colors.white,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(LocaleKeys.Register.tr(), style: TextStyle(fontSize: 18)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register2()));
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/44,
                  ),
                  Text(
                    LocaleKeys.VarificationCode.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/22,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/33),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color:Color_green)),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: validateCode,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        widget.temp.varificationCode = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/66,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        LocaleKeys.PrivacyPolicy.tr()
                        ,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        LocaleKeys.Termsofuse.tr(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(LocaleKeys.Didnotgetthecode.tr(),
                          style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width/33)),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Text(
                               LocaleKeys.Resend.tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:MediaQuery.of(context).size.width/33,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/12,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: ButtonWidget(
                      method: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var res =
                              await Post_user("api/Account/LogIn", widget.temp);
                          print(res.statusCode);
                          print(res.toString());
                          if (res.statusCode == 200) {
                            print("succcccverify");
                            // Map results =  json.decode(res.body);
                            // print(results);
                            Userr user =
                                Userr.fromJson(json.decode(res.body)['data']);
                            widget.temp = user;
                            print("widget.temp.name"+widget.temp.userName.toString());
                            if (user.userName != null) {
                              print("here the broblem");
                              removeValues(); // this func should put in main and delete from splash
                              addStringToSF();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => control_page()));
                            } else {
                              print("here the broblem2");

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register2(
                                        temp: widget.temp,
                                      )));
                            }
                          }
                          ;

                          //   Userr u=Userr.fromJson(res.body.toString());
                          //   print(u.name);

                        } else {
                          _validate = true;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> Post_user(url, Userr temp) async {
    var baseUrl = network_client.Url;
    print("posttttt");

    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'VarificationCode': temp.varificationCode,
        'Name': temp.name,
        'PhoneNumber': temp.phoneNumber,
        'Status' : '1',
        'lat' : Splash_Screen.x.toString(),//x.toDouble(),
        'lng' : Splash_Screen.y.toString(),
      }),
    );
  }
  removeValues()  {
    setState(() {
      print("start remove");
      SharedPreferences.getInstance().then((prefs) {
prefs.clear();

      }

      ) ;
    });
  }
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', widget.temp.name);
    prefs.setString('phone', widget.temp.phoneNumber);
    prefs.setString('username', widget.temp.userName);
    prefs.setString('code', widget.temp.varificationCode);
    prefs.setString('birthday', widget.temp.birthday.toString());
    prefs.setInt("gender",widget.temp.gender);
    prefs.setInt('id',widget.temp.userID);
    prefs.setInt('uipublic',widget.temp.uPublic);
   // prefs.setBool('notification', widget.temp.allowNotification);
  //  prefs.setString('social', widget.temp.socialToken);
  //  prefs.setInt('status', widget.temp.status);
  //  prefs.setString('email', widget.temp.email);
  //  prefs.setString('socialtoken', widget.temp.socialToken);
    prefs.setBool('logedin', true);
    Splash_Screen.idstatic = prefs.getInt('id');
    print("**************" +Splash_Screen.idstatic.toString() );
  }
  getBoolValuesSF()  {
    setState(() {
      SharedPreferences.getInstance().then((prefs) {
        bool check = (prefs.getBool('logedin') ?? false);

        print("here is get the boolean" );
        print  (  check);

      });
    });
  }
}
