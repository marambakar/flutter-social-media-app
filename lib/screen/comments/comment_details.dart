import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pronz/models/comment.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeago;



class CommentDetail extends StatefulWidget {
  Comment feed;

  CommentDetail({this.feed});

  CommentDetailState createState() => CommentDetailState();
}

class CommentDetailState extends State<CommentDetail> {
  //String postId;

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

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: widget.feed.coler,
          ),
          child:
          Stack(
            //fit: StackFit.loose,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Icon(
                                    Icons.home,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                               widget.feed.ownerName==null?
                                "name":widget.feed.ownerName
                                ,

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                widget.feed.timeStamp==null?
                                    "now"
                                :   timeago.format(DateTime.parse(widget.feed.timeStamp),locale: 'en_short') ,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
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
                            text: widget.feed.text,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                    //  height: height * (1 / 12),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //  crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Row(
                            children: [

                            ],
                          ),

                        ],
                      ),
                    )
                  ]),

              //),),
            ],
          ),
        ),
        context.locale==Locale('en')?
                  Align(
                   alignment: Alignment.centerLeft,
                   child:   Container(
                        width: width/1.35,
                        child: new Divider(color: Colors.black,
                          height: 20,
                          thickness: 2,

                        ),
                      )
                  ):  Align(
            alignment: Alignment.centerRight,
            child:   Container(
              width: width/1.35,
              child: new Divider(color: Colors.black,
                height: 20,
                thickness: 2,

              ),
            )
        )


      ],
    );
  }




}
