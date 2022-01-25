import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pronz/config.dart';
import 'package:pronz/data/feed_data.dart';
import 'package:pronz/helper/enum.dart';
import 'package:pronz/main.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/media.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/models/posts.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/Addpost.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/Chat/DM.dart';
import 'package:pronz/screen/add_hashtag/AddHashTag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toggle_switch/toggle_switch.dart';

import 'feed_post_detail.dart';
import 'package:pronz/network/network_connection.dart';

import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class FeedPage extends StatefulWidget {
  static int lenghPost;
  @override
  FeedPageBody createState() => FeedPageBody();
}

class FeedPageBody extends State<FeedPage> {
  bool serverError = false, connectedToNetwork = true;
  bool fetchPost = false;
  bool fetchPost3 = false;
  Future<List<Post>> PostModel;
  Future<List<Post>> PostModel3;
  List<Post> temp;
  List<Post> temp3;

  void initialize() {
    NetworkConnection.isConnected().then((connected) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      id = prefs.getInt('id');
      if (connected) {
        print("Splash_Screen.idstatic+hi"+Splash_Screen.idstatic.toString());
        PostModel =
        AppRequests.fetchPosts(id)
            //     .catchError((error, stackTrace) {
            //   setState(() {
            //     serverError = true;
            //   });
            // })
           .then((value) => temp = value)
            .whenComplete(() {
      // print("success : " + temp.length.toString());
          setState(() {
            fetchPost = true;
            print("fetchPost : " + fetchPost.toString());
          });
        });

        PostModel3 =
            AppRequests.fetchMyPosts(id,id)

                .then((value) => temp3 = value)
                .whenComplete(() {
              //   print("success : " + temp[0].medias.length.toString()+"success 22: " + temp[1].medias.length.toString()+"success33 : " + temp[2].medias.length.toString());
              setState(() {
                fetchPost3 = true;
                print("fetchPost : " + fetchPost3.toString());
              });
            });


      }
      connectedToNetwork = connected;
    });
  }
int id;
  @override
  initState() {
    super.initState();
    // Add listeners to this class

    initialize();
  }

  List<Color> col;



  int i;
  bool isfind;

  int selectedPage = 0;

  int initialIndex = 0;
