import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locater/screens/home.dart';
import 'package:locater/screens/information.dart';
import 'package:locater/screens/my_style.dart';
import 'package:locater/screens/show_list_food.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// Explicit

  String loginString = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget currenWidget = ShowListFood();

// Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<Void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
    });
  }

  Widget processSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: Colors.orange,
      ),
      title: Text('Sign Out'),
      subtitle: Text('Sign out and move to authen page'),
      onTap: () {
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget menuInformation() {
    return ListTile(
      leading: Icon(
        Icons.info,
        color: Colors.blue,
      ),
      title: Text('Information'),
      subtitle: Text('Information of user login'),onTap: (){
        setState(() { // ป๊อบอัพไปอีกหน้า
          currenWidget = Information();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuShowListFood() {
    return ListTile(
      leading: Icon(
        Icons.fastfood,
        color: Colors.red,
      ),
      title: Text('Show List'),
      subtitle: Text('Show all food in Locater'),
      onTap: () {
        setState(() {
          currenWidget = ShowListFood();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showLogin() {
    return Text(
      'Login by $loginString',
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Locater',
      style: TextStyle(
          fontSize: MyStyle().h1,
          color: MyStyle().myTextColor,
          fontWeight: FontWeight.bold),
    );
  }

  Widget showImage() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/icon.png'),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, MyStyle().myMainColor],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showImage(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrawerMenu() {
    // แทบเมนูข้าง
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          menuShowListFood(), Divider(), //ใส่เส้นแบ่ง
          menuInformation(),
          processSignOut(),
        ],
      ),
    ); // listview เลื่อนได้
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('My Service'),
      ),
      body: currenWidget,
      drawer: myDrawerMenu(),
    );
  }
}
