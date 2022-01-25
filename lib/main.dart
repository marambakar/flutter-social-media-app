
// @dart=2.9


import 'dart:async';
import 'dart:convert';


import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:pronz/Services/local_notification_services.dart';
import 'package:image/image.dart';
import 'package:pronz/screen/Chat/DM.dart';
import 'package:pronz/screen/Chat/chatmessage.dart';
import 'package:pronz/screen/Splash_Screen.dart';
import 'package:pronz/screen/add_location/AddLocation.dart';
import 'package:pronz/screen/control.dart';
import 'package:pronz/screen/feed_screen/feed_page.dart';
import 'package:pronz/screen/feed_screen/feed_post_detail.dart';
import 'package:pronz/screen/notification_page/notification_allow.dart';
import 'package:pronz/screen/profile/EditProfile.dart';
import 'package:pronz/screen/profile/Setting_page.dart';
import 'package:pronz/screen/profile/my_profile.dart';
import 'package:pronz/screen/register/First_page.dart';
import 'package:pronz/screen/Chat/add_chat.dart';
import 'package:pronz/screen/register/Register2.dart';
import 'package:pronz/screen/register/Register3.dart';
import 'package:pronz/screen/register/Register4.dart';
import 'package:pronz/screen/register/testfacebok.dart';
import 'package:pronz/translations/codegen_loader.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'models/message_models.dart';



// this should be top level
Future<void> backgroundHandler(RemoteMessage message) async {
  //out of app and it is close
  print("here backgrond");
  print(message.notification.toString());
  // Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => ChatScreen(index: id,))
  // );
  //final route = message.data["route"];
}
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(
    EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
        Locale('en'),
          Locale('ar')
        ],
        assetLoader: CodegenLoader(),

        child: Phoenix(child: MyApp())
    )

  );
}

class MyApp extends StatelessWidget {
  //static int id ;
  static int checkdisplay=0;
  static int checkanotheruser=0;
  static StreamController streamController;

