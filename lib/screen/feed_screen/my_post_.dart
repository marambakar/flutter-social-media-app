import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/feed_screen/feed_post_detail.dart';

class MyPostPage extends StatefulWidget {
  @override
  MyPostBody createState() => MyPostBody();
}

class MyPostBody extends State<MyPostPage> {
  bool serverError = false, connectedToNetwork = true;
  bool fetchPost = false;
  Future<List<Post>> PostModel;
  List<Post> temp;

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      if (connected) {
        PostModel =
            AppRequests.fetchMyPosts(Splash_Screen.idstatic,Splash_Screen.idstatic)
            //     .catchError((error, stackTrace) {
            //   setState(() {
            //     serverError = true;
            //   });
            // })
                .then((value) => temp = value)
                .whenComplete(() {
              //   print("success : " + temp[0].medias.length.toString()+"success 22: " + temp[1].medias.length.toString()+"success33 : " + temp[2].medias.length.toString());
              setState(() {
                fetchPost = true;
                print("fetchPost : " + fetchPost.toString());
              });
            });


      }
      connectedToNetwork = connected;
    });
  }

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

    return
      Builder(builder: (context) {
      if (connectedToNetwork == false) {
        return NoInternetConnection(voidCallback: initialize);
      } else {
        if (serverError) {
          print("server error");
          return ServerError(voidCallback: initialize);
        } else {
          return Scaffold(
              appBar: AppBar(
                // Update the `leading` to have a better design
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: Color_green,
                // Change the app name
                title: Text("My Post" ),
              ),
              body: SingleChildScrollView(
                  child:   fetchPost
                      ? FutureBuilder(
                      future: Future.wait([
                        PostModel,
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          print(" PostModel####3" + PostModel.toString());
                          return


                            Column(children: [

                                  Container(
                                    height:
                                    heightscreen,
                                    child:   ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data[0].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {


                                          if(snapshot.data[0][index].medias.length==0||
                                              snapshot.data[0][index].medias[0]
                                                  .url
                                                  .split(".")
                                                  .last != 'm4a')
                                          {
                                            if (index <
                                                snapshot.data[0].length - 1) {
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
                                                if (snapshot.data[0][index + 1]
                                                    .medias[0].url !=
                                                    null) {
                                                  snapshot.data[0][index].isfind = true;
                                                  // fill[index].imagePath=fill[index+1].imagePath;
                                                  snapshot.data[0][index].imgback = snapshot
                                                      .data[0][index + 1]
                                                      .medias[0].url;
                                                  print("fill[$index]" +
                                                      snapshot.data[0][index +
                                                          1]
                                                          .medias[0].url
                                                          .toString());
                                                  var iscom=true;
                                                  print("iscom"+iscom.toString());
                                                  return   GestureDetector(
                                                      onTap: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>CommentPage(post:snapshot.data[0][index] ,)));
                                                      },
                                                      child:  FeedPostDetail(
                                                        post: snapshot.data[0][index],iscomment: iscom, cusdetec: true,)

                                                  );
                                                } else {
                                                  snapshot.data[0][index].isfind = false;
                                                }

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


                                            } else {
                                              //   feeds[index].nextcoler = feeds[index + 1].coler;
                                              snapshot.data[0][index].type = 3;
                                              snapshot.data[0][index]..coler =
                                              generateRandomColor1();
                                            }

                                            var iscom=true;
                                            print("iscom"+iscom.toString());

                                            return   GestureDetector(
                                                onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>CommentPage(post:snapshot.data[0][index] ,)));
                                            },
                                            child:  FeedPostDetail(
                                              post: snapshot.data[0][index],iscomment: iscom, cusdetec: true,)

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
                        else{return Container();}
                      })
                      : Container()

              ));
        }
      }

    });
  }
}