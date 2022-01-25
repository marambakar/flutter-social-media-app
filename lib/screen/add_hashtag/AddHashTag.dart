import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:pronz/config.dart';
import 'package:pronz/data/feed_data.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AddHash extends StatefulWidget {
  AddHash();

  MyAddHashState createState() => MyAddHashState();
}

class MyAddHashState extends State {
  double widthscreen, heightscreen;
  String textfill;
  String textfillhash;

  String link;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _text = TextEditingController();
  final _text2 = TextEditingController();
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return


        SingleChildScrollView(
          child: context.locale==Locale('en')?
          Container(
              color: null,
              height: heightscreen*0.75,

              //   margin: EdgeInsets.only(bottom: 4,top: 10),
              decoration: BoxDecoration(
                color: Color_greenBoot,
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
                            // setState(() {
                            //   _volume += 10;
                            // });
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
                          //  margin: EdgeInsets.only(right: 5,top: 5),
                          // padding: EdgeInsets.only(right: 20,left: 50),
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,

                          decoration: BoxDecoration(
                            color: greenboostBlack,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60.0),
                              bottomLeft: Radius.circular(90.0),
                            ),
                          ),
                          child:

                                   IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                  //  setState(() {
                                      // feeds.last.type = 2;
                                      // feeds.add(new FeedModel(
                                      //   createdAt: "lala",
                                      //   imagePath: null,
                                      //   date: new DateTime.now().toString(),
                                      //   text: textfill,
                                      //   type: 3,
                                      //   coler: Colors.green[400],
                                      // ));

                                          addpos();


                                      try {
                                        Navigator.pop(context); //close the popup
                                      } catch (e) {}
                                //    });
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
                          padding: EdgeInsets.symmetric(horizontal: 8),
   child: TextField(

                        textAlign: TextAlign.start,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        onChanged: (value) {
                          print("The value entered is : $value");
                          textfill = value;
                        },
                        decoration: InputDecoration(
                          hintText: LocaleKeys.BootPost.tr(),
                          hintStyle:
                              TextStyle(color: Colors.white54, fontSize: 24),
                          border: InputBorder.none,
                        ),
                      ))),
                    ),


                   Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: widthscreen,
                     height: heightscreen/5,
                     child:  HashTagTextField(
                       decoratedStyle: TextStyle(fontSize: 24, color: Colors.amber),
                       basicStyle: TextStyle(fontSize: 24, color: Colors.black),
                       keyboardType: TextInputType.multiline,
                       decoration: InputDecoration(
                         hintText: LocaleKeys.Addhash.tr(),
                         hintStyle:
                         TextStyle(color: Colors.white54, fontSize: 24),
                         border: InputBorder.none,
                       ),

                       /// Called when detection (word starts with #, or # and @) is being typed
                       onDetectionTyped: (text) {
                         print(text);
                         textfillhash=text;
                       },

                       /// Called when detection is fully typed
                       onDetectionFinished: () {
                         print("detection finished");
                       },
                       maxLines: null,



                     ),)
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Container(
                          width: widthscreen / 2,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60.0),
                              topLeft: Radius.circular(60.0),
                              bottomLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(60.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _text,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  //     hintText: '  Add link',

                                  // labelText: "Enter your link",
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.white, size: 27),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        // TODO submit
                                      }
                                    },
                                  ),
                                  // hintStyle: TextStyle(color: Colors.white54,fontSize: 20),

                                  border: InputBorder.none,

                                  // errorStyle: TextStyle(
                                  //   color: Colors.red[400],
                                  //   fontWeight: FontWeight.normal,
                                  //fontSize: 13,

                                  hintText: LocaleKeys.addLink.tr(),
                                  hintStyle: TextStyle(
                                      color: Colors.white54, fontSize: 17.0),
                                  //helperText: "",
                                  // helperStyle: TextStyle(
                                  //     fontFamily: 'SF-Pro-Display',
                                  //     fontSize: 14.0,
                                  //     fontWeight: FontWeight.bold
                                  // ),
                                  errorStyle: TextStyle(
                                    fontFamily: 'SF-Pro-Display',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'the link is Empty';
                                  }
                                 bool _validURL = Uri.parse(text).isAbsolute;
                                  if(_validURL)
                                    {
                                      link=text;
                                    }

                                  if (!_validURL) return 'the link is error';
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black45,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child:Container(
                              width: widthscreen/6,
                              height: widthscreen/8,
                              child:  Image.asset("images/arrow2.png"),
                            )

                          ),
                        ),
                      ],
                    ),
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

              //   margin: EdgeInsets.only(bottom: 4,top: 10),
              decoration: BoxDecoration(
                color: Color_greenBoot,
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
                            // setState(() {
                            //   _volume += 10;
                            // });
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          //  margin: EdgeInsets.only(right: 5,top: 5),
                          // padding: EdgeInsets.only(right: 20,left: 50),
                          height: heightscreen / 8.55,
                          width: widthscreen / 3.75,

                          decoration: BoxDecoration(
                            color: greenboostBlack,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(90.0),
                            ),
                          ),
                          child:

                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              //  setState(() {
                              // feeds.last.type = 2;
                              // feeds.add(new FeedModel(
                              //   createdAt: "lala",
                              //   imagePath: null,
                              //   date: new DateTime.now().toString(),
                              //   text: textfill,
                              //   type: 3,
                              //   coler: Colors.green[400],
                              // ));

                              addpos();


                              try {
                                Navigator.pop(context); //close the popup
                              } catch (e) {}
                              //    });
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(

                              textAlign: TextAlign.start,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              expands: true,
                              onChanged: (value) {
                                print("The value entered is : $value");
                                textfill = value;
                              },
                              decoration: InputDecoration(
                                hintText: LocaleKeys.BootPost.tr(),
                                hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 24),
                                border: InputBorder.none,
                              ),
                            ))),
                  ),


                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: widthscreen,
                        height: heightscreen/5,
                        child:  HashTagTextField(
                          controller: _text2,
                          decoratedStyle: TextStyle(fontSize: 24, color: Colors.amber),
                          basicStyle: TextStyle(fontSize: 24, color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.Addhash.tr(),
                            hintStyle:
                            TextStyle(color: Colors.white54, fontSize: 24),
                            border: InputBorder.none,
                          ),

                          /// Called when detection (word starts with #, or # and @) is being typed
                          onDetectionTyped: (text) {
                            print(text);
                            textfillhash=text;
                          },

                          /// Called when detection is fully typed
                          onDetectionFinished: () {
                            print("detection finished");
                            textfillhash=_text2.text;
                          },
                          maxLines: null,



                        ),)
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Container(
                          width: widthscreen / 2,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(60.0),
                              topLeft: Radius.circular(60.0),
                              bottomLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(60.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _text,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  //     hintText: '  Add link',

                                  // labelText: "Enter your link",
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.white, size: 27),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        // TODO submit
                                      }
                                    },
                                  ),
                                  // hintStyle: TextStyle(color: Colors.white54,fontSize: 20),

                                  border: InputBorder.none,

                                  // errorStyle: TextStyle(
                                  //   color: Colors.red[400],
                                  //   fontWeight: FontWeight.normal,
                                  //fontSize: 13,

                                  hintText: LocaleKeys.addLink.tr(),
                                  hintStyle: TextStyle(
                                      color: Colors.white54, fontSize: 17.0),
                                  //helperText: "",
                                  // helperStyle: TextStyle(
                                  //     fontFamily: 'SF-Pro-Display',
                                  //     fontSize: 14.0,
                                  //     fontWeight: FontWeight.bold
                                  // ),
                                  errorStyle: TextStyle(
                                    fontFamily: 'SF-Pro-Display',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'the link is Empty';
                                  }
                                  bool _validURL = Uri.parse(text).isAbsolute;
                                  if(_validURL)
                                  {
                                    link=text;
                                  }

                                  if (!_validURL) return 'the link is error';
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black45,
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child:Container(
                                width: widthscreen/6,
                                height: widthscreen/8,
                                child:  Image.asset("images/arrow2.png"),
                              )

                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 30,
                  )
                ],
              )),
        );

    // )
    //   );
  }

var id;
  void addpos() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getInt('id');
    var req = http.MultipartRequest('POST', Uri.parse("http://bronze.fingerprint.ml/api/Post/addPostWithMedia"));
    textfill!=null?
    req.fields['PContent']=textfill:print("textfill is null");
    textfillhash!=null?
    req.fields['HashTag']=textfillhash:print("textfillhash is null");
    link!=null?
    req.fields["Link"]=link:print("link is null");
    req.fields['UserID']=id.toString();
    req.fields['Status']="1" ;
    var r = await req.send();
    var response = r.stream.bytesToString();
    print("response"+response.toString());
  }
}
