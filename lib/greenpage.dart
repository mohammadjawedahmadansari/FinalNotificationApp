import 'package:flutter/material.dart';

class GreenPage extends StatefulWidget {
  @override
  _GreenPageState createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        child: Center(
          child: Text('Green Page'),
        ),
      ),
    );
  }
}
