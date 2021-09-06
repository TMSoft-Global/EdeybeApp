import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
Future<Map<String, dynamic>> setFirebase(
    {@required Future<dynamic> Function(String) onPressed,
    Function dispatchService}) async {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('icon_notif');

  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onPressed);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  await _firebaseMessaging.requestPermission(
      sound: true, badge: true, alert: true, provisional: false);
  final Completer<Map<String, dynamic>> completer =
      Completer<Map<String, dynamic>>();

  FirebaseMessaging.onBackgroundMessage(firebaseMessageHandler);
  FirebaseMessaging.onMessage.listen(firebaseMessageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    onPressed(event.data['data']);
  });

  _firebaseMessaging.getToken().then((String token) {
    // dispatchService(SetAppNotificationToken(token));
    // print("Push Messaging token: $token");
    // Push messaging to this token later
  });
  return completer.future;
}

Future<String> onSelect(String data) async {
  // print("onSelectNotification $data");
  return '';
}

//updated firebaseMessageHandler
Future<void> firebaseMessageHandler(RemoteMessage message) async {
  int msgId = int.tryParse(message.data["msgId"].toString()) ?? 0;
  // print(message["data"]['data']);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'PROMO', 'PROMO', 'Edeybe Notifications',
      color: Colors.blue.shade800,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.show(msgId, message.data["msgTitle"],
      message.data["msgBody"], platformChannelSpecifics,
      payload: message.data["data"]);
}
