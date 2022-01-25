import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:like_button/like_button.dart';
import 'package:linkable/linkable.dart';
import 'package:path/path.dart';
import 'package:pronz/app_locale.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/like.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/add_hashtag/hashtag_details.dart';
import 'package:pronz/screen/add_option/option_list.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/profile/other_profile.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pronz/network/network_client.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;


class ColumnWidget extends StatefulWidget {
  Post post;
  String sinceTime;
  bool isComment;

  ColumnWidget({this.post, this.isComment});

  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  double width;
  double height;

  Widget result;
  Widget result2;



  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    int ress = 1;

    print("commenttttttttt" + widget.isComment.toString());





    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            // height:height*(1/12 ),
            //  width:width ,
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TextButton(
                        child: Text(
                          widget.post.location==null?"Private":widget.post.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          //   Save_personid();
                          //    showModalBottomSheet<void>(
                          //      context: context,
                          //      backgroundColor:
                          //      Colors.transparent,
                          //      isScrollControlled: true,
                          //      builder: (context) {
                          //        return Stack(
                          //          children: [
                          //            DraggableScrollableSheet(
                          //              initialChildSize:
                          //              0.75,
                          //              //set this as you want
                          //              maxChildSize: 0.75,
                          //              //set this as you want
                          //              minChildSize: 0.75,
                          //              //set this as you want
                          //              expand: true,
                          //              builder: (context,
                          //                  scrollController) {
                          //                return OtherProfile(post: widget.post,);
                          //              },
                          //            ),
                          //            AppLocale().locale==Locale('en')?
                          //            Positioned(
                          //              left: 10,
                          //              top: 115,
                          //
                          //
                          //              child: CircleAvatar(
                          //                backgroundColor:
                          //                Colors.greenAccent[
                          //                100],
                          //                radius: 40,
                          //                child: CircleAvatar(
                          //                  backgroundImage:
                          //                  AssetImage(
                          //                      'images/bear.png'),
                          //                  backgroundColor:
                          //                  Colors.green[
                          //                  800],
                          //                  radius: 35,
                          //                ),
                          //              ),
                          //            ):  Positioned(
                          //              right: 10,
                          //              top: 115,
                          //
                          //
                          //              child: CircleAvatar(
                          //                backgroundColor:
                          //                Colors.greenAccent[
                          //                100],
                          //                radius: 40,
                          //                child: CircleAvatar(
                          //                  backgroundImage:
                          //                  AssetImage(
                          //                      'images/bear.png'),
                          //                  backgroundColor:
                          //                  Colors.green[
                          //                  800],
                          //                  radius: 35,
                          //                ),
                          //              ),
                          //            ),
                          //          ],
                          //        );
                          //      },
                          //    );
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return  Container(

                                child:
                                Stack(children: [
                                  Container(

                                    color:Colors.transparent ,


                                    child: OtherProfile(
                                      post: widget.post,
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 1,
                                  //   child: CircleAvatar(
                                  //     backgroundColor: Colors.greenAccent[100],
                                  //     radius: 40,
                                  //     child: CircleAvatar(
                                  //       backgroundImage:
                                  //       AssetImage('images/bear.png'),
                                  //       backgroundColor: Colors.green[800],
                                  //       radius: 35,
                                  //     ),
                                  //   ),
                                  // ),
                                ])
                              );



                            },
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                        timeago.format(DateTime.parse(widget.post.date,),locale: 'en_short') ,
                      style: TextStyle(color: Colors.white, fontSize:15),
                    ),
                  )
                ]),
          ),
          Padding(
            // padding: const EdgeInsets.only(
            //     left: 18.0,
            //     top: 18,
            //     right: 18,
            //     bottom: 0),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Container(
              //   height:height*(10/12) ,
              //   width: width,
              child: RichText(
                text: TextSpan(
                  text: widget.post.pContent,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
          ),
          widget.post.hash != null
              ? Padding(
                  // padding: const EdgeInsets.only(
                  //     left: 18.0,
                  //     top: 5,
                  //     right: 18,
                  //     bottom: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Container(
                      child: HashTagText(
                    text: widget.post.hash,
                    decoratedStyle: TextStyle(fontSize: 18, color: Colors.blue),
                    basicStyle: TextStyle(fontSize: 18, color: Colors.white),
                    onTap: (text) {
                      print("lala" + text.split('#').last);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              HashTagPage(hash: text.split('#').last)));
                    },
                  )))
              : Container(),
          widget.post.link != null
              ? new Padding(
                  // padding: const EdgeInsets.only(
                  //     left: 18.0,
                  //     top: 5,
                  //     right: 18,
                  //     bottom: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  //  child:
                  // InkWell(
                  //           child: new Text(widget.post.link),
                  //           onTap: () => launch(widget.post.link)
                  //       )

                  child: Linkable(
                    text: widget.post.link,
                  ))
              : Container(),
          widget.post.polls.length != 0
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:   OptionListPage(
              poll: widget.post.polls[0],
            )
          )

              : Container(),
          Container(
            margin: EdgeInsets.only(bottom: width / 66),
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),

                      child: LikeButton(
                        size: 35,
                        circleColor: CircleColor(
                            start: Colors.green[400], end: Colors.green[400]),
                        onTap: onLikeButtonTapped,
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.green[400],
                          dotSecondaryColor: Colors.green[400],
                        ),
                        likeBuilder: (bool isLiked) {
                          print("tttttttttt" +
                              isLiked.toString() +
                              widget.post.likes.toString());
                          //  onLikeButtonTapped(ress);

                          return CircleAvatar(
                              backgroundColor: Colors.white,
                              child: ImageIcon(
                                AssetImage("images/Likeicon.png"),
                                color:
                                    isLiked ? Colors.green[400] : Colors.grey,
                                size: 25,
                              ));
                        },
                        likeCount: widget.post.likes,
                        countBuilder: (int count, bool isLiked, String text) {
                          var color =
                              isLiked ? Colors.deepPurpleAccent : Colors.grey;

                          // isLike(isLiked);
                          // ress=2;
                          if (count == 0) {
                            result = Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ));
                          } else
                            result = Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      fontFamily: 'Roboto-Black'),
                                ));

                          return result;
                        },
                      ),
                      //  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: LikeButton(
                        size: 35,
                        circleColor:
                            CircleColor(start: Colors.red, end: Colors.red),
                        onTap: ondisLikeButtonTapped,
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Colors.red,
                          dotSecondaryColor: Colors.red,
                        ),
                        likeBuilder: (bool isLiked) {
                          // print("tttttttttt");
                          return CircleAvatar(
                              backgroundColor: Colors.white,
                              child: ImageIcon(
                                AssetImage("images/Unlikeicon.png"),
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 25,
                              ));
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          widget.post.disLikes.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: 'Roboto-Black'),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 20,
                    ),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      // setState(() {
                      //   _volume += 10;
                      // });
                    },
                  ),
                ),
                widget.isComment == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Stack(
                              alignment: Alignment.topRight,
                              fit: StackFit.expand,
                              overflow: Overflow.clip,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.dehaze_outlined,
                                    color: Colors.black54,
                                  ),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CommentPage(
                                                post: widget.post)));

                                    print("ok");
                                  },
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(

                                        // color: nextColor,

                                        color: Colors.black54,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Text(
                                      widget.post.Comments.length.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: 'Roboto-Black',
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ]);
  }
