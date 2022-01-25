import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/option.dart';
import 'package:pronz/models/poll.dart';

import 'package:http/http.dart' as http;
import 'package:pronz/network/network_client.dart';
import 'package:pronz/network/requests.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OptionListPage extends StatefulWidget {
  Poll poll;

  OptionListPage({this.poll});
  @override
  OptionListState createState() => OptionListState();
}

class OptionListState extends State<OptionListPage> {
  double width,height;

  @override
  void initState() {
     votes=new Map();
     for(int i=0;i<widget.poll.options.length;i++)
       {
         votes[widget.poll.options[i].text]=widget.poll.options[i].votes;
         print(" votes[widget.poll.options[i].text]"+ votes[widget.poll.options[i].text].toString());
       }
  } // The group value
  var _result;
  int optionId;
  bool res;
  int resNu=0;
  Map<String,double> votes;

  Widget build(BuildContext context) {

    print("Niv"+widget.poll.title);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
        //  color: nextColor,
        borderRadius: const BorderRadius.only(

          bottomLeft: Radius.circular(60.0),
        // topRight: Radius.circular(50.0),
    ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
          padding: EdgeInsets.fromLTRB(width/6.5,0,0,0),
         child: Text(widget.poll.title+"?", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),),),

           Container(
             height: (widget.poll.options.length+0.0)*73,
          width: width/1.5,
          child:   ListView.builder(

                 scrollDirection: Axis.vertical,
                 itemCount: widget.poll.options.length,
                 itemBuilder: (BuildContext context, int index) {

                return   Column(
                     children: [

                       RadioListTile(
                     activeColor: Color_green,
                     value: widget.poll.options[index].text, //set this to parent object of the
                     //group which determines the selected option.
                     groupValue: _result,
                      toggleable: true,

                     onChanged: (value) async {
                           setState(() {
                             _result = value;

                           });




                         if(_result!=null)
                           {
                             print("dont ok ");
                             var res = await ADD_Vote("api/Options/addVote");
                             print(res.statusCode);

                             if (res.statusCode == 200) {
                               print("succccc");
                               print(res.body.toString());
                             }
                             resNu++;
                             setState(() {
                               if(resNu>=2)
                               {
                                 print("resNu"+resNu.toString());


                                   setState(() {
                                     for(int i=0;i<widget.poll.options.length;i++)
                                     { print("votes[widget.poll.options[index].text]"+votes[widget.poll.options[i].text].toString());
                                       widget.poll.options[i].votes=votes[widget.poll.options[i].text];
                                     }
                                   });

                                 widget.poll.options[index].votes =
                                     widget.poll.options[index].votes + 1;

                               }
                                 else{
                                 widget.poll.options[index].votes=widget.poll.options[index].votes+1;
                               }

                             });

                           }
                         else {
                           print("ok null" + _result.toString());


                  AppRequests.removevote(38, widget.poll.polid)

                          .then((value) => print("VaLLLLLL"+value.toString()));
                           widget.poll.options[index].votes=widget.poll.options[index].votes-1;

                         }},



                     title: new Container(
                          width: 10,
                        padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(

                         border: Border.all(
                           width: 1,
                           color: Color_black2,
                         ),
                       ),
                       child:  Text(
                         widget.poll.options[index].text,
                       ),),
                     ),
                   

                         Padding(
                           padding: EdgeInsets.fromLTRB(width/6.5,0,0,0),
                       child:  Align(
                           alignment: Alignment.topLeft,
                           child:Text(widget.poll.options[index].votes.toString()+"Votes"),



                         )
                   ,)

                     ],

                   );



                 }
             ),

             //ListV
           )


    ]
    )

    );
  }
  Future<http.Response> ADD_Vote(url,) async {
    for(int i=0;i<widget.poll.options.length;i++)
      {
        if(widget.poll.options[i].text==_result)
          {
            optionId=widget.poll.options[i].optionID;
          }
      }
    var baseUrl = network_client.Url;
    print("posttttt"+optionId.toString()+"***********"+widget.poll.polid.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return http.post(
      Uri.parse("$baseUrl/$url"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'UserID' : Splash_Screen.idstatic,
        'OptionID' :optionId,
        'PollID' : widget.poll.polid,
        "UserName": username,
        'Status' :"1",

      }),
    );
  }


}