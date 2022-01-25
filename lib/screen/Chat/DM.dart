import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/main.dart';
import 'package:pronz/models/All_friends.dart';
import 'package:http/http.dart' as http;
import 'package:pronz/models/friend.dart';
import 'package:pronz/screen/Chat/add_chat.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/register/Register4.dart';
import '../../config.dart';
import '../Splash_Screen.dart';
import '../Splash_Screen.dart';
import '../Splash_Screen.dart';
class DM extends StatefulWidget {


  @override
  State createState() => _DM();
}

class _DM extends State<DM> {
  Future<Friends> FriendsModel;
  Friends model;
  int checkonline;
 static bool complete = false;
  bool complete1 = false;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    complete = false;

    initialize();
  }

  void initialize() {
    setState(() {
      MyApp.getInfoValuesSF();
      FriendsModel = Fitchdata().whenComplete(() {
        setState(() {
          complete=true;
        });
        //  FriendsModel = Fitchdata(38).then((value) {complete = true;});
      }

      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return
        // complete == true
        // ?
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Social App",
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: FutureBuilder<Friends>(
                    future: FriendsModel,
                    builder:
                        (context,  snapshot) {
                      if(snapshot.hasData){

                        return snapshot.data.friends.length!=0?ListView.builder(
                          itemCount: snapshot.data.friends.length ,
                          itemBuilder: (BuildContext context, int index)
                          {
                            return snapshot.data.friends.length!=0?
                              Card(
                              color: Color_green,

                              child: complete == true
                                  ? Column(

                                children: [
                                  ListTile(

                                      title: Text(snapshot
                                          .data.friends[index].name,style: TextStyle(color: Colors.white ,fontSize: 20),),
                                      subtitle: Row(
                                        children: <Widget>[
                                         Text(""),
                                           checkonline !=1?Text("Last Seen at :  " + DateTime.parse(snapshot.data.friends[index].lastSeen).year.toString() + "-" +
                                               DateTime.parse(snapshot.data.friends[index].lastSeen).month.toString() + "-" +
                                               DateTime.parse(snapshot.data.friends[index].lastSeen).day.toString() + "   " +
                                               DateTime.parse(snapshot.data.friends[index].lastSeen).hour.toString() + ":" +
                                               DateTime.parse(snapshot.data.friends[index].lastSeen).minute.toString() ,style: TextStyle(color: Colors.white),)
                                           :Text("Online")

                                        ],
                                      ),
                                      trailing: Text(""),
                                      onTap:(){
                                        print(index);
                                        print("777777777777777777777777");
                                        print(snapshot.data.friends[index].userID);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ChatScreen(index: snapshot
                                                .data.friends[index].userID,))
                                        );
                                      }
                                  ),


                                  Divider(
                                    height: 8,
                                  )
                                ],
                              )
                                  : Container(),
                            ) :Text("Sorry you have no friends");
                          },
                        ):Text("Sorry you have no friends");}

                       if (snapshot.hasError) {
                        return Center(child: Text("Sorry you have no friends" ,style: TextStyle(fontSize: 20),));
                      }
                      return Center(
                        child:CircularProgressIndicator()
                      ) ;

                    })
            ));
    });
  }

  Future<Friends> Fitchdata() async {
    print("thhhhheeeee id(((((((((((((((((())))))))))))))) " + Splash_Screen.idstatic.toString());
    int id = Splash_Screen.idstatic;
    final String apiUrl =
      "http://bronze.fingerprint.ml/api/Friend/getUserFriends/38?UserId=$id";
    var result = await http.get(Uri.parse(apiUrl));
    print(result.statusCode);
    if (result.statusCode == 200) {
      print("##############################");
      print(Friends.fromJson(json.decode(result.body)['dataList'])
          .friends[0]
          .toJson()
          .toString());
    checkonline = Friends.fromJson(json.decode(result.body)['dataList'])
        .friends[0].online;
      return Friends.fromJson(json.decode(result.body)['dataList']);
    } else {
      throw Exception("faid");
    }
  }

}