var idd;
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idd = prefs.getInt('id');
    if (isLiked) {
      var res = await deletelike(
        "api/Like/deleteLike",
      idd,
        widget.post.postID,
      );
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        //setState(() {
        print("succccc");

        //});

      }
    } else {
      var res = await add_like("api/Like/AddLike");
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        print("succccc");
      }
    }

    return !isLiked;
  }

  Future<bool> ondisLikeButtonTapped(bool isLiked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idd = prefs.getInt('id');
    if (isLiked) {
      setState(() {
        widget.post.disLikes = widget.post.disLikes - 1;
      });
      var res = await deletedislike(
        "api/DisLike/deleteDisLike",
        idd,
        widget.post.postID,
      );
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        //setState(() {
        print("succccc");

        //});

      }
    } else {
      setState(() {
        widget.post.disLikes = widget.post.disLikes + 1;
      });
      var res = await add_dislike("api/DisLike/AddDisLike");
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        //setState(() {
        print("succccc");

        //});

      }
    }

    return !isLiked;
  }

  Future<http.Response> add_like(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idd = prefs.getInt('id');
    var baseUrl = network_client.Url;
    print("posttttt");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID": idd,
        // 'UserName' : username,
        'UserName': "user1",
        'Status': "1",
        'PostID': widget.post.postID,
      }),
    );
  }

  Future<http.Response> add_dislike(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idd = prefs.getInt('id');
    var baseUrl = network_client.Url;
    print("postttttDis");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID":idd,
        // 'UserName' : username,
        'UserName': "user1",
        'Status': "1",
        'PostID': widget.post.postID,
      }),
    );
  }

  Future<http.Response> deletedislike(url, UserID, PostID) async {
    var baseUrl = network_client.Url;
    print("UUUUUUUUUUURRl" + "$baseUrl/$url?PostID=$PostID&UserID=$UserID");
    return http.delete(
      Uri.parse("$baseUrl/$url?PostID=$PostID&UserID=$UserID"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<http.Response> deletelike(url, UserID, PostID) async {
    var baseUrl = network_client.Url;
    print("UUUUUUUUUUURRl" + "$baseUrl/$url?PostID=$PostID&UserID=$UserID");
    return http.delete(
      Uri.parse("$baseUrl/$url?PostID=$PostID&UserID=$UserID"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }


  String username;
var id;
  getInfoValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    id = prefs.getInt('id');

    return;
  }
}
