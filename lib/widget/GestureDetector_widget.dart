import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/screen/image_feed/image_feed_list.dart';

class GesturDetectorWidget extends StatefulWidget {

  bool find;

Post post;

int vedio;


  GesturDetectorWidget({this.find,this.post,this.vedio});



  _GesturDetectorWidgetState createState() => _GesturDetectorWidgetState();
  }

  class _GesturDetectorWidgetState extends State< GesturDetectorWidget>
  with TickerProviderStateMixin {


    double width;
    double height;

  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return   GestureDetector(
      onTap: () {
      setState(() {
       widget.find = true;

           Navigator.of(context).push(
               MaterialPageRoute(builder: (context) => FeedImagePage(post:widget.post)));


      });
      },
      child: Container(
        height: height / 3.8,
          width: width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
            ),
          ),
          child: widget.find == false
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
    );
  }
}