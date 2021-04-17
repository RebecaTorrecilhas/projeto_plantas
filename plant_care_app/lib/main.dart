import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Care',
      theme: ThemeData(
        fontFamily: 'Gotham',
        primarySwatch: Colors.green
      ),
      home: Login(),
    );
  }
}