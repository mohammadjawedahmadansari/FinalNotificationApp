import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notfication_app/redpage.dart';
import 'package:notfication_app/services/local_notification.dart';

import 'greenpage.dart';

// Recive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.toString());
  LocalNotificationService.display(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage((backgroundHandler));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "red": (_) => RedPage(),
        "green": (_) => GreenPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialized(context);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        print(routeFromMessage);
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    // Foreground work

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });
    // When the app is in background but opened and user taps
    /// on the notifications
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      print(routeFromMessage);
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
            child: Column(
          children: [
            Text(
              "You will recieve message soon",
              style: TextStyle(fontSize: 32.0),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => RedPage()));
              },
              child: Text('another page'),
            )
          ],
        )),
      ),
    );
  }
}
