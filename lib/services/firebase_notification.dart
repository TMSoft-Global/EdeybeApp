import 'dart:async';
import 'dart:convert';
import 'package:edeybe/index.dart';
import 'package:edeybe/screens/home_screen/cart_tab/cart_tab_screen.dart';
import 'package:edeybe/screens/home_screen/index.dart';
import 'package:edeybe/screens/order_history_screen/order_history_screen.dart';
import 'package:edeybe/screens/wishlist_screen/wishlist_screen.dart';
import 'package:edeybe/services/user_operation.dart';
import 'package:edeybe/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotifyHome extends StatelessWidget {
  const NotifyHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
Future<Map<String, dynamic>> setFirebase(
    {@required Future<dynamic> Function(String) onPressed,
    Function(String token) noti,
    Function dispatchService}) async {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('icon_notif');

  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelect);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  await _firebaseMessaging.requestPermission(
      sound: true, badge: true, alert: true, provisional: false);
  final Completer<Map<String, dynamic>> completer =
      Completer<Map<String, dynamic>>();

  FirebaseMessaging.onBackgroundMessage(firebaseMessageHandler);
  FirebaseMessaging.onMessage.listen(firebaseMessageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    Map<String, dynamic> onOpenAppData = json.decode(event.data['data']);
    onPressed(onOpenAppData['topicType']);
  });

  _firebaseMessaging.getToken().then((String token) {
    dispatchService(token);
    noti(token);
    // print("Push Messaging token: $token");
    sendToken(token);
    // Push messaging to this token later
  });
  return completer.future;
}

Future<String> onSelect(String data) async {
  var decodeData = jsonDecode(data);
  if (decodeData['type'] == 'router'.toLowerCase()) {
    if (decodeData['message']['status'] == 'failed'.toLowerCase()) {
      // print(decodeData);
      Get.dialog(CustomDialog());
      if (decodeData['pageKey'] == 'home') {
        Get.to(HomeIndex());
      } else if (decodeData['pageKey'] == 'order_history') {
        Get.to(OrderHistoryScreen());
      } else if (decodeData['pageKey'] == 'cart') {
        Get.to(CartScreenTab());
      } else if (decodeData['pageKey'] == 'wish_list') {
        Get.to(WishlistScreen());
      } else {
        Get.to(HomeIndex());
      }
    } else {
      Get.to(OrderHistoryScreen());
    }
  }

  print("onSelectNotification ${decodeData['message']}");
  return '';
}

//updated firebaseMessageHandler
Future<void> firebaseMessageHandler(RemoteMessage message) async {
  Map<String, dynamic> messageData = json.decode(message.data["data"]);
  print(messageData);
  int msgId = int.tryParse(message.data["msgId"].toString()) ?? 0;
  // print(message["data"]);
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
  flutterLocalNotificationsPlugin.show(msgId, messageData["topicType"],
      messageData["message"]['response'], platformChannelSpecifics,
      payload: jsonEncode(messageData));
}

Future<void> sendToken(String token) async {
  UserOperations _userOperations = UserOperations();
  _userOperations.sendNotificationToken(token);
}
