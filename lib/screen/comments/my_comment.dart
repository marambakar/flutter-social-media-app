import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/comment.dart';
import 'package:pronz/models/post.dart';
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/comments/comment_details.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCommentPage extends StatefulWidget {
 // Post post;

  //CommentPage({this.post});

  @override
  MyCommentBody createState() => MyCommentBody();
}

class MyCommentBody extends State<MyCommentPage> {

  bool serverError = false, connectedToNetwork = true;
  bool fetchPost = false;
  Future<List<Comment>> PostModel;
  List<Comment> temp;
Future <Post> MyPost;
Post post2;
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    initialize();
    setState(() {
      //  addColer();
    });
  }

var idd;
  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    NetworkConnection.isConnected().then((connected) {


      idd = prefs.getInt('id');
      if (connected) {
        PostModel =
            AppRequests.fetchMyComment(idd)
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


  double widthscreen, heightscreen;
 // Comment ff=new  Comment();
  @override
  Widget build(BuildContext context) {
    //  print("post with comment " + widget.post.comments.toString());
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

    return  Builder(builder: (context) {
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
                title: Text("My comment"),
              ),

        body:
        SingleChildScrollView(
              child:   fetchPost
              ? FutureBuilder(
              future: Future.wait([
              PostModel,
              ],),
    builder:
    (context, AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.hasData) {
    print(" PostModel####Comment" + PostModel.toString());
    return



     Container(
             color: Color_greenOption,
             height:
             heightscreen,
             child:   ListView.builder(
                 scrollDirection: Axis.vertical,
                 itemCount: snapshot.data[0].length,
                 itemBuilder:
                     (BuildContext context, int index) {

                       return  GestureDetector(
                           onTap: (){
                            AppRequests.fetchPostId(snapshot.data[0][index].postID).then((value) => {
                            Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>CommentPage(post: value,)))
                            });

                           },
                           child: CommentDetail(feed:snapshot.data[0][index]));
                 })










       );

         }
    else{return Container();}})
        :
    Container()));
  }





}});}}


