import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'package:pronz/helper/enum.dart';

import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/add_option/option_list.dart';
import 'dart:math' as math;

import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/image_feed/image_feed_detail.dart';
import 'package:pronz/screen/image_feed/image_feed_list.dart';
import 'package:pronz/screen/profile/other_profile.dart';
import 'package:pronz/screen/screen_vedio/VidieoDemo.dart';
import 'package:pronz/screen/screen_vedio/video_list.dart';
import 'package:pronz/widget/GestureDetector_widget.dart';
import 'package:pronz/widget/_TransitionListTile.dart';
import 'package:pronz/widget/column_widget.dart';
import 'package:pronz/widget/feedwidget1.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as Math;


class FeedPostDetail extends StatefulWidget {
  Post post;
 // bool isfindImg=false;

  bool findbool;
  bool iscomment;
  bool cusdetec;

  FeedPostDetail({this.post,this.iscomment,this.cusdetec});

  _FeedPostDetailState createState() => _FeedPostDetailState();

  static List<String>  img_exten= ['jpeg','png','svg','jpg','jfif'];
  static List<String>  video_exten= ['mp4','MOV','WMV','FLV'] ;
}

class _FeedPostDetailState extends State<FeedPostDetail>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  get showFront => true;


  @override
  void initState() {
    widget.findbool = false;

    super.initState();
  }



  double width;
  double height;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  VideoPlayerController _controllerVidio;
  @override
  Widget build(BuildContext context) {
    print("comNivo"+widget.iscomment.toString());


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print("nnnnnnnnnnn" + widget.post.type.toString()
        +widget.post.isfind.toString()+widget.post.pContent.toString());
      if (widget.post.type == 1) {
        if (widget.post.isfind == true) {

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(math.pi),


         child:     Container(
              decoration: BoxDecoration(
                //  color: nextCo

                image: DecorationImage(

                  image: NetworkImage(widget.post.imgback),
                  fit: BoxFit.fill,

                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),


                ),
              ),
             child:
             Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.rotationX(math.pi),



            child:

                  widget.post.medias.length==0?
                 Container(
                   decoration: BoxDecoration(
                     color: widget.post.coler,
                     borderRadius: const BorderRadius.only(
                       bottomLeft: Radius.circular(40.0),
                       topRight: Radius.circular(40.0),
                     ),
                   ),
                   child: Stack(
                     //fit: StackFit.loose,
                     children: [
                       //  Image.asset(image, fit: BoxFit.fitWidth),

                       // Container(
                       //
                       //
                       //   //constraints: BoxConstraints.expand(),
                       //   decoration: BoxDecoration(
                       //       image: DecorationImage(
                       //           image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                       //           fit: BoxFit.fill)
                       //   ),
                       //   child: ClipRRect(
                       //
                       //     child: BackdropFilter(
                       //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                       //       child: Container(
                       //         alignment: Alignment.center,
                       //         color: Colors.grey.withOpacity(0.1),
                       //         child: Text(
                       //           "Blur Background Image in Flutter",
                       //           textAlign: TextAlign.center,
                       //           style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                       //         ),
                       //       ),
                       //     ),
                       //
                       //   ),
                       // ),
                       ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                     ],
                   ),
                 )
                : FeedPostDetail.img_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last)
                  ? Container(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.darken,
                  color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    //image: AssetImage(widget.post.medias[0].url),
                    image: NetworkImage(widget.post.medias[0].url),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                   widget.cusdetec==null?
                    GesturDetectorWidget(
                      find: widget.findbool, post: widget.post,):Container(),

                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                    //),),
                  ],
                ),
              )
                  : FeedPostDetail.video_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last) ?

              Stack(
                //fit: StackFit.loose,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  VedioListPage(post: widget.post,)));
                        },
                        child: Container(
                            height: height / 4,

                            child: VidieoDemo(
                              VidioPath: widget.post.medias[0].url,
                              post: widget.post,))),
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                  ])



                 :Container())));
        }
        else {
          print("iiiiiiiiiii" + widget.post.medias[0].url);
          return Container(
              decoration: BoxDecoration(
             color: widget.post.nextcoler,

                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                ),


              ),


            child: widget.post.medias.length==0?


                   Container(
                decoration: BoxDecoration(
                  color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),


                    //),),
                  ],
                ),
              )
                  : FeedPostDetail.img_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last)

                  ? Container(
                decoration: BoxDecoration(
                  // backgroundBlendMode: BlendMode.darken,
                // color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    //image: AssetImage(widget.post.medias[0].url),

                    image: NetworkImage(widget.post.medias[0].url),
                    fit: BoxFit.fill,
                    // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                    // fit: BoxFit.fill),
                  ),
                ),
                child: Stack(
                  //fit: StackFit.loose,
                  children: [

                    widget.cusdetec==null?
                    GesturDetectorWidget(
                      find: widget.findbool, post: widget.post,):Container(),

                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                  ],
                ),
              )
                  : FeedPostDetail.video_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last) ?

              Stack(
                //fit: StackFit.loose,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  VedioListPage(post: widget.post,)));
                        },
                        child: Container(
                            height: height / 4,

                            child: VidieoDemo(
                              VidioPath: widget.post.medias[0].url,
                              post: widget.post,))),
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                  ])



                  :Container()


          );
        }
      }
      else if (widget.post.type == 2) {
        if (widget.post.isfind == true) {
       //   print("Enter to widget.post.isfind type 2"+widget.post.postID.toString()+widget.post.imgback+widget.post.pContent+widget.post.type.toString());
          return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(math.pi),


         child:   Container(

            decoration: BoxDecoration(
              //  color: nextColor,
              borderRadius: const BorderRadius.only(

                //  bottomLeft: Radius.circular(60.0),
                // topRight: Radius.circular(50.0),
              ),

              image: DecorationImage(
                // image: AssetImage(widget.imgbaground),
                image: NetworkImage(widget.post.imgback),
                fit: BoxFit.fill,


              ),
            ),
            child: Stack(
              children: [
              Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(math.pi),


                child:
          widget.post.medias.length==0?

              Container(
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
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),
                  ],
                ),
              )

              :FeedPostDetail.img_exten.contains(widget.post.medias[0].url
                    .split(".")
                    .last)
                    ? Container(
                  decoration: BoxDecoration(
                    color: widget.post.coler,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                    ),
                    image: DecorationImage(
                      // image: AssetImage(widget.post.medias[0].url),
                      image: NetworkImage(widget.post.medias[0].url),
                      fit: BoxFit.fill,
                      // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                      // fit: BoxFit.fill),
                    ),
                  ),
                  child: Stack(
                    //fit: StackFit.loose,
                    children: [
                      widget.cusdetec==null?
                      GesturDetectorWidget(
                        find: widget.findbool, post: widget.post,):Container(),

                      ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                    ],
                  ),
                )
                    : FeedPostDetail.video_exten.contains(widget.post.medias[0].url
                    .split(".")
                    .last) ?

                Stack(
                  //fit: StackFit.loose,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    VedioListPage(post: widget.post,)));
                          },
                          child: Container(
                              height: height / 4,

                              child: VidieoDemo(VidioPath: widget.post.medias[0]
                                  .url, post: widget.post,))),
                      ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                    ])



                  :Container()
             )

              ],
            ),
          ));
        } else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: widget.post.nextcoler,
              ),
              child:



              widget.post.medias.length==0?


                   Container(
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
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),
                  ],
                ),
              )
             : FeedPostDetail.img_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last)

                  ?
              Container(
                decoration: BoxDecoration(
                  color: widget.post.coler,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                  ),
                  image: DecorationImage(
                    // image: AssetImage(widget.post.medias[0].url),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                    image: NetworkImage(widget.post.medias[0].url),
                    fit: BoxFit.fill,
                    // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                    // fit: BoxFit.fill),
                  ),
                ),

                child: Stack(
                  //fit: StackFit.loose,
                  children: [
                    widget.cusdetec==null?
                    GesturDetectorWidget(
                      find: widget.findbool, post: widget.post,):Container(),
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),
                  ],
                ),
              )
                  : FeedPostDetail.video_exten.contains(widget.post.medias[0].url
                  .split(".")
                  .last) ?

              Stack(
                //fit: StackFit.loose,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  VedioListPage(post: widget.post,)));
                        },
                        child: Container(
                            height: height / 4,

                            child: VidieoDemo(
                              VidioPath: widget.post.medias[0].url,
                              post: widget.post,))),
                    ColumnWidget(post: widget.post,isComment: widget.iscomment,),

                  ])
                  :
                  Container()

            ),
          );
        }
      }
      else if (widget.post.type == 3) {
        return Container(

          decoration: BoxDecoration(

            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),

            ),
          ),



            child:
          widget.post.medias.length==0?
          Container(
            padding: const EdgeInsets.only(
            ),


            decoration: BoxDecoration(

              color: widget.post.coler,


              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),

              ),
            ),


            child: Stack(
              //fit: StackFit.loose,
              children: [

                ColumnWidget(post: widget.post,isComment: widget.iscomment,),
              ],),

          )
          :FeedPostDetail.img_exten.contains(widget.post.medias[0].url
              .split(".")
              .last)
              ? Container(

            width: width,

            decoration: BoxDecoration(


             // color: Colors.black54,

              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),

              ),

              image: DecorationImage(
                // image: AssetImage(widget.post.medias[0].url),
                image: NetworkImage(widget.post.medias[0].url),
                fit: BoxFit.fill,
                // image: NetworkImage("https://i.ytimg.com/vi/P9DC4YY8cd4/maxresdefault.jpg"),
                // fit: BoxFit.fill),
              ),
            ),
            child: Stack(

              children: [
                widget.cusdetec==null?
                GesturDetectorWidget(find: widget.findbool, post: widget.post,):Container(),
                ColumnWidget(post: widget.post,isComment: widget.iscomment,),

              ],),

          )

              : FeedPostDetail.video_exten.contains(widget.post.medias[0].url
              .split(".")
              .last) ?

          Stack(
            //fit: StackFit.loose,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              VedioListPage(post: widget.post,)));
                    },
                    child: Container(
                        height: height / 4,

                        child: VidieoDemo(VidioPath: widget.post.medias[0].url,
                          post: widget.post,))),
                ColumnWidget(post: widget.post,isComment: widget.iscomment,),

              ])

              :
        Container()

        );
      }


}
}
