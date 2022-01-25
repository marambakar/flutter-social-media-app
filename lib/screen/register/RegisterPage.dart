import 'dart:convert';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/users.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/register/Verify_page.dart';
import 'package:pronz/validate/validate_number.dart';
import 'package:pronz/validate/validate_text.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/widget/button_done.dart';
import 'package:pronz/network/network_client.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../Splash_Screen.dart';
class RegisterPage extends StatefulWidget {

  @override
  _register createState() => _register();
}

class _register extends State<RegisterPage> {
  bool _validate = false;
  Userr temp = new Userr();


  final _formKey = GlobalKey<FormState>();
  TextEditingController namefield=new TextEditingController();

  TextEditingController phonefield=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[49],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Socail App",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
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
                      height: 30,
                      minWidth: 100,
                      color: Color_green,
                      textColor: Colors.white,
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text(LocaleKeys.Register.tr(), style: TextStyle(fontSize: 18)),
                      ),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    LocaleKeys.name.tr(),
                   // "Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Color_green),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      validator: validateText,
                      controller: namefield,
                      onChanged: (value) {
                       temp.name = value;

                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    LocaleKeys.PhoneNumber.tr(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Color_green),
                    ),
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border: InputBorder.none),
                        validator: validateMobile,
                        controller: phonefield,
                        onChanged: (value) {
                          temp.phoneNumber = value;
                          temp.birthday=DateTime.parse("2019-11-12T00:00:00");
                        }

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        LocaleKeys.PrivacyPolicy.tr(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        LocaleKeys.Termsofuse.tr(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: ButtonWidget(
                      method: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          var res = await Post_user(
                              "api/Account/sendVerificationcode",
                              temp
                          );
                          print(res.statusCode);
                          print(res.toString());
                          if (res.statusCode == 200) {
                            print("succccc");

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Verify_page(temp: temp,)));
                          }

                        } else {
                          _validate = true;
                        }
                      },
                    ),

                  )
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
    print("postttttdate"+temp.birthday.toIso8601String());
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'Name': temp.name,
        'PhoneNumber': temp.phoneNumber,
        'Birthday' : temp.birthday.toIso8601String(),
        'lat' : Splash_Screen.x.toString(),//x.toDouble(),
        'lng' : Splash_Screen.y.toString(),
      }),
    );

  }
}
