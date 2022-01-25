import 'dart:developer';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pronz/app_locale.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/models/userupdate.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/Chat/add_chat.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/feed_screen/feed_post_detail.dart';
import 'package:pronz/widget/activity_log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class OtherProfile extends StatefulWidget {
  Post post;
  OtherProfile({this.post});
  _addprofile createState() => _addprofile();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _addprofile extends State<OtherProfile> {
  List<Activity> activities = new List<Activity>();
  double widthscreen, heightscreen;
  String textfill;
  int _value = 1;

  bool serverError = false, connectedToNetwork = true;
  bool fetchPost = false;
  Future<Userr> PostModel;

  Future<List<Post>> PostModel2;
  Userr temp;
  List<Post> temp2;
  bool fetchPost2 = false;
  bool serverError2 = false, connectedToNetwork2 = true;
  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      if (connected) {
        PostModel = AppRequests.fetchotherUserProfil(widget.post.userID)
            //     .catchError((error, stackTrace) {
            //   setState(() {
            //     serverError = true;
            //   });
            // })
            .then((value) => temp = value)
            .whenComplete(() {
          //   print("success : " + temp[0].medias.length.toString()+"success 22: " + temp[1].medias.length.toString()+"success33 : " + temp[2].medias.length.toString());
         // initialize2();
          setState(() {
            fetchPost = true;
            print("fetchPost : " + fetchPost.toString());
          });
        });
      }
      connectedToNetwork = connected;
    });
  }
