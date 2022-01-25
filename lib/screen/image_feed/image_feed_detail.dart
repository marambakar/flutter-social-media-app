import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/profile/other_profile.dart';
import 'package:pronz/widget/column_widget.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedImageDetail extends StatefulWidget {
  String imgPath;
  Post post;
  String copressFile="Nivo.png";
  File   file;
  File compressedFile;
 
  FeedImageDetail({this.imgPath, this.post,this.file});

  _FeedImageDetailState createState() => _FeedImageDetailState();
}

class _FeedImageDetailState extends State<FeedImageDetail>
    with TickerProviderStateMixin {

  var result;
  get showFront => true;

  Future<File> loadFile() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    print(appDocDir);

   widget.file = File("${appDocDir.path}"+'/'+widget.copressFile);
    //file.writeAsBytesSync(audio);
    return widget.file;
  }

  @override
  Future<void> initState()   {
    super.initState();
   //  loadFile();
   // compressFile();
  }

  double width;
  double height;



  Future<File> compressFile() async{
    widget.compressedFile = await FlutterNativeImage.compressImage(widget.file.path,
      quality: 100,
    );

    return widget.compressedFile;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;





    return Stack(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Center(
                child: Container(
              height: height,
              width: width ,
           //  margin: EdgeInsets.only(left:width / 20,right:20 ),
              decoration: BoxDecoration(
                color: Color_green,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.imgPath),
                  fit: BoxFit.fill),
                ),
              ),
            )

        ),

        Container(
            height: height,

          margin: EdgeInsets.all(20),
          child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                padding: const EdgeInsets.only(left: 18),
                                child: Icon(
                                  Icons.home,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: TextButton(
                                child: Text(
                                  widget.post.location,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {

                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              timeago.format(DateTime.parse(widget.post.date,),locale: 'en_short') ,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, top: 18, right: 18, bottom: 0),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child:  Row(
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
                  )
                ])
        )

      ],
    );
  }



  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (isLiked) {
      var res = await deletelike(
        "api/Like/deleteLike/{id}",
        Splash_Screen.idstatic,
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
    if (isLiked) {
      setState(() {
        widget.post.disLikes = widget.post.disLikes - 1;
      });
      var res = await deletedislike(
        "api/DisLike/deleteDisLike",
        Splash_Screen.idstatic,
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
    var baseUrl = network_client.Url;
    print("posttttt");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID": Splash_Screen.idstatic,
        // 'UserName' : username,
        'UserName': "user1",
        'Status': "1",
        'PostID': widget.post.postID,
      }),
    );
  }

  Future<http.Response> add_dislike(url) async {
    var baseUrl = network_client.Url;
    print("postttttDis");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        // 'UserID' : temp.userID.toString(),
        "UserID": Splash_Screen.idstatic,
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
}
