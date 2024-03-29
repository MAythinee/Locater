import 'package:flutter/material.dart';
import 'package:locater/screens/my_services.dart';
import 'package:locater/screens/my_style.dart';
import 'package:locater/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  //ถ่ายเท data
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Explicit
  final formKey = GlobalKey<FormState>();
  String emailString = '', passwordString = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

// Method

  @override
  void initState() {
    super.initState(); //ทำงานก่อน build
    chaekStatus();
  }

  Future<void> chaekStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget singUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.red[300]),
        child: Text(
          'Sing Up',
          style: TextStyle(color: Colors.red[300]),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(
              materialPageRoute); // พอกด signup ไปแล้วจะโชว์หน้า my service เลย
        },
      ),
    );
  }

  Widget singInButton() {
    return Expanded(
      child: RaisedButton(
        color: Colors.red[300],
        child: Text(
          'Sing IN',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          formKey.currentState.save();
          print('email = $emailString, password = $passwordString');
          checkAuthen();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String message = response.message;
      mySnackBar(message);
    });
  }

  void mySnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 8),
      backgroundColor: MyStyle().myTextColor,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          singInButton(),
          SizedBox(
            width: 4.0,
          ),
          singUpButton(),
        ],
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.red[400],
          ),
          labelText: 'Email :',
        ),
         style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        onSaved: (String value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.red[400],
          ),
          labelText: 'Password :',
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        onSaved: (String value) {
          passwordString = value.trim();
        },
      ),
    );
  }

  Widget showIcon() {
    return Container(
      width: 150.0,
      height: 150.0,
      child: Image.asset('images/icon.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'KHAI KHONG',
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.red[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepOrange[200],
            // gradient: RadialGradient(
            //   colors: [Colors.white, MyStyle().myMainColor],
            //   radius: 1.0,
            // ),
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showIcon(),
                  showAppName(),
                  emailText(),
                  passwordText(),
                  SizedBox(
                    height: 16.0,
                  ),
                  showButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
