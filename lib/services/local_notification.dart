import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialized(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      //        var random = Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      // int id1 = random.nextInt(pow(2, 31) - 1);
      // int id2 = random.nextInt(pow(2, 31) - 1);
      //final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("railrecipepartner",
              "railrecipepartner channel", "this is our partner app",
              importance: Importance.max, priority: Priority.high));

      await _flutterLocalNotificationsPlugin.show(
          12345,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["route"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
