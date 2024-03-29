import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locater/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); // กำหมดให้จอภาพเป็นแนวตั้งอยู่ตลอด
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
