import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pronz/config.dart';
import 'package:easy_localization/easy_localization.dart';




import 'package:pronz/models/Locationn.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import 'package:pronz/models/userupdate.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/add_location/location_map.dart';
import 'package:pronz/screen/notification_page/notification_allow.dart';

import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:pronz/translations/locale_keys.g.dart';


class LocationAllowPage extends StatefulWidget {
  Userr temp;
  LocationAllowPage({this.temp});
  @override
  LocationAllowPageBody createState() => LocationAllowPageBody();
}

class LocationAllowPageBody extends State<LocationAllowPage> {
  double widthscreen, heightscreen;
  String locationTex;
  Location location = new Location();

  showDialogEdetLocation(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;

    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: heightscreen / 3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Your Location is',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 24, width: 24)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    locationTex,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                  Container(
                   width: widthscreen/2.5,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            print("loc to map" + locationTex);
                            // showDialogregestrationMap(
                            //     context, widget.temp.userName, locationTex, "images/img.jpg");

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LocationmapPage(temp:widget.temp)));
                          });
                        },
                        color: Colors.white,

                        child: Text(
                          'Edit  Location',
                          style: TextStyle(
                            fontSize: widthscreen/22,
                            fontWeight: FontWeight.bold,
                            color: Color_green,
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                      ),
                    ),

    Container(
     width: widthscreen/2.5,
                      child: FlatButton(
                        onPressed: () {
                          setState(() async {
                            print("loc to map" + locationTex);
                            // showDialogregestrationMap(
                            //     context, widget.temp.userName, locationTex, "images/img.jpg");

                            var res =
                                await Post_user("api/Account/updateUser", widget.temp);
                            print("Niv"+res.statusCode.toString());
                            print(res.toString());
                            if (res.statusCode == 200) {
                              print("succccc_Location");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationAllowPage()));
                            }

                          });
                        },
                        color: Colors.white,

                        child: Text(
                          'confirm',
                          style: TextStyle(
                            fontSize: widthscreen/22,
                            fontWeight: FontWeight.bold,
                            color: Color_green,
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                      ),
                    ),

              ],
            )

          ],
        ),
      ),
      insetPadding: EdgeInsets.symmetric(
          vertical: heightscreen / 20, horizontal: widthscreen / 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Locationn loc;

  String val;

  Future<String> _getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return "";
      }
    }

    _locationData = await location.getLocation();
    print("vvvv" + _locationData.toString());
    // loc = new Locationn(
    //     axis: _locationData.latitude, yais: _locationData.longitude);


    //  print("qqq" + loc.axis.toString());
    widget.temp.lat=_locationData.latitude.toString();
    widget.temp.lng=_locationData.longitude.toString();

    await _getaddress();
    // await  print("val^^^^^^^^"+val.toString());

    return val;

    // Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
  }

  Future<String> _getaddress() async {
    // print("_locationData.latitudeNivoooooo" + loc.axis.toString());
    // final coordinates = await new Coordinates(loc.axis, loc.yais);
    final coordinates = await new Coordinates(double.parse(widget.temp.lat), double.parse(widget.temp.lng));
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print("addresses" + addresses.toString());
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}" +
        "nivo" +
        addresses.toString());
    locationTex = "${first.featureName} : ${first.addressLine}";
    return "${first.featureName} : ${first.addressLine}";
  }



  @override
  initState() {
    super.initState();
    // Add listeners to this class

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    locationTex = "dont location";

    return Scaffold(
      body: Container(
      //  color: Color_green,
      //   decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage("images/locationbac.png"),
      //       fit: BoxFit.fill)),
        child: Stack(
          children: [
            // Container(
            //   height: heightscreen / 4,
            // ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/locationbac.png"),
                        fit: BoxFit.fill)),
              ),
            ),
            Positioned(
             bottom: heightscreen/48,
              right:widthscreen/9,
              left:widthscreen/9,
              child:  Column(
                children: [

                  Align(
                      alignment: Alignment.bottomCenter,

                child: Text(
                   LocaleKeys.text1Loc.tr(),
                  style: TextStyle(
                    color: Color_white ,
              fontSize: 14,
              shadows: <Shadow>[

            Shadow(
              offset: Offset(0.5, 0.5),
              blurRadius: 1,
              color:  Colors.grey,
            ),
          ],),),
                 ),
                  Align(
                    alignment: Alignment.bottomCenter,

                    child: Text(
    LocaleKeys.text2Loc.tr(),
                      style: TextStyle(
                        color: Color_white ,
                        fontSize: 14,
                        shadows: <Shadow>[

                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 1,
                            color: Colors.grey,
                          ),
                        ],),),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,

                    child: Text(
    LocaleKeys.text3Loc.tr(),
                      style: TextStyle(
                        color: Color_white ,
                        fontSize: 14,
                        shadows: <Shadow>[

                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 0.5,
                            color: Colors.grey,
                          ),
                        ],),),
                  ),
              Align(
                alignment: Alignment.bottomCenter,
                  child:Container(
                    margin: EdgeInsets.only(bottom: 9, top: 4),
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      onPressed: () async {
                        await _getUserLocation().whenComplete(
                              () => locationTex,
                        );

                        if (locationTex != null) {
                          showDialogEdetLocation(context);
                        } else {
                          await print("locationTex^^^^^" + locationTex.toString());
                        }
                      },
                      color: Colors.white,
                      minWidth: widthscreen / 1.2,
                      height: heightscreen / 17,
                      child: Text(
                        'Allow Location',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                    ),
                  ),),
                ],
              ) ,
            )


          ],
        ),
      ),
    );
  }

  Future<http.Response> Post_user(url, Userr temp) async {
    var baseUrl = network_client.Url;
  await  print("posttttt Lat Lang"+temp.lng.toString());


    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'UserId' : temp.userID.toString(),
        'Name': temp.name,
        'PhoneNumber': temp.phoneNumber,
        'VarificationCode' : temp.varificationCode,
        'Upublic' : temp.uPublic,
        'UserName' : temp.userName,
        'Gender' : temp.gender,
        'Birthday' : temp.birthday.toIso8601String(),
        'Lat':temp.lat,
        'Lng':temp.lng,
        'Status':temp.status,
        'Token' : Splash_Screen.token,
        'LastSeen' : DateTime.now().toString(),
        'Online' : 1,//y.toDouble(),


      }),
    );

  }
}