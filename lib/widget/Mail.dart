import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/models/notification.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeago;

class Mails extends StatelessWidget {
  Notificationn not;
  Mails(
      {this.not
   });

  double widthscreen, heightscreen;



  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;


    return

      Container(
        margin: EdgeInsets.fromLTRB(widthscreen / 20, widthscreen / 15,
            widthscreen / 15, widthscreen / 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: widthscreen/8,
                height: widthscreen/8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                ),
                // child: CircleAvatar(
                //     backgroundColor: Colors.white,

              child:  not.type=="Like"?

              Image.asset(
                      "images/Likeicon.png",color: Color_green,)

               : not.type=="DisLike"?

              Image.asset(
                      "images/Unlikeicon.png",color: Colors.red,)




                : not.type=="Comment"?


                 Image.asset(
                      "images/coment.png")

                :not.type=="Vote"?

              Image.asset(
                    "images/not2.png",)



              :Container()),



            Flexible(
              child: Padding(
                padding:  const EdgeInsets.symmetric(horizontal:10),
                child: 
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            not.senderName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'GoogleMedium'),
                          ),
                          Text(
                              timeago.format(DateTime.parse(not.timestamp,),locale: 'en_short') ,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'GoogleRegular'),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              not.message,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontFamily: 'GoogleMedium'),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      );

  }
}
