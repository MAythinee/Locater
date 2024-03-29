import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locater/screens/my_services.dart';
import 'package:locater/screens/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Exlicit
  final formKey = GlobalKey<FormState>();
  String nameString = '', emailString = '', passwordString = '';

  // Method

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 48.0,
          color: Colors.pink,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: Colors.pink),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: Colors.pink),
      ),
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 48.0,
          color: Colors.greenAccent,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.greenAccent),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: Colors.greenAccent),
      ),
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 48.0,
          color: Colors.purple,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.purple),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: Colors.purple),
      ),
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget content() {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(50.0),
        children: <Widget>[
          nameText(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        formKey.currentState.save();
        print(
            'name = $nameString, email = $emailString, password = $passwordString');
        registerThread();
      },
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String massage = response.message;
      print('title = $title, mssage = $massage');
      myAlert(title, massage);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.add_alert,
              color: Colors.red,size: 36.0,
            ),
            title: Text(title),
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nameString;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: content(),
    );
  }
}
