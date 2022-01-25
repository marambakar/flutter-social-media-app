import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/data/feed_data.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/option.dart';
import 'package:pronz/models/poll.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';

import 'package:pronz/widget/option.dart';
import 'package:pronz/widget/rasied_bottum.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';

import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOption extends StatefulWidget {
  AddOption();

  MyAddOptionState createState() => MyAddOptionState();
}

class MyAddOptionState extends State {
  double widthscreen, heightscreen;

  final _formKey = GlobalKey<FormState>();

//  final myController = TextEditingController();
  List<Options> addOption = new List<Options>();
  List <Option> Optionn =new List();
  Poll poll;

  @override
  void initState() {
    addOption.add(new Options(
      optnumber: '1',Optionn:this.Optionn
    ));
    addOption.add(new Options(
      optnumber: '2',Optionn:this.Optionn
    ));
  }

  String textfill;
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return
      SingleChildScrollView(
        child: Container(
          width: widthscreen,
         height: heightscreen*0.75,

          child:    Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:   context.locale==Locale('en')?

                Container(
                    color: null,

                    //   margin: EdgeInsets.only(bottom: 4,top: 10),
                    decoration: BoxDecoration(
                      color: Color_greenOption,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(60.0),
                      ),
                    ),
                    child: 
                    Column(
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
                                  color: greenOptionBlack,
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
                                  onPressed: () {
                                    setState(() {


                                      addpos();

                                      try {
                                        Navigator.pop(context); //close the popup
                                      } catch (e) {}
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: heightscreen / 7,
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
                                  hintText:
                                 LocaleKeys.hintOption.tr(),
                                  hintStyle:
                                  TextStyle(color: Colors.white54, fontSize: 22),
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: widthscreen / 1.8,
                                height: heightscreen / 3.9,
                                margin: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  color: greenOptionBlack,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: widthscreen / 1.7,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: addOption.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              print("addOption.length" +
                                                  addOption.length.toString());
                                              return addOption[index];
                                            }),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 4),
                                      height: heightscreen / 12,
                                      width: widthscreen / 1.7,
                                      padding: EdgeInsets.all(10),
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {

                                            addOption.add(new Options(
                                                optnumber:
                                                (addOption.length + 1).toString(),Optionn:this.Optionn
                                            ));
                                            print("nnnnnnnnnnnnn" +
                                                addOption.length.toString());

                                          });
                                        },
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(30.0)),
                                        color: Colors.black38,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: widthscreen/33,
                                            ),
                                            Text(
                                              LocaleKeys.addop.tr(),
                                              style: TextStyle(
                                                fontSize: widthscreen/33,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 4, left: 14),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        LocaleKeys.PollActiv.tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'GoogleMedium',
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
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
                                      height: widthscreen/6,
                                      child:Image.asset("images/not2.png"),
                                    )

                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widthscreen,
                          height: heightscreen / 50,
                        )
                      ],
                    )): Container(
              color: null,

              //   margin: EdgeInsets.only(bottom: 4,top: 10),
              decoration: BoxDecoration(
                color: Color_greenOption,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                ),
              ),
              child:
              Column(
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
                            color: greenOptionBlack,
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
                            onPressed: () {
                              setState(() {


                                addpos();

                                try {
                                  Navigator.pop(context); //close the popup
                                } catch (e) {}
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: heightscreen / 7,
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
                            hintText:
                            LocaleKeys.hintOption.tr(),
                            hintStyle:
                            TextStyle(color: Colors.white54, fontSize: 22),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          width: widthscreen / 1.8,
                          height: heightscreen / 3.9,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: greenOptionBlack,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: widthscreen / 1.7,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: addOption.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print("addOption.length" +
                                            addOption.length.toString());
                                        return addOption[index];
                                      }),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 4),
                                height: heightscreen / 12,
                                width: widthscreen / 1.7,
                                padding: EdgeInsets.all(10),
                                child: FlatButton(
                                  onPressed: () {
                                    setState(() {

                                      addOption.add(new Options(
                                          optnumber:
                                          (addOption.length + 1).toString(),Optionn:this.Optionn
                                      ));
                                      print("nnnnnnnnnnnnn" +
                                          addOption.length.toString());

                                    });
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(30.0)),
                                  color: Colors.black38,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size:  widthscreen/33,
                                      ),
                                      Text(
                                        LocaleKeys.addop.tr(),
                                        style: TextStyle(
                                          fontSize:  widthscreen/33,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 4, left: 14),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  LocaleKeys.PollActiv.tr(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'GoogleMedium',
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black45,
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child:Container(

                                width: widthscreen/6,
                                height: widthscreen/6,
                                child:Image.asset("images/not2.png"),
                              )

                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: widthscreen,
                    height: heightscreen / 50,
                  )
                ],
              )),
              )
            ],
          ),
        ),
      );
    


    // )
    //   );
  }
  Post p;
  var idd;
  void addpos() async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    idd = prefs.getInt('id');
    var req = http.MultipartRequest('POST', Uri.parse("http://bronze.fingerprint.ml/api/Post/addPostWithMedia"));

 // req.fields['PContent']="Ahmaaaaaaaaad5";
    req.fields['Status']="1" ;
    req.fields['UserID']=idd.toString() ;

    http.Response response2 = await http.Response.fromStream(await req.send());
    print("Result: ${response2.statusCode}");

   //  Map<String, dynamic> map = json.decode(response2.body);
   // List<dynamic> data = map['dataList'];\
   // print(response2.body.toString());
    print("Niv"+Post.fromJson(json.decode(response2.body)['data']).postID.toString());

   p = Post.fromJson(json.decode(response2.body)['data']);
  var x=await  add_poll("api/Poll/AddPoll");
    print("statusCode"+x.body.toString());
  print("statusCode"+x.statusCode.toString());
  if(x.statusCode==200)
    {
      print("success");
    }


  }
  String OptionnToJson(List<Option> optionItem) {
    print(" getOPtionItemToJson" +
        json.encode(List<dynamic>.from(optionItem.map((x) => x.toJson()))));
    return json.encode(List<dynamic>.from(optionItem.map((x) => x.toJson())));
  }


  Future<http.Response> add_poll(url) async {

    for(int k=0;k<addOption.length;k++)
      {
        Optionn.add(addOption[k].op);
      }
    poll=new Poll(title:textfill,options: Optionn );
    print("Pollll"+poll.toJson().toString());
    String OptionString= await OptionnToJson(Optionn);


    print ("here"+json.encode(Optionn.map((v) => v.toJson()).toList()));

    print("p.postID"+p.postID.toString()+"***");
    var baseUrl = network_client.Url;
    print("posttttt");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "Title":poll.title,
        "PostID": p.postID,
        "Status": "1",
        "options":Optionn,

      }),
    );
  }
}