Future <List<Post>> fill ;



  Color generateRandomColor1() {
    // Define all colors you want here
    const predefinedColors = [
     // Colors.red,
      Color_green,


    Color_greenOption,

     Color_greenBoot ,

    greenphotoBlack ,

      greenOptionBlack,

     greenboostBlack,

     ];
    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  double widthscreen, heightscreen;

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return Builder(builder: (context) {
      if (connectedToNetwork == false) {
        return NoInternetConnection(voidCallback: initialize);
      } else {
        if (serverError) {
          print("server error");
          return ServerError(voidCallback: initialize);
        } else {
          return Scaffold(
              body: SingleChildScrollView(
            child:   fetchPost
                ? FutureBuilder(
                future: Future.wait([
                  PostModel,
                  PostModel3
                ]),
                builder:
                    (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  print("postData"+snapshot.hasData.toString()+snapshot.data.toString());
                  if (snapshot.hasData){
                  if (snapshot.data[0]!=null) {
                    print(" PostModel####3" + PostModel.toString());
                    FeedPage.lenghPost=  snapshot.data[0].length;
                    print("FeedPage.lenghPost"+FeedPage.lenghPost.toString());
                    return


            Column(children: [

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:  Image.asset("images/masseg.png",width: 35,),
                      tooltip: 'chat',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DM()));
                      },
                    ),

                     Align(
                        alignment: Alignment.center,
                        child: Container(
                        //  width: widthscreen / 4,
                          child: Row(children: [
                            Container(

                            ),
                            Icon(
                              Icons.pin_drop_outlined,
                              color: Color_green,
                              size: 20,
                            ),
                            Text(
                             LocaleKeys.Social.tr(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black54,
                              size: 20,
                            ),
                          ]),
                        ),
                      ),

                Stack(
                  children: [

                    Align(
                        alignment: Alignment.centerRight,
                        child:ImageIcon(
                          AssetImage(
                              "images/tree2.png"),
                          size: 50,
                          color: Color_green,
                        )
                    ),
                    Positioned(
                        bottom: 15,
                        right: 5,
                        child:Text(snapshot.data[1].length.toString(), style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),)
                    ),
                  ],
                )

                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: MediaQuery.of(context).size.height * (1 / 18),
                  child: ToggleSwitch(
                      initialLabelIndex: initialIndex,
                      labels: [LocaleKeys.New.tr(), LocaleKeys.Most.tr(), LocaleKeys.Loud.tr()],
                      cornerRadius: 10.0,
                      minWidth: 100,
                      activeBgColor: Color_green,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.black,
                      onToggle: (index) {
                        print('switched index: $index');
                        setState(() {
                          initialIndex = index;
                          if (index == 0) {
                           // fill = new List();
                            fill = snapshot.data[0];
                          }
                          if (index == 1) {
                            //fill = new List();
                            fill =  snapshot.data[0];
                          }
                        });
                      })),
              Container(
                margin: EdgeInsets.only(bottom: 4, top: 4),
                height: MediaQuery.of(context).size.height * (1.5 / 27),
                width: widthscreen/1.2,
                child: OutlineButton(
                  onPressed: () {
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

                                child:Addpost()
                            ));


                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.pin_drop_outlined,
                        color: Color_green,
                      ),
                      Text(
                        LocaleKeys.watson.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),

                       Image.asset("images/panda2.png",height:30 ,),

                    ],
                  ),
                  borderSide: BorderSide(color:Color_green, width: 1),
                ),
              ),

                            // Container(child: Text(snapshot.data[0].length.toString()),);

                               // SingleChildScrollView(
                               //   child:
                               //   Column(
                               //     children: [
                                     Container(
                              height:
                              (heightscreen/1.3)+0.0*snapshot.data[0].length,
                                      child:   ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data[0].length,
                                          itemBuilder:
                                              (BuildContext context, int index) {

                                           print("snapshot.data[0].length,"+snapshot.data[0].length.toString());

                                                  if(snapshot.data[0][index].medias.length==0||
                                                    snapshot.data[0][index].medias[0]
                                                        .url
                                                        .split(".")
                                                        .last != 'm4a')
                                                  {

                                                  if (index <=
                                                      snapshot.data[0].length -2 ) {
                                                    if (index == 0) {
                                                      snapshot.data[0][0].coler =
                                                          Colors.amber;
                                                      snapshot.data[0][0].type = 1;


                                                    }
                                                    if (snapshot.data[0][index]
                                                        .type == null) {
                                                      snapshot.data[0][index].type =
                                                      2;
                                                    }
                                                    if (snapshot.data[0][index + 1]
                                                        .coler == null) {
                                                      snapshot.data[0][index + 1]
                                                          .coler =
                                                          generateRandomColor1();
                                                    }

                                                    snapshot.data[0][index]
                                                        .nextcoler =
                                                        snapshot.data[0][index + 1]
                                                            .coler;
                                                 if(snapshot.data[0][index + 1].medias.length!=0 &&snapshot.data[0][index + 1].medias[0].url
                                                     .split(".")
                                                     .last != 'mp4'&&snapshot.data[0][index + 1].medias[0].url
                                                     .split(".")
                                                     .last != 'mp3'){

                                                     snapshot.data[0][index].isfind = true;
                                                     // fill[index].imagePath=fill[index+1].imagePath;
                                                     snapshot.data[0][index].imgback = snapshot
                                                         .data[0][index + 1]
                                                         .medias[0].url;
                                                     // String background = snapshot
                                                     //     .data[0][index + 1]
                                                     //     .medias[0].url;
                                                     // print("okfill[$index]" +
                                                     //     snapshot.data[0][index +
                                                     //         1]
                                                     //         .medias[0].url
                                                     //         .toString());
                                                     // return FeedPostDetail(
                                                     //   post: snapshot
                                                     //       .data[0][index],
                                                     //   imgbaground: background,
                                                     //     iscomment:false,
                                                     // );
                                               print("imgback"+index.toString()+  snapshot.data[0][index].imgback);

                                                 }
                                                 else if(snapshot.data[0][index + 1].medias.length!=0 &&snapshot.data[0][index + 1].medias[0].url
                                                     .split(".")
                                                .last == 'mp4'){

                                                   snapshot.data[0][index].isfind = false;
                                                   snapshot.data[0][index]
                                                       .nextcoler=Colors.white;

                                                   snapshot.data[0][index+1]
                                                       .coler=Colors.white;
                                                 }
                                                 else if(snapshot.data[0][index + 1].medias.length==0){
                                                   snapshot.data[0][index].isfind = false;
                                                 }


                                                  } else {
                                                    //   feeds[index].nextcoler = feeds[index + 1].coler;
                                                    snapshot.data[0][index].type = 3;
                                                    snapshot.data[0][index]
                                                        .coler =
                                                        generateRandomColor1();

                                                  }

                                                print("fill[index]" +
                                                    snapshot.data[0][index].type
                                                        .toString());

                                                return FeedPostDetail(
                                                    post: snapshot.data[0][index],
                                                  iscomment:false,


                                                  );

                                              }
                                                else
                                                  {
                                                    snapshot.data[0].remove( snapshot.data[0][index]);

                                                  }
                                          }),

                             //ListView,
                            )
                                   ],
                                 );
                               // );

                        }
                        else{return Container(
                     child: Column(children: [

                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon:  Image.asset("images/masseg.png",width: 35,),
                                tooltip: 'chat',
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DM()));
                                },
                              ),

                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  //  width: widthscreen / 4,
                                  child: Row(children: [
                                    Container(

                                    ),
                                    Icon(
                                      Icons.pin_drop_outlined,
                                      color: Color_green,
                                      size: 20,
                                    ),
                                    Text(
                                      LocaleKeys.Social.tr(),
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                  ]),
                                ),
                              ),

                              Stack(
                                children: [

                                  Align(
                                      alignment: Alignment.centerRight,
                                      child:ImageIcon(
                                        AssetImage(
                                            "images/tree2.png"),
                                        size: 50,
                                        color: Color_green,
                                      )
                                  ),
                                  Positioned(
                                      bottom: 15,
                                      right: 5,
                                      child:Text(snapshot.data[1]!=null?snapshot.data[1].length.toString():"0", style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),)
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: MediaQuery.of(context).size.height * (1 / 18),
                            child: ToggleSwitch(
                                initialLabelIndex: initialIndex,
                                labels: [LocaleKeys.New.tr(), LocaleKeys.Most.tr(), LocaleKeys.Loud.tr()],
                                cornerRadius: 10.0,
                                minWidth: 100,
                                activeBgColor: Color_green,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.white,
                                inactiveFgColor: Colors.black,
                                onToggle: (index) {
                                  print('switched index: $index');
                                  setState(() {
                                    initialIndex = index;
                                    if (index == 0) {
                                      // fill = new List();
                                      fill = snapshot.data[0];
                                    }
                                    if (index == 1) {
                                      //fill = new List();
                                      fill =  snapshot.data[0];
                                    }
                                  });
                                })),
                        Container(
                          margin: EdgeInsets.only(bottom: 4, top: 4),
                          height: MediaQuery.of(context).size.height * (1.5 / 27),
                          width: widthscreen/1.2,
                          child: OutlineButton(
                            onPressed: () {
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

                                          child:Addpost()
                                      ));


                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.pin_drop_outlined,
                                  color: Color_green,
                                ),
                                Text(
                                  LocaleKeys.watson.tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                ),

                                Image.asset("images/panda2.png",height:30 ,),

                              ],
                            ),
                            borderSide: BorderSide(color:Color_green, width: 1),
                          ),
                        ),

                    Container(child: Center(
                         child: Text(
                           "No Post to see",
                           style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.normal,
                             color: Colors.black54,
                           ),
                         ),
                       ))



                     ])
                  );}
                      }else {
                    return
                  //     Expanded(child: Container(
                  //     child: Center(child:  CircularProgressIndicator(),)
                  //
                  // ))
                      Column(children: [

                      Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(
                      icon:  Image.asset("images/masseg.png",width: 35,),
                      tooltip: 'chat',
                      onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DM()));
                      },
                      ),

                      Align(
                      alignment: Alignment.center,
                      child: Container(
                      //  width: widthscreen / 4,
                      child: Row(children: [
                      Container(

                      ),
                      Icon(
                      Icons.pin_drop_outlined,
                      color: Color_green,
                      size: 20,
                      ),
                      Text(
                      LocaleKeys.Social.tr(),
                      style: TextStyle(
                      color: Colors.black87, fontSize: 18),
                      ),
                      Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black54,
                      size: 20,
                      ),
                      ]),
                      ),
                      ),

                      Stack(
                      children: [

                      Align(
                      alignment: Alignment.centerRight,
                      child:ImageIcon(
                      AssetImage(
                      "images/tree2.png"),
                      size: 50,
                      color: Color_green,
                      )
                      ),
                      Positioned(
                      bottom: 15,
                      right: 5,
                      child:Text("0", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      ),)
                      ),
                      ],
                      )

                      ],
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      height: MediaQuery.of(context).size.height * (1 / 18),
                      child: ToggleSwitch(
                      initialLabelIndex: initialIndex,
                      labels: [LocaleKeys.New.tr(), LocaleKeys.Most.tr(), LocaleKeys.Loud.tr()],
                      cornerRadius: 10.0,
                      minWidth: 100,
                      activeBgColor: Color_green,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.black,
                      onToggle: (index) {
                      print('switched index: $index');
                      setState(() {
                      initialIndex = index;
                      if (index == 0) {
                      // fill = new List();
                      fill = snapshot.data[0];
                      }
                      if (index == 1) {
                      //fill = new List();
                      fill =  snapshot.data[0];
                      }
                      });
                      })),
                      Container(
                      margin: EdgeInsets.only(bottom: 4, top: 4),
                      height: MediaQuery.of(context).size.height * (1.5 / 27),
                      width: widthscreen/1.2,
                      child: OutlineButton(
                      onPressed: () {
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

                                    child:Addpost()
                                ));


                          },
                        );
                      },
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Icon(
                      Icons.pin_drop_outlined,
                      color: Color_green,
                      ),
                      Text(
                      LocaleKeys.watson.tr(),
                      style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      ),
                      ),

                      Image.asset("images/panda2.png",height:30 ,),

                      ],
                      ),
                      borderSide: BorderSide(color:Color_green, width: 1),
                      ),
                      ),

                      Container(child: Center(
                      child: Text(
                      "No Post to see",
                      style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      ),
                      ),
                      ))



                      ])
                   ;}})
                  : Container()

          ));
        }
      }

    });
  }
}
