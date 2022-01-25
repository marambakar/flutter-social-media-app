
import 'package:flutter/material.dart';
import 'package:pronz/app_locale.dart';
import 'package:pronz/models/notification.dart';
import 'package:pronz/config.dart' ;
import 'package:pronz/network/network_connection.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/network_screen/no_internet_connection.dart';
import 'package:pronz/network_screen/server_error.dart';
import 'package:pronz/screen/comments/comments_page.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:pronz/widget/Mail.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mynotification extends StatefulWidget {
  Mynotification();

  MynotificationState createState() => MynotificationState();
}

class MynotificationState extends State {
  String message = 'no option selected';
  double widthscreen, heightscreen;

  List<Mails> mails = new List<Mails>();
  bool serverError = false, connectedToNetwork = true;
  bool fetchPost = false;
  Future<List<Notificationn>> PostModel;
  List<Notificationn> temp;



var idd;
  void initialize() {
    NetworkConnection.isConnected().then((connected) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      idd = prefs.getInt('id');
      if (connected) {
        PostModel =
            AppRequests.fetchNotification(idd)
                .catchError((error, stackTrace) {
              setState(() {
                serverError = true;
              });
            })
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

  Widget build(BuildContext context) {

    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;

      if (connectedToNetwork == false) {
        return NoInternetConnection(voidCallback: initialize);
      } else {
        if (serverError) {
          print("server error");
          return ServerError(voidCallback: initialize);
        } else {
          return  Scaffold(
            body:
            fetchPost
                ? FutureBuilder(
                future: Future.wait([
                  PostModel,
                ]),
                builder:
                    (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  return Container(
                  child: snapshot.hasData ?



                      Container(
                        height:
                        heightscreen,
                        width: widthscreen,
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //   child: Align(
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         "Pronz",
                                //         style: TextStyle(color: Colors.black87, fontSize: 21),
                                //       )),
                                // ),
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Icon(
                                //     Icons.account_tree_sharp,
                                //     color: Colors.green,
                                //     size: 40,
                                //   ),
                                // ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width * (1 / 2.5),
                                height: MediaQuery.of(context).size.height * (1 / 14.5),
                                margin: EdgeInsets.only(
                                    top: heightscreen / 25, bottom: heightscreen / 99.5),
                                decoration: BoxDecoration(
                               color: Color_green,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                  ),
                                ),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      LocaleKeys.Noti.tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Roboto-Black'),
                                      //    textDirection: TextDirection.rtl,
                                    )),
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //   const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            //   child: Text(
                            //     'PRIMARY',
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         fontFamily: 'GoogleMedium',
                            //         color: Colors.black54),
                            //   ),
                            // ),
                            Expanded(
                              child: Container(
                                height:
                                heightscreen,
                                width: widthscreen,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data[0].length,
                                    itemBuilder: (BuildContext context, int index) {

                                      return   GestureDetector(
                                          onTap: (){
                                            AppRequests.fetchPostId(snapshot.data[0][index].postID).then((value) => {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>CommentPage(post: value,)))
                                            });
                                          },
                                          child:  Mails(not:snapshot.data[0][index] ,)

                                      );

                                    }), //ListView,
                              ),
                            )
                          ],
                        ),
                      ):Container()

                  );
                 }):Container(height: heightscreen,),

          );

        }};


  }

  @override
  void initState() {
    initialize();
  }
}
