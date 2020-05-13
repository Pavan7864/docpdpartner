import 'dart:io';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class FirebaseNotifications {

  FirebaseMessaging _firebaseMessaging;
  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
        print(token);
        MyAppPrefrences.saveToken(token);
    });

    _firebaseMessaging.configure(
      onBackgroundMessage:  Platform.isAndroid ? _backgroundMessageHandler:null,
      onMessage: (Map<String, dynamic> message)  {
        print('on message $message');
          myBackgroundMessageHandler(message);


      },
      onResume: (Map<String, dynamic> message)  {
        print('on resume $message');

        background(message);
      },
      onLaunch: (Map<String, dynamic> message)  {
        print('on launch $message');
        background(message);
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<void> _showNotification(String title,String message,String nid) async {
//    selectNotificationSubject.add(nid);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '125020', 'enamyang', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(nid==null?0:nid==''?0:int.parse(nid), title, message, platformChannelSpecifics, payload: nid==null?'70':nid==''?'70':nid);


  }



  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {

    if (message.containsKey('aps')) {
      // Handle notification message
      final dynamic notification = message['aps']['alert'];
      String msg = notification.containsKey('body') ? notification['body'] : 'Enanyng';
      String title = notification.containsKey('title') ? notification['title'] : 'Enanyng';
      String nid = message.containsKey('nid') ? message['nid'].toString() : '';
      _showNotification(title, msg, nid);
    }else if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      String msg = data.containsKey('body') ? data['body'] : 'Enanyng';
      String title = data.containsKey('title') ? data['title'] : 'Enanyng';
      String nid = data.containsKey('nid') ? data['nid'].toString() : '';
      _showNotification(title, msg, nid);
    } else if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      String msg = notification.containsKey('body') ? notification['body'] : 'Enanyng';
      String title = notification.containsKey('title') ? notification['title'] : 'Enanyng';
      String nid = notification.containsKey('nid') ? notification['nid'].toString() : '';
      _showNotification(title, msg, nid);
    }
  }

  Future<dynamic> background(Map<String, dynamic> message) async {

    if (message.containsKey('aps')) {
      // Handle notification message
      final dynamic notification = message['aps']['alert'];
      String nid=message.containsKey('nid')?message['nid'].toString():'';
      selectNotificationSubject.add(nid);
    }else if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      String nid=data.containsKey('nid')?data['nid'].toString():'';
      selectNotificationSubject.add(nid);
    }else if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      String nid=notification.containsKey('nid')?notification['nid'].toString():'';
      selectNotificationSubject.add(nid);
    }


    // Or do other work.
  }


   static Future<void> _backgroundMessageHandler(Map<String, dynamic> message) async {


    print("get BackGround Message ${message}");
     if (message.containsKey('aps')) {
       // Handle notification message
       final dynamic notification = message['aps']['alert'];
       String nid=message.containsKey('nid')?message['nid'].toString():'';
       selectNotificationSubject.add(nid);
     }else if (message.containsKey('data')) {
       // Handle data message
       final dynamic data = message['data'];
       String msg=data.containsKey('body')?data['body']:'Enanyng';
       String title=data.containsKey('title')?data['title']:'Enanyng';
       String nid=data.containsKey('nid')?data['nid'].toString():'';
       _showBackNotification(title,msg,nid);

     }else if (message.containsKey('notification')) {
       // Handle notification message
       final dynamic notification = message['notification'];
       String msg=notification.containsKey('body')?notification['body']:'Enanyng';
       String title=notification.containsKey('title')?notification['title']:'Enanyng';
       String nid=notification.containsKey('nid')?notification['nid'].toString():'';
       _showBackNotification(title,msg,nid);
     }


   }

  static Future<void> _showBackNotification(String title,String message,String nid) async {
    selectNotificationSubject.add(nid);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '125020', 'enamyang', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(nid==null?0:nid==''?0:int.parse(nid), title, message, platformChannelSpecifics, payload: nid==null?'70':nid==''?'70':nid);


  }



}