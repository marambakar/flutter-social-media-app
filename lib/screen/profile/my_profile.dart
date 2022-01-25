import 'dart:developer';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:pronz/config.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/comments/my_comment.dart';
import 'package:pronz/screen/feed_screen/my_post_.dart';
import 'package:pronz/screen/profile/Setting_page.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:pronz/widget/rasied_bottum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app_locale.dart';
class ProfilPage extends StatefulWidget {
  @override
  ProfilePageBody createState() => ProfilePageBody();
}

class ProfilePageBody extends State<ProfilPage> {
  // final GlobalKey<ScaffoldState> scaffoldKey;
  //
  // final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  String token='';
  FirebaseMessaging _firebaseMessaging ;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    setState(() {});
  }

  int i;
  bool isfind;

  int selectedPage = 0;

  int initialIndex = 0;

  double widthscreen, heightscreen;

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:Image.asset("images/sitting.png",width: 40,),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                      LocaleKeys.Social.tr(),
                    style: TextStyle(color: Colors.black87, fontSize: 21),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset("images/tree2.png",width: 40,),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: MediaQuery.of(context).size.width * (1 / 2.5),
              height: MediaQuery.of(context).size.height * (1 / 14.5),
              margin: EdgeInsets.only(
                  top: heightscreen / 44, bottom: heightscreen / 99.5),
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.Pro.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Roboto-Black'),
                 //   textDirection: TextDirection.RTL,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: MediaQuery.of(context).size.width * (1 / 2.5),
              height: MediaQuery.of(context).size.height * (1 / 14.5),
              margin: EdgeInsets.only(top: 0.0, bottom: heightscreen / 44),
              padding: EdgeInsets.only(bottom: heightscreen / 99.5),
              decoration: BoxDecoration(
                color: Colors.grey[100],

                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.symmetric(horizontal: 8),
                          child:      Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontFamily: 'Roboto-Black'),
                              //  textDirection: TextDirection.rtl,
                            )),)


                      ),Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                       child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              LocaleKeys.recev.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 10,
                                  fontFamily: 'Roboto-Black'),
                              // textDirection: TextDirection.rtl,
                            )),)

                    ],
                  ),
                ),
                Padding(padding:EdgeInsets.symmetric(horizontal: 8),
                  child:  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                )

              ]),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (0.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * (6 / 7),
                    height: MediaQuery.of(context).size.height / 15,
                    child: new RaesdButtom( LocaleKeys.setting.tr() , (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>Setting_page()));

                    }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * (6 / 7),
                    height: MediaQuery.of(context).size.height / 15,
                    child: new RaesdButtom( LocaleKeys.Posts.tr() , (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>MyPostPage()));
                    }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * (6 / 7),
                    height: MediaQuery.of(context).size.height / 15,
                    child: new RaesdButtom( LocaleKeys.replies.tr() , (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>MyCommentPage()));
                    }),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width * (6 / 7),
                    height: MediaQuery.of(context).size.height / 15,
                    child: new RaesdButtom( LocaleKeys.Logout.tr(),  (){
                      print("here the log out");
                      removedata();
                      Phoenix.rebirth(context);
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>Splash_Screen()));

                    }),
                  ),
                ],
              )),
          Flexible(
              child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * (1 / 1.4),
                height: MediaQuery.of(context).size.height * (1 / 15),
                margin: EdgeInsets.only(
                    top: heightscreen / 18, bottom: heightscreen / 105),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    onPressed: () {
                      print('Button Clicked.');
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(
                        widthscreen / 22, 0, widthscreen / 33, 0),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Text(
                                    LocaleKeys.invite.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: widthscreen/22),
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: widthscreen/18,
                                ),
                              ),
                            ),
                          ],
                        ))),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (1 / 1.4),
                height: MediaQuery.of(context).size.height * (1 / 15),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    onPressed: () {
                      print('Button Clicked.');
                    },
                    textColor: Colors.black54,
                    color: Colors.white54,
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                child: Icon(
                                  CupertinoIcons.heart_circle_fill,
                                  color: Colors.blue,
                                  size: heightscreen/17,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Text(
                                      LocaleKeys.hert.tr(),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: heightscreen/44),
                                  ),
                                ),
                              ),
                            ),

// alignment: Alignment.topRight,
                          ],
                        ))),
              )
            ],
          ))
        ],
      ),
    );
  }
  removedata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
