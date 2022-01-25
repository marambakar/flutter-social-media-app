import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../../config.dart';
import '../Splash_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:decimal/decimal.dart';

class EditProfile extends StatefulWidget {
  @override
  _Edit createState() => _Edit();
}

class _Edit extends State<EditProfile> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  bool _value = false;
  int val = 1;
  int UIupdate ;
  String username;
  String birthday;
  String socialtoken;
  String phone;
  int gender;
  String code;
  Decimal x;
  Decimal y ;
  TextEditingController _controller =
      TextEditingController();
  TextEditingController _controller_birthday =
  TextEditingController();
  TextEditingController _controller_Bio =
  TextEditingController();
  TextEditingController _controller_From=
  TextEditingController();
  var textController = new TextEditingController();
  @override
  Future<void> initState() {
    // TODO: implement initState
    getStringValuesSF();
  }
  String account_type1 = 'Public';
  String account_type;
  int account_typeq;
  int id ;
  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color_green,
          title: Text(LocaleKeys.EditProfile.tr()),
        ),
        body: FutureBuilder<dynamic>(
          future: getStringValuesSF(),
          builder: (context, snapshot) {
            print("kjdk" + snapshot.data.toString());
              _controller.text =  snapshot.data.toString();
              _controller_birthday.text=birthday.toString();
              account_type = account_type1;
              if(UIupdate == 0 ){id = 2;} else{id = 1;}

            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // Container(
                    //     width: 120.0,
                    //     height: 120.0,
                    //     decoration: new BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         image: new DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: AssetImage(
                    //             "images/tree2.png",
                    //           ),
                    //         ))
                    // ),
                    Container(
                        // decoration: new BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     image: new DecorationImage(
                        //       fit: BoxFit.cover,
                        //
                        //     )),
                      child: Stack(
                        children: [
                          Container(
                              width: 120.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                  // shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "images/tree2.png",
                                    ),
                                  ))
                          ),
                          // Align(
                          //     alignment: Alignment.centerRight,
                          //     child:ImageIcon(
                          //
                          //       AssetImage(
                          //           "images/tree2.png"),
                          //       size: 50,
                          //       color: Color_green,
                          //     )
                          // ),
                          Positioned(
                              bottom: 35,
                              right: 35,
                              child:Text(snapshot.data[0].length.toString(), style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.Username.tr() + " :",
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, height: 3),
                          textAlign: TextAlign.left,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width/2+100,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(),
                            onChanged: (value) {},
                          ),
                        ),

                        //  TextField(controller: _controller,),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Birthday :   ",
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, height: 3),
                          textAlign: TextAlign.left,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width/2+100,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _controller_birthday ,

                            decoration: InputDecoration(),
                            onChanged: (value) {},
                          ),
                        ),

                        //  TextField(controller: _controller,),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Email :        ",
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, height: 3),
                          textAlign: TextAlign.left,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width/2+100,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _controller_From ,

                            decoration: InputDecoration(),
                            onChanged: (value) {},
                          ),
                        ),

                        //  TextField(controller: _controller,),
                      ],
                    ),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Account is?",
                            style: TextStyle(
                                color: Colors.black, fontSize: 20, height: 3),
                            textAlign: TextAlign.left,
                          ),
                           Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: Radio(

                    value:1,

                   groupValue: id,
                    onChanged: (val) {
                      setState(() {

                        account_type = 'Private';
                        id = val;
                        UIupdate = 1;


                      });
                    },
                  ),
                ),

                  Text(
                    'Private',
                    style: new TextStyle(fontSize: 20.0,height: 3),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                    child: Radio(
                      value:2,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          account_type = 'Public';
                          id = val;
                          UIupdate = 0;

                        });
                      },
                    ),
                  ),
                  Text(
                      'Public',
                      style: new TextStyle(
                          fontSize: 20.0,height: 3
                      )
                  ),
                  ],
                )
                        ],
                      ),
                    ),
                SizedBox(height: 80,),
                FlatButton(
                  color: Color_green,
                  textColor: Colors.white,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 18),
                      )),
                  onPressed: () async {
                    var response = await Saveupdates(38);
                    if(response.statusCode==200)
                      {print("succc");
                      if(UIupdate == null){UIupdate = account_typeq; }
                      print(_controller.text.toString());
                      print(UIupdate.toString());
                      print(_controller_birthday.text.toString());
                      print( _controller_From.text.toString(),);
                      UpdateSf();
                      }
                    else{
                      print("faild");
                    }
                    },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.all(Radius.circular(20))
                    ),
                )
                  ],
                ),
              ),
            );
          },
        ));
  }
  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //
  //     Placemark place = p[0];
  //
  //     setState(() {
  //       _currentAddress =
  //       "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print("wrong");
  //     print(e);
  //   }
  // }

  // _getCurrentLocation() {
  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(()
  //     {
  //       print("here is func location");
  //       _currentPosition = position;
  //       x=Decimal.parse(_currentPosition.latitude.toString());
  //       y=Decimal.parse(_currentPosition.longitude.toString());
  //       print("inside func loaction");
  //       print( x);
  //       print(y);
  //     }
  //     );
  //
  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     name = prefs.getString('name');
     phone = prefs.getString('phone');
    username = prefs.getString('username');
    account_typeq = prefs.getInt('uipublic') ;
    birthday = prefs.getString('birthday');
    gender = prefs.getInt('gender');
    code = prefs.getString('code');
    socialtoken = prefs.getString('socialtoken');
    Splash_Screen.idstatic = prefs.getInt('id');
    print("**************" + Splash_Screen.idstatic.toString());
    print("here the read");
   // print(username);
   // print(phone);
    print(username);
    print(Splash_Screen.idstatic);
    //   print(code);
    print(birthday);
    //   print(id);
    return username ;
  }
  Future<http.Response> Saveupdates (int idofupdate)async{
  // await _getCurrentLocation();
   //print("the xxxxxxxxxxx" + x.toString());
    var api = "http://bronze.fingerprint.ml/api/Account/updateUser/$Splash_Screen.idstatic";
    return  http.post(
          Uri.parse(api),
           headers: <String, String>{
           'Content-Type': 'application/json',
},
body: jsonEncode(<String, dynamic>{
'UserID' : Splash_Screen.idstatic,
'UserName': _controller.text.toString(),
'UPublic' : UIupdate,
'Birthday' : _controller_birthday.text.toString(),
'Email' : _controller_From.text.toString(),
  'Name' : name,
  'PhoneNumber' : phone,
  'VarificationCode' : code,
  'Gender' : gender,
  'Lat' : Splash_Screen.x.toString(),
  'Lng' : Splash_Screen.y.toString(),
  'Token' : Splash_Screen.token,
  'status' : 1,
  'LastSeen' : DateTime.now().toString(),
  //'LastSeen' :
}


)

    );



  }
  UpdateSf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username',_controller.text.toString());
    prefs.setString('birthday',  _controller_birthday.text.toString());
    prefs.setInt('uipublic',UIupdate);
    prefs.setString('email', _controller_From.text.toString());
    getStringValuesSF();
    //  await prefs.clear();
    //  prefs.setString('name', name );
    //  prefs.setString('phone', phone);

    // prefs.setString('code', code);
  //  prefs.setInt("gender", gender);
  //  prefs.setInt('id',Splash_Screen.idstatic);

  //  prefs.setInt('status', 1);

  //  prefs.setString('socialtoken', socialtoken);

  }
}