  static getInfoValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //  id = prefs.getInt('id');
    print("here the id inside the func" + Splash_Screen.idstatic.toString());
    return Splash_Screen.idstatic;

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: 'Flutter Demo',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'Splash_Screen': (context) => Splash_Screen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
       // '/second': (context) => SecondScreen(),
      },
      debugShowCheckedModeBanner:false ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:HomePage(),


    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
 // Future <message_models>conversation;
  message_models finalconversation;
  FirebaseMessaging _firebaseMessaging;
  String token;
  @override
  void initState() {
    print("init");
    if(MyApp.streamController == null){
      print("new in null");
      MyApp.streamController = new StreamController<bool>();

    }


    LocalNotificationServices.initailze(context);
    print("befor token");

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("inside get intance");
      if(message!=null){
        final route = message.data["route"];
        print("here should be splash" + route.toString());
        print(route);
       // Navigator.of(context).pushNamed(route);
        // Navigator.of(this.context)
        //     .push(MaterialPageRoute(builder: (context) => control_page()));
      }
    }).whenComplete(() {
      //get the token
    FirebaseMessaging.instance.getToken().then((value) {
      print("**********"+value);
    })  ;
    });


    super.initState();

    print("in init");
    // _firebaseMessaging.getToken().then((value){print(value);});
    WidgetsBinding.instance.addObserver(this);
    //inside func
   FirebaseMessaging.onMessage.listen((message){
     print("inside the  message");
     if(message.notification!=null) {
       final id = message.data["ID"];
       print(message.notification.body);
       print(message.notification.title);
       print("hereiside the main" + MyApp.checkdisplay.toString());
       print(id);
       print(MyApp.checkanotheruser);
    //   if(int.parse(id.toString()) == MyApp.checkanotheruser){print("@@@@@@@@@@@@@@@@@@");}
       if(MyApp.checkdisplay==0){
         print("1111111111111");
         LocalNotificationServices.display(message);
        // gitConversation();
         //  LocalNotificationServices.display(message);
         // conversation = gitConversation().then((value) {
         //   print("******************************************");
         //   finalconversation= value;
         //   print(finalconversation.messages.length);
         //   setState(() {
         //     //complete = true;
         //     // print("this is he change" + complete.toString());
         //     for(int i= 0 ; i<finalconversation.messages.length ; i++){
         //
         //       ChatScreen.messages.add(new ChatMessage(text: finalconversation.messages[i].text,NameUser: finalconversation.messages[i].senderID,));
         //     }
         //     print("here the conversation" + conversation.toString());
         //   });
         // });
       }else if(MyApp.checkdisplay==1 && int.parse(id.toString()) == MyApp.checkanotheruser){
       //    LocalNotificationServices.display(message);
     //   gitConversation();
       //  LocalNotificationServices.display(message);
         print("2222222222222");
         /*if(MyApp.streamController.isClosed){
           print("**********issssssssssssclosed");
           MyApp.streamController = new StreamController<bool>();
         }*/
        MyApp.streamController.sink.add(true);
        MyApp.streamController.sink.add(false);
      //  print(ChatScreenState.conversation.messages.length.toString());

         // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ChatScreen(index: int.parse(id.toString())))
        // );
        // conversation = gitConversation().then((value) {
        //   print("******************************************");
        //   finalconversation= value;
        //   print(finalconversation.messages.length);
        //   setState(() {
        //     //complete = true;
        //    // print("this is he change" + complete.toString());
        //     for(int i= 0 ; i<finalconversation.messages.length ; i++){
        //
        //       ChatScreen.messages.add(new ChatMessage(text: finalconversation.messages[i].text,NameUser: finalconversation.messages[i].senderID,));
        //     }
        //     print("here the conversation" + conversation.toString());
        //
        //
        //   });
        // });
       }
       else if(MyApp.checkdisplay==1 && id != MyApp.checkanotheruser){
         //    LocalNotificationServices.display(message);
         //   gitConversation();
         //  LocalNotificationServices.display(message);

         print("3333333333333333");
         print(id);
         print(MyApp.checkanotheruser);
         LocalNotificationServices.display(message);
         MyApp.streamController.close();
         MyApp.streamController = new StreamController<bool>();
         //
         // MyApp.streamController.sink.add(true);
         // MyApp.streamController.sink.add(false);
         //  print(ChatScreenState.conversation.messages.length.toString());

         // Navigator.of(context).push(MaterialPageRoute(
         //     builder: (context) => ChatScreen(index: int.parse(id.toString())))
         // );
         // conversation = gitConversation().then((value) {
         //   print("******************************************");
         //   finalconversation= value;
         //   print(finalconversation.messages.length);
         //   setState(() {
         //     //complete = true;
         //    // print("this is he change" + complete.toString());
         //     for(int i= 0 ; i<finalconversation.messages.length ; i++){
         //
         //       ChatScreen.messages.add(new ChatMessage(text: finalconversation.messages[i].text,NameUser: finalconversation.messages[i].senderID,));
         //     }
         //     print("here the conversation" + conversation.toString());
         //
         //
         //   });
         // });
       }
       else  if(MyApp.checkdisplay==2){
         //    LocalNotificationServices.display(message);
         //   gitConversation();
        LocalNotificationServices.display(message);

         print("44444444444444444");
         // MyApp.streamController.sink.add(true);
         // MyApp.streamController.sink.add(false);
         //  print(ChatScreenState.conversation.messages.length.toString());

         // Navigator.of(context).push(MaterialPageRoute(
         //     builder: (context) => ChatScreen(index: int.parse(id.toString())))
         // );
         // conversation = gitConversation().then((value) {
         //   print("******************************************");
         //   finalconversation= value;
         //   print(finalconversation.messages.length);
         //   setState(() {
         //     //complete = true;
         //    // print("this is he change" + complete.toString());
         //     for(int i= 0 ; i<finalconversation.messages.length ; i++){
         //
         //       ChatScreen.messages.add(new ChatMessage(text: finalconversation.messages[i].text,NameUser: finalconversation.messages[i].senderID,));
         //     }
         //     print("here the conversation" + conversation.toString());
         //
         //
         //   });
         // });
       }
     }

   }
   );
   FirebaseMessaging.onMessageOpenedApp.listen((message) {
     print("in background but the app not close");
     MyApp.streamController.close();
     MyApp.streamController = new StreamController<bool>();
     final id = message.data["ID"];
     // print("here should be splash" + route.toString());
     // print(route);
     // Navigator.of(context).pushNamed(route);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatScreen(index: int.parse(id.toString()),))
        );
   });

  }
  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
    super.didChangeAccessibilityFeatures();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("in dispose");
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (state == AppLifecycleState.paused) {
        // Your Code goes here
        print("in pause");
        DateTime d =  DateTime.now();
        print(d.toString());
        MyApp.getInfoValuesSF();
        print("here the id " + Splash_Screen.idstatic.toString());
        print(Splash_Screen.idstatic.toString());
        UpdateSeen(Splash_Screen.idstatic);

      } else if (state == AppLifecycleState.inactive) {
        print("in inactive");
        MyApp.getInfoValuesSF();
        print("here the id " + Splash_Screen.idstatic.toString());
        print(Splash_Screen.idstatic.toString());
        // Your Code goes here
      } else {
        // Your Code goes here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Splash_Screen();
  }

   Future <int> UpdateSeen(int id ) async {
    final String api = "http://bronze.fingerprint.ml/api/Account/UpdateLastSeen/ss?UserID=$Splash_Screen.idstatic";
    var result = await http.get(Uri.parse(api));
    print(result.statusCode);
    print("inside the git");
    print(json.decode(result.body)['ErroCode'].toString());
    return (json.decode(result.body)['ErroCode']);
   }


}


