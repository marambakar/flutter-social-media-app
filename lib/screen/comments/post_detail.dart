import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:like_button/like_button.dart';
import 'package:linkable/linkable.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/add_hashtag/hashtag_details.dart';
import 'package:pronz/screen/add_option/option_list.dart';
import 'package:pronz/screen/feed_screen/feed_post_detail.dart';
import 'package:pronz/screen/screen_vedio/VidieoDemo.dart';
import 'package:pronz/screen/screen_vedio/video_list.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:pronz/widget/column_widget.dart';
import 'package:pronz/network/network_client.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDetail extends StatefulWidget {
  Post feed;


  PostDetail({this.feed});

  PostDetailState createState() => PostDetailState();
}

class PostDetailState extends State<PostDetail> {

  //String postId;

 var result;
 var  result2;


  @override
  void initState() {
    super.initState();
  }

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    // print("CCCCCCCc"+ widget.feed.medias[0].url
    //      .split(".")
    //      .last.toString());
    return

        Container(

            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color:Color_green,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
              ),
            ),
          child:
          Stack(
          children: [
            widget.feed.medias.length==0?
            Container(

              // height: height/5.1,
              decoration: BoxDecoration(
                color: widget.feed.coler,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Stack(
                //fit: StackFit.loose,
                children: [
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ColumnWidget(post: widget.feed),


                      ]),

                  //),),
                ],
              ),
            )
            :FeedPostDetail.img_exten.contains(widget.feed.medias[0].url
                .split(".")
                .last)
                ? Container(


                    decoration: BoxDecoration(
                      color: widget.feed.coler,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.feed.medias[0].url),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ColumnWidget(post: widget.feed),
                            ]),

                        //),),
                      ],
                    ),
                  )

                : FeedPostDetail.video_exten.contains(widget.feed.medias[0].url
                .split(".")
                .last) ?
            Stack(
              //fit: StackFit.loose,
                children: [

                      Container(
                          height: height / 4,

                          child: VidieoDemo(
                            VidioPath: widget.feed.medias[0].url,
                            post: widget.feed,)),
                  ColumnWidget(post: widget.feed),

                ])
                : Container() ]),

    );
  }

var idd;
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idd = prefs.getInt('id');
    if(isLiked)
    {
      var res = await deletelike("api/Like/deleteLike/{id}",idd,widget.feed.postID,);
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        //setState(() {
        print("succccc");

        //});

      }

    }
    else{
      var res = await add_like("api/Like/AddLike");
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        print("succccc");

      }
    }

    return !isLiked;
  }

  Future<bool> ondisLikeButtonTapped(bool isLiked) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idd = prefs.getInt('id');
    if(isLiked)
    {
      setState(() {
        widget.feed.disLikes=widget.feed.disLikes-1;
      });
      var res = await deletedislike("api/DisLike/deleteDisLike",idd,widget.feed.postID,);
      print(res.statusCode);
      print(res.toString());
      if (res.statusCode == 200) {
        //setState(() {
        print("succccc");

        //});

      }
    }
    else{
      setState(() {
        widget.feed.disLikes=widget.feed.disLikes+1;
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
    var baseUrl = network_client.Url;
    print("posttttt");


    SharedPreferences prefs = await SharedPreferences.getInstance();
   String username = prefs.getString('username');
    idd = prefs.getInt('id');
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID":idd,
        // 'UserName' : username,
        'UserName' : username,
        'Status' : "1",
        'PostID':widget.feed.postID,

      }),
    );
  }


  Future<http.Response> add_dislike(url) async {
    var baseUrl = network_client.Url;
    print("postttttDis");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID": 38,
        // 'UserName' : username,
        'UserName' : username,
        'Status' : "1",
        'PostID':widget.feed.postID,

      }),
    );
  }

  Future<http.Response> deletedislike(url, UserID, PostID) async {
    var baseUrl = network_client.Url;
    print("UUUUUUUUUUURRl"+"$baseUrl/$url?PostID=$PostID&UserID=$UserID");
    return http.delete(
      Uri.parse("$baseUrl/$url?PostID=$PostID&UserID=$UserID"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<http.Response> deletelike(url, UserID, PostID) async {
    var baseUrl = network_client.Url;
    print("UUUUUUUUUUURRl"+"$baseUrl/$url?PostID=$PostID&UserID=$UserID");
    return http.delete(
      Uri.parse("$baseUrl/$url?PostID=$PostID&UserID=$UserID"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

}
