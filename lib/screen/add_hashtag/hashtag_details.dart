import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/models/posts.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/feed_screen/feed_post_detail.dart';

class HashTagPage extends StatefulWidget {
  String hash;
  HashTagPage({this.hash});
  @override
  HashTagBody createState() => HashTagBody();
}

class HashTagBody extends State<HashTagPage> {
  bool serverError = false, connectedToNetwork = true;
  bool fetchPost2 = false;
  Future<List<Post>> PostModel;
  List<Post> temp;

  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      if (connected) {
        setState(() {
          print("heeeeeee" + widget.hash);

          PostModel = AppRequests.fetchHashTagPosts(widget.hash);
              //     .catchError((error, stackTrace) {
              //   setState(() {
              //     serverError = true;
              //   });
              // })
          //     .then((value) {
          //   temp = value;
          //   print("success hash : " + temp[0].toJson().toString());
          // }).whenComplete(() {
          //   setState(() {
          //     fetchPost2 = true;
          //     print("fetchPost : " + fetchPost2.toString());
          //   });
          // });
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

  Color generateRandomColor1() {
    // Define all colors you want here
    const predefinedColors = [
      // Colors.red,
      Color_green,
      Color_blou,
      Color_pink
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
                title: Text("Hash" + widget.hash),
              ),
              body: SingleChildScrollView(
                  child:
                  // fetchPost2
                  //     ?
                  FutureBuilder<List<Post>>(
                          future: // Future.wait([
                              PostModel,

                          // ]
                          // ),
                          builder: (context, snapshot) {
                            print("@@@@@@@@@@@@@");
                            print(snapshot.hasData);
                            print(PostModel.toString());
                            if (snapshot.hasData) {
                              print(" PostModel####3" + PostModel.toString());
                              return Column(
                                children: [


                                  Container(
                                    height: heightscreen / (3 / 2.5),
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount:  snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print("snapshot.data[0].length hash," +
                                              snapshot.data.length.toString());

                                          if (snapshot.data[index].medias
                                                      .length ==
                                                  0 ||
                                              snapshot.data[index].medias[0].url
                                                      .split(".")
                                                      .last !=
                                                  'm4a') {

                                          if (index <
                                                snapshot.data.length - 1) {
                                              if (index == 0) {

                                                snapshot.data[0].coler =
                                                    Colors.amber;
                                                snapshot.data[0].type = 1;
                                              }
                                              if (snapshot.data[index].type ==
                                                  null) {
                                                snapshot.data[index].type = 2;
                                              }
                                              if (snapshot
                                                      .data[index + 1].coler ==
                                                  null) {
                                                snapshot.data[index + 1].coler =
                                                    generateRandomColor1();
                                              }

                                              snapshot.data[index].nextcoler =
                                                  snapshot
                                                      .data[index + 1].coler;
                                              if (snapshot.data[index + 1]
                                                          .medias.length !=
                                                      0 &&
                                                  snapshot.data[index + 1]
                                                          .medias[0].url
                                                          .split(".")
                                                          .last !=
                                                      'mp4') {
                                                if (snapshot.data[index + 1]
                                                        .medias[0].url !=
                                                    null) {
                                                  snapshot.data[index].isfind =
                                                      true;
                                                  // fill[index].imagePath=fill[index+1].imagePath;
                                                  snapshot.data[index].imgback = snapshot
                                                      .data[index + 1]
                                                      .medias[0]
                                                      .url;
                                                  print("fill[$index]" +
                                                      snapshot.data[index + 1]
                                                          .medias[0].url
                                                          .toString());
                                                  return FeedPostDetail(
                                                    post: snapshot.data[index],

                                                  );
                                                } else {
                                                  snapshot.data[index].isfind =
                                                      false;
                                                }
                                              } else if (snapshot
                                                          .data[index + 1]
                                                          .medias
                                                          .length !=
                                                      0 &&
                                                  snapshot.data[index + 1]
                                                          .medias[0].url
                                                          .split(".")
                                                          .last ==
                                                      'mp4') {
                                                snapshot.data[index].isfind =
                                                    false;
                                                snapshot.data[index].nextcoler =
                                                    Colors.white;

                                                snapshot.data[index + 1].coler =
                                                    Colors.white;
                                              }
                                            } else {
                                              //   feeds[index].nextcoler = feeds[index + 1].coler;
                                              snapshot.data[index].type = 3;
                                              snapshot.data[0].coler =
                                                  generateRandomColor1();
                                            }

                                            print("fill[index]" +
                                                snapshot.data[index].type
                                                    .toString());

                                            return FeedPostDetail(
                                              post: snapshot.data[index],
                                            );
                                          } else {
                                            snapshot.data
                                                .remove(snapshot.data[index]);
                                          }
                                        }),

                                    //ListView,
                                  )
                                ],
                              );
                              // );

                            } else {
                              return Container();
                            }
                          })
                      // : Container()
          ));
        }
      }
    });
  }
}
