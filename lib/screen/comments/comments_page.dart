import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/comment.dart';
import 'package:pronz/models/feed_model.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/comments/comment_details.dart';
import 'package:pronz/screen/comments/post_detail.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentPage extends StatefulWidget {
  Post post;

  CommentPage({this.post});

  @override
  CommentPageBody createState() => CommentPageBody();
}

class CommentPageBody extends State<CommentPage> {

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    setState(() {
      //  addColer();
    });
  }




  double widthscreen, heightscreen;
  Comment ff=new  Comment();
  @override
  Widget build(BuildContext context) {
  //  print("post with comment " + widget.post.comments.toString());
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body:
        AnimationLimiter(
        child:    
        Column(
           children: [
             PostDetail(feed: widget.post),
             Expanded(
                 child:
                 Stack(

                   children: [
                     // Expanded(
                     //   child:
                     widget.post.Comments!=null?
                     Container(
                       color: Color_green,
                       child: ListView.builder(
                           scrollDirection: Axis.vertical,
                           itemCount: widget.post.Comments.length,
                           itemBuilder: (BuildContext context, int index) {
                             widget.post.Comments[index].coler = Color_green;
                             // return CommentDetail(feed: widget.post.comments[index]);

                             return AnimationConfiguration.staggeredList(
                               position: index,
                               duration: const Duration(milliseconds: 900),
                               child: SlideAnimation(
                                 verticalOffset: 100.0,
                                 child: FlipAnimation(
                                   child: CommentDetail(feed: widget.post.Comments[index]),
                                 ),
                               ),
                             );
                           }


                       ),
                     )
                         :
                     Container(
                       color: Colors.greenAccent,
                     ),


                     Align(

                       alignment: Alignment.bottomRight,
                       child: IconButton(
                         icon: Icon(
                           Icons.add_comment,
                         ),
                         iconSize:37,
                         color: Colors.black,
                         splashColor: Colors.purple,
                         onPressed: () {

                           showModalBottomSheet<void>(
                             context: context,
                             backgroundColor: Colors.transparent,


                             isScrollControlled:true ,
                             builder: ( context) {

                                   return




                                          SingleChildScrollView(
                                            child: Container(

                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                                                 decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   borderRadius: const BorderRadius.only(
                                                     topLeft: Radius.circular(40.0),
                                                     topRight: Radius.circular(40.0),
                                                   ),),
                                                 child: Stack(
                                                   children: [


                                                      Container(

                                                         width:widthscreen ,


                                                         child:

                                                    TextFormField(

                                                             minLines: 3,
                                                             maxLines: 4,



                                                             decoration: InputDecoration(


                                                                 border: OutlineInputBorder(
                                                                     borderRadius: const BorderRadius.only(
                                                                       topLeft: Radius.circular(40.0),
                                                                       topRight: Radius.circular(40.0),

                                                                     )
                                                                 ),
                                                                 hintText: 'Enter Your Comment'),
                                                             onChanged: (value)
                                                             {
                                                               if(widget.post.Comments.contains(ff))
                                                               {
                                                                 ff=new Comment();
                                                               }

                                                               ff.text=value;
                                                             },

                                                           ),
                                                         ),





                                                    Positioned(
                                                       bottom: widthscreen/50,
                                                       right: widthscreen/44,

                                                       child:  IconButton(
                                                           icon: Icon(
                                                             Icons.send,
                                                           ),
                                                           iconSize: 30,
                                                           color: Colors.greenAccent,
                                                           splashColor: Colors.purple,
                                                           onPressed: () async {
                                                             SharedPreferences prefs = await SharedPreferences.getInstance();
                                                             setState(() {

                                                               String username = prefs.getString('username');
                                                               ff.ownerName=username;


                                                               widget.post.Comments.add(ff);
                                                               Post_user("api/Comment/addComment", ff);
                                                               try {
                                                                 Navigator.pop(context); //close the popup
                                                               } catch (e) {}
                                                             },
                                                             );}

                                                       ),
                                                     )






                                                   ],
                                                 ),
                                               ),
                                          );





                                   //ListView,;
                                },
                           );

                         },
                       ),),




                   ],
                 )
             ),
           ],
         )

  ));
  }




  Future<http.Response> Post_user(url, Comment ff) async {

    var baseUrl = network_client.Url;
    print("posttttt");
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'UserID' : Splash_Screen.idstatic.toString(),
        'Text':ff.text,
        'PostID':widget.post.postID,
        'Status':"1",

      }),
    );
  }
}
