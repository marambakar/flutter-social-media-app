import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/profile/other_profile.dart';

class FeedPostwidget extends StatefulWidget {
  Post post;
  bool isfindImg;
  String imgbaground;
  bool findbool;

  FeedPostwidget({this.post, this.isfindImg, this.imgbaground});

  _FeedPostwidgetState createState() => _FeedPostwidgetState();
}

class _FeedPostwidgetState extends State<FeedPostwidget>
    with TickerProviderStateMixin {


  get showFront => true;

  @override
  void initState() {
    widget.findbool = false;

    super.initState();
  }



  double width;
  double height;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


      if (widget.isfindImg == true) {
        return Container(

            decoration: BoxDecoration(
            //  color: nextColor,
            borderRadius: const BorderRadius.only(

              //  bottomLeft: Radius.circular(60.0),
              // topRight: Radius.circular(50.0),
            ),

            image: DecorationImage(
              image: AssetImage(widget.imgbaground),
              fit: BoxFit.fill,

              // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
              // fit: BoxFit.fill),
              scale: 360,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.srcOver),
            ),
          ),
          child: Stack(
            children: [
              widget.post.medias[0].url != null
                  ? Container(
                decoration: BoxDecoration(
                  color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.post.medias[0].url),
                    fit: BoxFit.fill,
                    // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                    // fit: BoxFit.fill),
                  ),
                ),
                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.findbool = true;
                        });
                      },
                      child: Container(
                          height: height / 5,
                          width: width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.post.medias[0].url),
                              fit: BoxFit.fill,
                              // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                              // fit: BoxFit.fill),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: widget.findbool == false
                              ? ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 5, sigmaY: 5),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                          )
                              : Container()),
                    ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            // height:height*(1/12 ),
                            //  width:width ,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18),
                                        child: Icon(
                                          Icons.home,
                                          size: 40,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
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
                                          showModalBottomSheet<void>(
                                            context: context,
                                            backgroundColor:
                                            Colors.transparent,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return Stack(
                                                children: [
                                                  DraggableScrollableSheet(
                                                    initialChildSize:
                                                    0.75,
                                                    //set this as you want
                                                    maxChildSize: 0.75,
                                                    //set this as you want
                                                    minChildSize: 0.75,
                                                    //set this as you want
                                                    expand: true,
                                                    builder: (context,
                                                        scrollController) {
                                                      return OtherProfile();
                                                    },
                                                  ),
                                                  Positioned(
                                                    left: 10,
                                                    top: 115,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.greenAccent[
                                                      100],
                                                      radius: 40,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                            'images/bear.png'),
                                                        backgroundColor:
                                                        Colors.green[
                                                        800],
                                                        radius: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
                                    child: Text(
                                      ".6h",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0,
                                top: 18,
                                right: 18,
                                bottom: 0),
                            child: Container(
                              //   height:height*(10/12) ,
                              //   width: width,
                              child: RichText(
                                text: TextSpan(
                                  text: widget.post.pContent,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: height * (1 / 12),
                            width: width,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              //  crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 18),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: LikeButton(
                                          size: 25,
                                          circleColor: CircleColor(
                                              start: Colors.green[400],
                                              end: Colors.green[400]),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor:
                                            Colors.green[400],
                                            dotSecondaryColor:
                                            Colors.green[400],
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            print("tttttttttt");
                                            return ImageIcon(
                                              AssetImage(
                                                  "images/Likeicon.png"),
                                              color: isLiked
                                                  ? Colors.green[400]
                                                  : Colors.grey,
                                              size: 25,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            fontFamily: 'Roboto-Black'),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: LikeButton(
                                        size: 25,
                                        circleColor: CircleColor(
                                            start: Colors.red,
                                            end: Colors.red),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Colors.red,
                                          dotSecondaryColor: Colors.red,
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          print("tttttttttt");
                                          return ImageIcon(
                                            AssetImage(
                                                "images/Unlikeicon.png"),
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 25,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    tooltip: 'Increase volume by 10',
                                    onPressed: () {
                                      // setState(() {
                                      //   _volume += 10;
                                      // });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 10),
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
                                            tooltip:
                                            'Increase volume by 10',
                                            onPressed: () {
                                              setState(() {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentPage(
                                                                post: widget
                                                                    .post)));

                                                print("ok");
                                              });
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
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          50))),
                                              child: Text(
                                                "0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontFamily:
                                                  'Roboto-Black',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),

                    //),),
                  ],
                ),
              )
                  : Container(
                alignment: Alignment(-0.9, -0.9),
                decoration: BoxDecoration(
                  color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                  ),
                ),
                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            // height:height*(1/12 ),
                            //  width:width ,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18),
                                        child: Icon(
                                          Icons.home,
                                          size: 40,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
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
                                          showModalBottomSheet<void>(
                                            context: context,
                                            backgroundColor:
                                            Colors.transparent,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              return Stack(
                                                children: [
                                                  DraggableScrollableSheet(
                                                    initialChildSize:
                                                    0.75,
                                                    //set this as you want
                                                    maxChildSize: 0.75,
                                                    //set this as you want
                                                    minChildSize: 0.75,
                                                    //set this as you want
                                                    expand: true,
                                                    builder: (context,
                                                        scrollController) {
                                                      return OtherProfile();
                                                    },
                                                  ),
                                                  Positioned(
                                                    left: 10,
                                                    top: 115,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.greenAccent[
                                                      100],
                                                      radius: 40,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                            'images/bear.png'),
                                                        backgroundColor:
                                                        Colors.green[
                                                        800],
                                                        radius: 35,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
                                    child: Text(
                                      ".6h",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0,
                                top: 18,
                                right: 18,
                                bottom: 0),
                            child: Container(
                              //   height:height*(10/12) ,
                              //   width: width,
                              child: RichText(
                                text: TextSpan(
                                  text: widget.post.pContent,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: height * (1 / 12),
                            width: width,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              //  crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //  crossAxisAlignment: CrossAxisAlignment.end,

                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 18),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: LikeButton(
                                          size: 25,
                                          circleColor: CircleColor(
                                              start: Colors.green[400],
                                              end: Colors.green[400]),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor:
                                            Colors.green[400],
                                            dotSecondaryColor:
                                            Colors.green[400],
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            print("tttttttttt");
                                            return ImageIcon(
                                              AssetImage(
                                                  "images/Likeicon.png"),
                                              color: isLiked
                                                  ? Colors.green[400]
                                                  : Colors.grey,
                                              size: 25,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            fontFamily: 'Roboto-Black'),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: LikeButton(
                                        size: 25,
                                        circleColor: CircleColor(
                                            start: Colors.red,
                                            end: Colors.red),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Colors.red,
                                          dotSecondaryColor: Colors.red,
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          print("tttttttttt");
                                          return ImageIcon(
                                            AssetImage(
                                                "images/Unlikeicon.png"),
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 25,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    tooltip: 'Increase volume by 10',
                                    onPressed: () {
                                      // setState(() {
                                      //   _volume += 10;
                                      // });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 10),
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
                                            tooltip:
                                            'Increase volume by 10',
                                            onPressed: () {
                                              setState(() {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CommentPage(
                                                                post: widget
                                                                    .post)));

                                                print("ok");
                                              });
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
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          50))),
                                              child: Text(
                                                "0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontFamily:
                                                  'Roboto-Black',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),

                    //),),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: widget.post.nextcoler,
            ),
            child: widget.post.medias[0].url != null
                ? Container(
              // alignment: Alignment(-0.9, -0.9),

              decoration: BoxDecoration(
                color: widget.post.coler,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.post.medias[0].url),
                  fit: BoxFit.fill,
                  // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                  // fit: BoxFit.fill),
                ),
              ),

              child: Stack(
                //fit: StackFit.loose,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.findbool = true;
                      });
                    },
                    child: Container(
                        height: height / 5.2,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                          ),
                        ),
                        child: widget.findbool == false
                            ? ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 5, sigmaY: 5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.only(
                                  bottomLeft: Radius.circular(40.0),
                                ),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                          ),
                        )
                            : Container()

                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                      //           fit: BoxFit.fill)
                      //   ),

                    ),
                  ),

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          // height:height*(1/12 ),
                          //  width:width ,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 18),
                                      child: Icon(
                                        Icons.home,
                                        size: 40,
                                        color: Colors.white,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 18),
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
                                        showModalBottomSheet<void>(
                                          context: context,
                                          backgroundColor:
                                          Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Stack(
                                              children: [
                                                DraggableScrollableSheet(
                                                  initialChildSize: 0.75,
                                                  //set this as you want
                                                  maxChildSize: 0.75,
                                                  //set this as you want
                                                  minChildSize: 0.75,
                                                  //set this as you want
                                                  expand: true,
                                                  builder: (context,
                                                      scrollController) {
                                                    return OtherProfile();
                                                  },
                                                ),
                                                Positioned(
                                                  left: 10,
                                                  top: 115,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .greenAccent[100],
                                                    radius: 40,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                      AssetImage(
                                                          'images/bear.png'),
                                                      backgroundColor:
                                                      Colors
                                                          .green[800],
                                                      radius: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 18),
                                  child: Text(
                                    ".6h",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15),
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
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * (1 / 12),
                          width: width,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            //  crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //  crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: LikeButton(
                                        size: 25,
                                        circleColor: CircleColor(
                                            start: Colors.green[400],
                                            end: Colors.green[400]),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor:
                                          Colors.green[400],
                                          dotSecondaryColor:
                                          Colors.green[400],
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          print("tttttttttt");
                                          return ImageIcon(
                                            AssetImage(
                                                "images/Likeicon.png"),
                                            color: isLiked
                                                ? Colors.green[400]
                                                : Colors.grey,
                                            size: 25,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          fontFamily: 'Roboto-Black'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: LikeButton(
                                      size: 25,
                                      circleColor: CircleColor(
                                          start: Colors.red,
                                          end: Colors.red),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Colors.red,
                                        dotSecondaryColor: Colors.red,
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        print("tttttttttt");
                                        return ImageIcon(
                                          AssetImage(
                                              "images/Unlikeicon.png"),
                                          color: isLiked
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 25,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    // setState(() {
                                    //   _volume += 10;
                                    // });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
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
                                          tooltip:
                                          'Increase volume by 10',
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommentPage(
                                                              post: widget
                                                                  .post)));

                                              print("ok");
                                            });
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
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        50))),
                                            child: Text(
                                              "0",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontFamily:
                                                'Roboto-Black',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),

                  //),),
                ],
              ),
            )
                : Container(
              alignment: Alignment(-0.9, -0.9),
              decoration: BoxDecoration(
                color: widget.post.coler,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                ),
              ),
              child: Stack(
                //fit: StackFit.loose,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          // height:height*(1/12 ),
                          //  width:width ,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 18),
                                      child: Icon(
                                        Icons.home,
                                        size: 40,
                                        color: Colors.white,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 18),
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
                                        showModalBottomSheet<void>(
                                          context: context,
                                          backgroundColor:
                                          Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Stack(
                                              children: [
                                                DraggableScrollableSheet(
                                                  initialChildSize: 0.75,
                                                  //set this as you want
                                                  maxChildSize: 0.75,
                                                  //set this as you want
                                                  minChildSize: 0.75,
                                                  //set this as you want
                                                  expand: true,
                                                  builder: (context,
                                                      scrollController) {
                                                    return OtherProfile();
                                                  },
                                                ),
                                                Positioned(
                                                  left: 10,
                                                  top: 115,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .greenAccent[100],
                                                    radius: 40,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                      AssetImage(
                                                          'images/bear.png'),
                                                      backgroundColor:
                                                      Colors
                                                          .green[800],
                                                      radius: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 18),
                                  child: Text(
                                    ".6h",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15),
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
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * (1 / 12),
                          width: width,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            //  crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //  crossAxisAlignment: CrossAxisAlignment.end,

                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 18),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: LikeButton(
                                        size: 25,
                                        circleColor: CircleColor(
                                            start: Colors.green[400],
                                            end: Colors.green[400]),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor:
                                          Colors.green[400],
                                          dotSecondaryColor:
                                          Colors.green[400],
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          print("tttttttttt");
                                          return ImageIcon(
                                            AssetImage(
                                                "images/Likeicon.png"),
                                            color: isLiked
                                                ? Colors.green[400]
                                                : Colors.grey,
                                            size: 25,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          fontFamily: 'Roboto-Black'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: LikeButton(
                                      size: 25,
                                      circleColor: CircleColor(
                                          start: Colors.red,
                                          end: Colors.red),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Colors.red,
                                        dotSecondaryColor: Colors.red,
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        print("tttttttttt");
                                        return ImageIcon(
                                          AssetImage(
                                              "images/Unlikeicon.png"),
                                          color: isLiked
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 25,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    // setState(() {
                                    //   _volume += 10;
                                    // });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
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
                                          tooltip:
                                          'Increase volume by 10',
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommentPage(
                                                              post: widget
                                                                  .post)));

                                              print("ok");
                                            });
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
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        50))),
                                            child: Text(
                                              "0",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontFamily:
                                                'Roboto-Black',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),

                  //),),
                ],
              ),
            ),
          ),
        );
      }
    }



}
