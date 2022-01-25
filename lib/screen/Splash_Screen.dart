import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/add_location/AddLocation.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/screen/register/First_page.dart';
import 'package:pronz/validate/validate_text.dart';
import 'package:pronz/widget/button_done.dart';
import 'package:pronz/widget/button_gender_female.dart';
import 'package:pronz/widget/button_gender_male.dart';
import 'package:pronz/widget/button_private.dart';
import 'package:pronz/widget/button_public.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';

class Splash_Screen extends StatefulWidget {
  Userr temp;
  static int idstatic;
  static String token;
 static double x;
 static double y ;
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash_Screen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;

  String _currentAddress;
  bool loged_in;
  bool Check;
  String name;
  String phone;
  String username;
  String code;
  String birthday;
  int gender;
  int uipublic;
  int id;
  bool notification;
  String social;
  // double x;
  // double y ;
  String email;
  String social_token;
  int status;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      Splash_Screen.token = value;
      print("OOOOOOOO" +  Splash_Screen.token.toString());
    });
    Savetoken();
 //  removeValues();
  getInfoValuesSF();
  print("inthe splash id" + id.toString());
    print(Check);
 _getCurrentLocation();
 getBoolValuesSF();
    Timer(Duration(seconds: 5), () async {

      if (Check==false) {
        print(Check);

        Navigator.of(this.context)
            .push(MaterialPageRoute(builder: (context) => First_page()));
      }
      else {
        print("here the true");
        var res = await Post_user(
            "api/Account/updateUser",
            widget.temp
        );
        if(res.statusCode==200){

          print("success");
        }
        else{print("noooooo");}
        print(Check);
        print("after the true");
      Navigator.of(this.context)
            .push(MaterialPageRoute(builder: (context) => control_page()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
          Image.asset('images/Comp-1.gif' , width: MediaQuery.of(context).size.width , height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),

    );
  }

   getBoolValuesSF()  {
     setState(() {
       SharedPreferences.getInstance().then((prefs) {
         bool check = (prefs.getBool('logedin') ?? false);
         Splash_Screen.idstatic = prefs.getInt('id');
         print("here is get the boolean" );
       print  (  check);
        Check = check;

       });
     });
  }
  removeValues()  {
    Check = false;
    setState(() {
      print("start remove");
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove("logedin");
         prefs.remove("gender");
        prefs.remove("name");
        prefs.remove("phone");
        prefs.remove("username");
        prefs.remove("code");
        prefs.remove("birthday");
        prefs.remove("id");
        prefs.remove("uipublic");
        prefs.remove("notification");
        prefs.remove("social");
print(loged_in);
print("done remove");

      }

      ) ;
    });
    getInfoValuesSF();
    print(loged_in);
  }
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(()
      {
        print("here is func location");
        _currentPosition = position;
        Splash_Screen.x=_currentPosition.latitude;
        Splash_Screen.y=_currentPosition.longitude;
        print("inside func loaction");
        print( Splash_Screen.x);
        print(Splash_Screen.y);
      }
      );

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print("wrong");
      print(e);
    }
  }
  getInfoValuesSF() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    phone = prefs.getString('phone');
    username = prefs.getString('username');
    code = prefs.getString('code');
    birthday = prefs.getString('birthday');
    gender = prefs.getInt('gender');
    id = prefs.getInt('id');
    uipublic = prefs.getInt('uipublic');
    notification = prefs.getBool('notification');
    social = prefs.getString('social');
    loged_in = prefs.getBool('logedin');
    email = prefs.getString('email');
    status = prefs.getInt('status');
    Splash_Screen.token = prefs.getString('token');
    social_token = prefs.getString('social_token');
//    widget.
    print("done fetch");

    //print(loged_in);
    print(id);
    return name;

  }
  Savetoken()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('token',Splash_Screen.token);
  }
  Future<http.Response> Post_user(url, Userr temp,
      ) async {

    var baseUrl = network_client.Url;
    var url = "api/Account/updateUser";
    print("posttttt");

    print(id);
    print("theeee token" + Splash_Screen.token.toString());
    print("url is : " + Uri.parse("$baseUrl/$url").toString());
    print("thhhhhhhhheeeeeeee xxxxxxxxxxxxxx" + Splash_Screen.x.toString());
    print("thhhhhhhhheeeeeeee yyyyyyyyyyyyy" + Splash_Screen.y.toString());

    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
           'UserId' : id,
           'status' : 1,
            'Name' : name,
            'PhoneNumber' : phone,
            'VarificationCode' : code,
            'Upublic' : uipublic ,
            'UserName' : username ,
            'Gender' : gender ,
            'Birthday' : birthday ,
             'lat' : Splash_Screen.x.toString(),//x.toDouble(),
             'lng' : Splash_Screen.y.toString(),
            'Token' : Splash_Screen.token,
      'LastSeen' : DateTime.now().toString(),
        'Online' : 1,//y.toDouble(),
      }),
    );
  }

}
