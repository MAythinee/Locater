import 'package:flutter/material.dart';
import 'package:locater/screens/my_style.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyStyle().myMainColor,
        title: Text('My Service'),
      ),body: Text('body'),
    );
  }
}
