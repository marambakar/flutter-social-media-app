import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/Chat/DM.dart';
import 'package:pronz/screen/Chat/Home_chat.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/add_location/AddLocation.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/validate/validate_text.dart';
import 'package:pronz/widget/button_done.dart';
import 'package:pronz/widget/button_gender_female.dart';
import 'package:pronz/widget/button_gender_male.dart';
import 'package:pronz/widget/button_private.dart';
import 'package:pronz/widget/button_public.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class Register4 extends StatefulWidget {
  Userr temp;
  Register4({this.temp});
  @override
  _register4 createState() => _register4();
}
class _register4 extends State<Register4> {
  var _chosenDateTime;
  int selectedValue = 1;
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  DateTime _currentdate = DateTime.now();
  bool _hasBeenPressed = false;
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;



  @override
  Widget build(BuildContext context) {
    void _showDatePicker(ctx) {

    }

    final items = List<DateTime>.generate(60, (i) {
      DateTime date = DateTime.utc(
        DateTime.now().year-30,
        DateTime.now().month,
        DateTime.now().day,
      );

      date.add(Duration(days: i));

      return date;
    });

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
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    color: Color_green,
                    textColor: Colors.white,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(
                          LocaleKeys.Register.tr(),
                          style: TextStyle(fontSize: 18),
                        )),
                    onPressed: () {},
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
                    ButtonWidget1(
                      method: () {
                        setState(() {
                          _hasBeenPressed2 = true;
                          _hasBeenPressed3 = false;
                        });
                      },
                      text: LocaleKeys.Public.tr(),
                      hasBeenPressed: _hasBeenPressed2,
                      color: _hasBeenPressed2 == false
                          ? Colors.grey[600]
                          : Colors.green[400],
                    ),
                    ButtonWidget2(
                      method: () {
                        setState(() {
                          _hasBeenPressed3 = true;
                          _hasBeenPressed2 = false;
                        });
                      },
                      hasBeenPressed: _hasBeenPressed3,
                      text: LocaleKeys.Private.tr(),
                      color: _hasBeenPressed3 == false
                          ? Colors.grey[600]
                          : Colors.green[400],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(LocaleKeys.Username.tr()
                        ,
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width/22))),
                SizedBox(
                  height: 7,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.green[600]),
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidate: _validate,
                    child: TextFormField(
                        // textAlign: TextAlign.center,
                        validator: validateText,
                        decoration: InputDecoration(
                            hintText: "  @", border: InputBorder.none),
                      onChanged: (value){
                          widget.temp.userName=value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(LocaleKeys.Gender.tr(),
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width/22)

                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonGenderWidget(
                      method: () {
                        setState(() {
                          _hasBeenPressed = true;
                          _hasBeenPressed1 = false;
                          widget.temp.gender = 0;


                        });

                      },
                      text: LocaleKeys.Male.tr()
                      ,
                      hasBeenPressed: _hasBeenPressed,
                      color: _hasBeenPressed == false
                          ? Colors.grey[600]
                          : Colors.green[400],
                    ),
                    ButtonGenderWidget1(
                      method: () {

                        setState(() {
                          _hasBeenPressed1 = true;
                          _hasBeenPressed = false;
                          widget.temp.gender = 1;
                        });
                      },
                      hasBeenPressed: _hasBeenPressed1,
                      text: LocaleKeys.Female.tr(),
                      color: _hasBeenPressed1 == false
                          ? Colors.grey[600]
                          : Colors.green[400],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(LocaleKeys.Age.tr(),
                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width/22))),
                SizedBox(
                  height: MediaQuery.of(context).size.height/66,
                ),
                // here
                FlatButton(
                    onPressed: () async {

                       DateTime newDateTime = await showRoundedDatePicker(
                         context: context,
                         initialDate: DateTime(2000),
                         firstDate: DateTime(1960),
                         lastDate: DateTime(2001),
                         borderRadius: 16,
                       );
                       setState(() {
                         print("newDateTime"+newDateTime.toString());

                         widget.temp.birthday = newDateTime;

                         print("newDateTime"+newDateTime.toString());
                       });
                       },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(LocaleKeys.Month.tr()),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                        ),
                        Container(
                          child: Text(LocaleKeys.Day.tr()),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color_green),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(0))),
                        ),
                        Container(
                          child: Text(LocaleKeys.Year.tr()),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color:Color_green),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        )
                      ],
                    )),

                SizedBox(
                  height: MediaQuery.of(context).size.height/44,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: ButtonWidget(
                    method: () async {

                      if (_formKey.currentState.validate()) {
                        print("here the save");
                        addBoolToSF();
                        addStringToSF();
                        _formKey.currentState.save();
                        print(widget.temp.userName);
                        print(widget.temp.uPublic);
                        print("final post");
                        var res = await Post_user(
                            "api/Account/updateUser",
                           widget.temp
                        );
                        print(res.statusCode);
                        print(res.toString());
                        if (res.statusCode == 200) {
                          print("succccc");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>LocationAllowPage(temp:widget.temp)) //LocationAllowPage(temp:widget.temp))
                          );
                          //
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => Home_chat()));
                        }

                      } else {
                    //    _validate = true;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Home_chat()));
                      }
                    },
                  ),
                ),
              ],
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
      body: jsonEncode(<String, dynamic>{
        'UserID' : temp.userID.toString(),
        'Name': temp.name,
        'PhoneNumber': temp.phoneNumber,
        'VarificationCode' : temp.varificationCode,
        'Upublic' : temp.uPublic,
        'UserName' : temp.userName,
        'Gender' : temp.gender,
        'Birthday' : temp.birthday.toIso8601String(),
        'status' : temp.status,
        'token' : Splash_Screen.token,
        'lat' : temp.lat,//x.toDouble(),
        'lng' : temp.lng,
        'LastSeen' : DateTime.now().toString(),
        'Online' :1,

     }),
    );
  }
  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logedin', true);
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
    prefs.setBool('notification', widget.temp.allowNotification);
   prefs.setString('social', widget.temp.socialToken);
    prefs.setInt('status', widget.temp.status);
   prefs.setString('email', widget.temp.email);
   prefs.setString('socialtoken', widget.temp.socialToken);
    getStringValuesSF();
  }
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    String phone = prefs.getString('phone');
    String username = prefs.getString('username');
    String code = prefs.getString('code');
    String birthday = prefs.getString('birthday');
    Splash_Screen.idstatic = prefs.getInt('id');
    print("**************" +Splash_Screen.idstatic.toString() );
    print("here the read");
    print(name);
    print(phone);
    print(username);
    print(code);
    print(birthday);
 //   print(id);
    return name;

  }

  @override
  void initState() {
    if(widget.temp.uPublic ==1)
      {
        _hasBeenPressed2 = true;
        _hasBeenPressed3 = false;

      }
    if(widget.temp.uPublic==0)
      {
        _hasBeenPressed2 = false;
        _hasBeenPressed3 = true;
      }
  }
}
