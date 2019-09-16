import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  //ถ่ายเท data
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Explicit

// Method

  Widget singUpButton() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.red[300]),
        child: Text(
          'Sing Up',
          style: TextStyle(color: Colors.red[300]),
        ),
        onPressed: () {},
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
        onPressed: () {},
      ),
    );
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
          icon: Icon(Icons.email, color: Colors.red[400],),
          labelText: 'Email :',
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.red[400],),
          labelText: 'Password :',
        ),
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
      'Locater',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.red[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.brown[400]],radius: 1.0,
            ),
          ),
          child: Center(
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
    );
  }
}
