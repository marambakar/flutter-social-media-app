
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pronz/screen/Chat/add_chat.dart';

import '../main.dart';
class LocalNotificationServices{
  static final FlutterLocalNotificationsPlugin  _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static void initailze(BuildContext context)
  {
    // const AndroidInitializationSettings initializationSettingsAndroid =
    // AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher')
        );
    _notificationsPlugin.initialize(initializationSettings , onSelectNotification: (String payload)async{
      //print(int.parse(payload));
      //inside the app
      print("heeeeerrr&&&&&&&&&&&&&&&&&&&&&&&&77");
      print(MyApp.checkdisplay);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(index: int.parse(payload.toString())))
      );
    });
    // final InitializationSettings initializationSettings =
    // InitializationSettings(AndroidInitializationSettings());
  }
  static void display(RemoteMessage message)async{
    try {
      final id =1;
      final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "easyapproatch",
          "easyapproatch channel",
          "this is our channel",
          importance: Importance.max,
          priority: Priority.high,
        )
      );
        await  _notificationsPlugin.show(
        id,
        message.notification.title,
        message.notification.body,
        notificationDetails,
          payload: message.data['ID'],

        );
    } on Exception catch (e) {
      // TODO
      print("nooooooooooooooooooo");
      print(e);
    }
  }

}