import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pronz/app_locale.dart';
import 'package:pronz/config.dart';
import 'package:pronz/data/feed_data.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/profile/Addphoto.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_hashtag/AddHashTag.dart';
import 'add_option/AddOption.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class Addpost extends StatefulWidget {
  Post newPost;
  Addpost();
  _addpost createState() => _addpost();
}

class _addpost extends State<Addpost> {
  double widthscreen, heightscreen;
  String textfill;
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return
      SingleChildScrollView(

          child:  context.locale==Locale('en')?

          Container(
              color: null,
              height: heightscreen*0.75,
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(60.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              Navigator.pop(context); //close the popup
                            } catch (e) {}
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,
                          decoration: BoxDecoration(
                            color: greenphotoBlack,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60.0),
                              bottomLeft: Radius.circular(90.0),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () async {


                              addpos();

                                try {
                                  Navigator.pop(context); //close the popup
                                } catch (e) {}




                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: TextField(
                        textAlign: TextAlign.start,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        decoration: InputDecoration(
                          hintText:
                          LocaleKeys.hintAddPost.tr(),
                          hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 24),
                          border: InputBorder.none,
                        ),
                            onChanged: (value) {
                              print("The value entered is : $value");
                              textfill = value;
                            },
                      )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: widthscreen/6,
                            height: widthscreen/6,
                            child:    IconButton(
                                icon:  //AssetImage("images/arrow.png"),
                                Image.asset("images/arrow.png"),
                                // icon:  Icon(
                                //    CupertinoIcons.arrow_up_right,
                                //    color: Colors.white,
                                //    size: 45,
                                //  ),

                                onPressed: () {
                                  try {
                                    Navigator.pop(context); //close the popup
                                  } catch (e) {}
                                  showModalBottomSheet<void>(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {

                                      return SingleChildScrollView(
                                          child:Container(
                                              height: heightscreen*0.75,
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom),

                                              child: AddHash()
                                          ));


                                    },
                                  );
                                }),
                          )

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: widthscreen/6,
                            height: widthscreen/6,
                            child:  IconButton(
                                  icon:Image.asset("images/not.png"),
                                  onPressed: () {
                                    try {
                                      Navigator.pop(context); //close the popup
                                    } catch (e) {}
                                    showModalBottomSheet<void>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (context) {

                                            return SingleChildScrollView(
                                              child:Container(
                                               height: heightscreen*0.75,
                                                padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),

                                             child: AddOption()
                                            ));


                                      },
                                    );
                                  }),
                            ),
                            Container(
                              width: widthscreen/6,
                              height: widthscreen/6,
                          child:  IconButton(
                                icon: Image.asset("images/cam.png"),
                                onPressed: () {
                                  try {
                                    Navigator.pop(context); //close the popup
                                  } catch (e) {}
                                  showModalBottomSheet<void>(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {

                                      return SingleChildScrollView(
                                          child:Container(
                                              height: heightscreen*0.75,
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom),

                                              child: Addphoto()
                                          ));


                                    },
                                  );
                                  //end here
                                } //here done the second
                                ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 30,
                  )
                ],
              )):
          Container(
              color: null,
              height: heightscreen*0.75,
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            try {
                              Navigator.pop(context); //close the popup
                            } catch (e) {}
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,
                          decoration: BoxDecoration(
                            color: greenphotoBlack,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(90.0),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () async {
                              addpos();

                              try {
                                Navigator.pop(context); //close the popup
                              } catch (e) {}

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            textAlign: TextAlign.start,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            expands: true,
                            decoration: InputDecoration(
                              hintText:
                              LocaleKeys.hintAddPost.tr(),
                              hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 24),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              print("The value entered is : $value");
                              textfill = value;
                            },
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: widthscreen/6,
                            height: widthscreen/6,
                            child:    IconButton(
                                icon:  //AssetImage("images/arrow.png"),
                                Image.asset("images/arrow.png"),
                                // icon:  Icon(
                                //    CupertinoIcons.arrow_up_right,
                                //    color: Colors.white,
                                //    size: 45,
                                //  ),

                                onPressed: () {
                                  try {
                                    Navigator.pop(context); //close the popup
                                  } catch (e) {}
                                  showModalBottomSheet<void>(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {

                                      return SingleChildScrollView(
                                          child:Container(
                                              height: heightscreen*0.75,
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom),

                                              child: AddHash()
                                          ));


                                    },
                                  );
                                }),
                          )

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              width: widthscreen/6,
                              height: widthscreen/6,
                              child:  IconButton(
                                  icon:Image.asset("images/not.png"),
                                  onPressed: () {
                                    try {
                                      Navigator.pop(context); //close the popup
                                    } catch (e) {}
                                    showModalBottomSheet<void>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (context) {

                                        return SingleChildScrollView(
                                            child:Container(
                                                height: heightscreen*0.75,
                                                padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom),

                                                child: AddOption()
                                            ));


                                      },
                                    );
                                  }),
                            ),
                            Container(
                              width: widthscreen/6,
                              height: widthscreen/6,
                              child:  IconButton(
                                  icon: Image.asset("images/cam.png"),
                                  onPressed: () {
                                    try {
                                      Navigator.pop(context); //close the popup
                                    } catch (e) {}
                                    showModalBottomSheet<void>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (context) {

                                        return SingleChildScrollView(
                                            child:Container(
                                                height: heightscreen*0.75,
                                                padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom),

                                                child: Addphoto()
                                            ));


                                      },
                                    );
                                    //end here
                                  } //here done the second
                              ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 30,
                  )
                ],
              )));


  }

var id;
  void addpos() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getInt('id');
    print ("textfill"+textfill.toString()+id.toString());
    var req = http.MultipartRequest('POST', Uri.parse("http://bronze.fingerprint.ml/api/Post/addPostWithMedia"));
    req.fields['PContent']=textfill;
    req.fields['UserID']=id.toString() ;
    req.fields['Status']="1" ;
   var r = await req.send();
   var response = r.stream.bytesToString();
   print("response"+response.toString());
  //   http.Response response2 = await http.Response.fromStream(await req.send());
  //   print("Result: ${response2.statusCode}");
  }
}




