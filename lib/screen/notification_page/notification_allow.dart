import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pronz/config.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/translations/locale_keys.g.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationAllowPage extends StatefulWidget {
  @override
  NotificationAllowPageBody createState() => NotificationAllowPageBody();
}

class NotificationAllowPageBody extends State<NotificationAllowPage> {
  @override
  initState() {
    super.initState();

    // Add listeners to this class
    setState(() {});
  }

  double widthscreen, heightscreen;

  @override
  Widget build(BuildContext context) {
    widthscreen = MediaQuery.of(context).size.width;
    heightscreen = MediaQuery.of(context).size.height;
    int initialIndex = 0;
    return Scaffold(
      body: Container(
       // color: Colors.green[400],
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/notifi.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              height: heightscreen / 5,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.notifications_sharp,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "!Dont miss out",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto-Black'),
                 // textDirection: TextDirection.rtl,
                )),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  // child: Text(
                  //   "Turn on notifications and never miss\nwhen a user responds to you",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.white,
                  //       fontSize: 14,
                  //       fontFamily: 'Roboto-Black'),
                  //   textDirection: TextDirection.rtl,
                  // )
                child: Text(
                  LocaleKeys.text1noti.tr(),
                  style: TextStyle(
                    color: Color_white ,
                    fontSize: 14,
                    shadows: <Shadow>[

                      Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 0.5,
                        color: Colors.grey,
                      ),
                    ],),),
              ),),
             Text(
                LocaleKeys.text2noti.tr(),
                style: TextStyle(
                  color: Color_white ,
                  fontSize: 14,
                  shadows: <Shadow>[

                    Shadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 0.5,
                      color: Colors.grey,
                    ),
                  ],),),

            Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                height: MediaQuery.of(context).size.height * (1 / 18),
                child: ToggleSwitch(
                    initialLabelIndex: initialIndex,
                    labels: ['Allow Notification', 'Not Now '],
                    cornerRadius: 10.0,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    activeBgColor: Colors.white,
                    activeFgColor:Color_black2,
                    inactiveBgColor: Color_black2,
                    inactiveFgColor: Colors.white,
                    onToggle: (index) {
                      print('switched index: $index');
                      setState(() {
                        initialIndex = index;
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => control_page()));
                        }
                        if (index == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => control_page()));
                        }
                      });
                    })),
          ],
        ),
      ),
    );
  }
}