var id;
  List<Post> initialize2() {
    NetworkConnection.isConnected().then((connected) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      id = prefs.getInt('id');
      if (connected) {

        PostModel2 = AppRequests.fetchMyPosts(widget.post.userID, id)
            //     .catchError((error, stackTrace) {
            //   setState(() {
            //     serverError = true;
            //   });
            // })
            .then((value) => temp2 = value)
            .whenComplete(() {
          //  print("success : " + temp2.length.toString());
          setState(() {
            fetchPost2 = true;
            print("fetchPost : " + fetchPost2.toString());
          });
        });
      }
      connectedToNetwork2 = connected;
      return temp2;
    });
  }

  Color generateRandomColor1() {
    // Define all colors you want here
    const predefinedColors = [
      // Colors.red,
      Color_green,

      Color_greenOption,

      Color_greenBoot,

      greenphotoBlack,

      greenOptionBlack,

      greenboostBlack,
    ];
    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  Widget build(BuildContext context) {
    print("maram"+widget.post.userID.toString());
    activities.add(
      Activity(
        sender: "Cecilia, Nik",
        time: "2:13 PM",
        msg: "Check out the planning document",
      ),
    );
    activities.add(
      Activity(
        sender: "Jeroen, Tino",
        time: "12:57 PM",
        msg: "Hi, I made a reservation",
      ),
    );
    activities.add(
      Activity(
        sender: "Jeroen, Tino",
        time: "12:57 PM",
        msg: "Hi, I made a reservation",
      ),
    );
    activities.add(
      Activity(
        sender: "Jeroen, Tino",
        time: "12:57 PM",
        msg: "Hi, I made a reservation",
      ),
    );
    activities.add(
      Activity(
        sender: "Jeroen, Tino",
        time: "12:57 PM",
        msg: "Hi, I made a reservation",
      ),
    );
    activities.add(
      Activity(
        sender: "Jeroen, Tino",
        time: "12:57 PM",
        msg: "Hi, I made a reservation",
      ),
    );
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    return Container(



            height: MediaQuery.of(context).size.height *
                0.75,
            child: fetchPost
                ? FutureBuilder(
                future: Future.wait([
                  PostModel,
                  PostModel2
                ]),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  print("hiii+PostModel" +
                      PostModel.toString() +
                      snapshot.hasData.toString());


                  return  (snapshot.hasData && snapshot.data[0] != null)
                      ?   Container(

                      child: AnimationLimiter(
                          child: context.locale == Locale('en')
                              ? Container(
                              color: null,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius:
                                const BorderRadius.only(
                                  topRight: Radius.circular(60.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left: 10,
                                                      top: 30),
                                                  child: Text(
                                                    snapshot.data[0]
                                                        .userName,
                                                    style:
                                                    TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'Information',
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey[700],
                                                  fontSize: 16,
                                                  fontFamily:
                                                  'GoogleMedium'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                              horizontal: 10,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                _showPopupMenu();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  //snapshot.data[0].
                                  temp.uPublic == 1
                                      ? Expanded(
                                    child: Container(
                                      height: MediaQuery.of(
                                          context)
                                          .size
                                          .height /
                                          3,
                                      child: ListView.builder(
                                          scrollDirection:
                                          Axis.vertical,
                                          itemCount:
                                          temp2.length,
                                          itemBuilder:
                                              (BuildContext
                                          context,
                                              int index) {
                                            // return activities[index];

                                            if (temp2[index]
                                                .medias
                                                .length ==
                                                0 ||
                                                temp2[index]
                                                    .medias[
                                                0]
                                                    .url
                                                    .split(
                                                    ".")
                                                    .last !=
                                                    'm4a') {
                                              if (index <
                                                  temp2.length -
                                                      1) {
                                                if (index ==
                                                    0) {
                                                  temp2[0].coler =
                                                      Colors
                                                          .amber;
                                                  temp2[0]
                                                      .type = 1;
                                                }
                                                if (temp2[index]
                                                    .type ==
                                                    null) {
                                                  temp2[index]
                                                      .type = 2;
                                                }
                                                if (temp2[index +
                                                    1]
                                                    .coler ==
                                                    null) {
                                                  temp2[index +
                                                      1]
                                                      .coler =
                                                      generateRandomColor1();
                                                }

                                                temp2[index]
                                                    .nextcoler = temp2[
                                                index +
                                                    1]
                                                    .coler;
                                                if (temp2[index + 1]
                                                    .medias
                                                    .length !=
                                                    0 &&
                                                    temp2[index + 1]
                                                        .medias[
                                                    0]
                                                        .url
                                                        .split(
                                                        ".")
                                                        .last !=
                                                        'mp4' &&
                                                    temp2[index + 1]
                                                        .medias[0]
                                                        .url
                                                        .split(".")
                                                        .last !=
                                                        'mp3') {
                                                  temp2[index]
                                                      .isfind =
                                                  true;
                                                  // fill[index].imagePath=fill[index+1].imagePath;
                                                  temp2[index]
                                                      .imgback = temp2[
                                                  index +
                                                      1]
                                                      .medias[
                                                  0]
                                                      .url;
                                                }
                                                // ignore: missing_return
                                                else if (temp2[index + 1]
                                                    .medias
                                                    .length !=
                                                    0 &&
                                                    temp2[index + 1]
                                                        .medias[0]
                                                        .url
                                                        .split(".")
                                                        .last ==
                                                        'mp4') {
                                                  temp2[index]
                                                      .isfind =
                                                  false;
                                                  temp2[index]
                                                      .nextcoler =
                                                      Colors
                                                          .white;

                                                  temp2[index +
                                                      1]
                                                      .coler =
                                                      Colors
                                                          .white;
                                                } else if (temp2[index +
                                                    1]
                                                    .medias
                                                    .length ==
                                                    0) {
                                                  temp2[index]
                                                      .isfind =
                                                  false;
                                                }
                                              } else {
                                                temp2[index]
                                                    .type = 3;
                                              }

                                              return AnimationConfiguration
                                                  .staggeredList(
                                                  position:
                                                  index,
                                                  duration: const Duration(
                                                      milliseconds:
                                                      500),
                                                  child:
                                                  SlideAnimation(
                                                    verticalOffset:
                                                    100.0,
                                                    child: FlipAnimation(
                                                        child: FeedPostDetail(
                                                          post:
                                                          temp2[index],
                                                          iscomment:
                                                          false,
                                                        )),
                                                  ));
                                            } else {
                                              temp2.remove(
                                                  temp2[
                                                  index]);
                                            }
                                          }),
                                      //ListView,
                                    ),
                                  )
                                      : Container(
                                      child: Text(
                                        "private",
                                      ))
                                ],
                              ))
                              : Container(
                              color: null,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius:
                                const BorderRadius.only(
                                  topLeft: Radius.circular(60.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal: 10,vertical: 6),
                                                  child: Text(
                                                    snapshot.data[0]
                                                        .userName,
                                                    style:
                                                    TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'Information',
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors
                                                      .grey[700],
                                                  fontSize: 16,
                                                  fontFamily:
                                                  'GoogleMedium'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                              horizontal: 10,
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                _showPopupMenu();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  snapshot.data[0].uPublic == 1
                                      ? Expanded(
                                    child: Container(
                                      height: MediaQuery.of(
                                          context)
                                          .size
                                          .height /
                                          3,
                                      child: ListView.builder(
                                          scrollDirection:
                                          Axis.vertical,
                                          itemCount:
                                          temp2.length,
                                          itemBuilder:
                                              (BuildContext
                                          context,
                                              int index) {
                                            if (temp2[index]
                                                .medias
                                                .length ==
                                                0 ||
                                                temp2[index]
                                                    .medias[
                                                0]
                                                    .url
                                                    .split(
                                                    ".")
                                                    .last !=
                                                    'm4a') {
                                              if (index <
                                                  temp2.length -
                                                      1) {
                                                if (index ==
                                                    0) {
                                                  temp2[0].coler =
                                                      Colors
                                                          .amber;
                                                  temp2[0]
                                                      .type = 1;
                                                }
                                                if (temp2[index]
                                                    .type ==
                                                    null) {
                                                  temp2[index]
                                                      .type = 2;
                                                }
                                                if (temp2[index +
                                                    1]
                                                    .coler ==
                                                    null) {
                                                  temp2[index +
                                                      1]
                                                      .coler =
                                                      generateRandomColor1();
                                                }

                                                temp2[index]
                                                    .nextcoler = temp2[
                                                index +
                                                    1]
                                                    .coler;
                                                if (temp2[index + 1]
                                                    .medias
                                                    .length !=
                                                    0 &&
                                                    temp2[index + 1]
                                                        .medias[
                                                    0]
                                                        .url
                                                        .split(
                                                        ".")
                                                        .last !=
                                                        'mp4' &&
                                                    temp2[index + 1]
                                                        .medias[0]
                                                        .url
                                                        .split(".")
                                                        .last !=
                                                        'mp3') {
                                                  temp2[index]
                                                      .isfind =
                                                  true;
                                                  // fill[index].imagePath=fill[index+1].imagePath;
                                                  temp2[index]
                                                      .imgback = temp2[
                                                  index +
                                                      1]
                                                      .medias[
                                                  0]
                                                      .url;
                                                } else if (temp2[index + 1]
                                                    .medias
                                                    .length !=
                                                    0 &&
                                                    temp2[index + 1]
                                                        .medias[0]
                                                        .url
                                                        .split(".")
                                                        .last ==
                                                        'mp4') {
                                                  temp2[index]
                                                      .isfind =
                                                  false;
                                                  temp2[index]
                                                      .nextcoler =
                                                      Colors
                                                          .white;

                                                  temp2[index +
                                                      1]
                                                      .coler =
                                                      Colors
                                                          .white;
                                                } else if (temp2[index +
                                                    1]
                                                    .medias
                                                    .length ==
                                                    0) {
                                                  temp2[index]
                                                      .isfind =
                                                  false;
                                                }
                                              } else {
                                                temp2[
                                                index]
                                                    .type = 3;
                                              }

                                              return AnimationConfiguration
                                                  .staggeredList(
                                                  position:
                                                  index,
                                                  duration: const Duration(
                                                      milliseconds:
                                                      500),
                                                  child:
                                                  SlideAnimation(
                                                    verticalOffset:
                                                    100.0,
                                                    child: FlipAnimation(
                                                        child: FeedPostDetail(
                                                          post:
                                                          temp2[index],
                                                          iscomment:
                                                          false,
                                                        )),
                                                  ));
                                            } else {
                                              temp2.remove(
                                                  temp2[
                                                  index]);
                                            }
                                          }),
                                      //ListView,
                                    ),
                                  )
                                      : Container(
                                      child: Text(
                                        "private",
                                      ))
                                ],
                              ))))
                      : context.locale == Locale('en')?
                  Container(
                    //      child:   Center(
                    //     child: CircularProgressIndicator(),
                    // ));

                      color: null,
                      decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius:
                          const BorderRadius.only(
                            topRight: Radius.circular(60.0),
                          )),

                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _showPopupMenu();
                                },
                              ),
                            ),
                          ),
                       Expanded(child:   Center(

                           child:    Text(
                             "sorry this account is private \n so we couldn't retrieve his posts",
                           )
                       ))

                        ],
                      ),
                  ):
                  Container(
                    //      child:   Center(
                    //     child: CircularProgressIndicator(),
                    // ));

                      color: null,
                      decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius:
                          const BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                          )),

                      child:  Column(
                          children: [
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          _showPopupMenu();
                        },
                      ),
                    ),
                  ),

                   Expanded(child:   Center(

                   child:    Text(
                  "عذرا هذا الحساب خاص لايمكن رؤية محتواه",
                  )
                  )) ,
                   ] ));


                })
                : Container(

            ));








  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      position: RelativeRect.fromLTRB(100, 250, 0, 0),
      items: [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.message,
                color: Colors.grey[400],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(post: widget.post , index:widget.post.userID) , ));
                  },
                  child: Text(
                    "Message",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ))
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.report,
                color: Colors.grey[400],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Report",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ))
            ],
          ),
        ),
      ],
      elevation: 0.5,
    );
  }

  @override
  void initState() {
    initialize();
     initialize2();
  }
}
