import 'package:flutter/material.dart';

class RedPage extends StatefulWidget {
  @override
  _RedPageState createState() => _RedPageState();
}

class _RedPageState extends State<RedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        child: Center(
          child: Text('Red Page'),
        ),
      ),
    );
  }
}
