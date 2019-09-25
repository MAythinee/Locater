import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
// Explitcit

  File file;
  final formKey = GlobalKey<FormState>();

// Method
  Widget nameFoodText() {
    Color color = Colors.purpleAccent;
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.fastfood,
          color: color,
          size: 36.0,
        ),
        labelText: 'ชื่ออาหาร',
        labelStyle: TextStyle(color: color),
        helperText: 'กรุณากรอกชื่ออาหาร',
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณากรอกชื่ออาหารด้วยค่ะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {},
    );
  }

  Widget nameShopText() {
    Color color = Colors.pinkAccent;
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.home,
          color: color,
          size: 36.0,
        ),
        labelText: 'ชื่อร้านอาหาร',
        labelStyle: TextStyle(color: color),
        helperText: 'กรุณากรอกชื่อร้านอาหาร',
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณากรอกชื่อร้านอาหารด้วยค่ะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {},
    );
  }

  Widget nameAddressText() {
    Color color = Colors.yellow[900];
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: color,
          size: 36.0,
        ),
        labelText: 'ที่อยู่ร้านอาหาร',
        labelStyle: TextStyle(color: color),
        helperText: 'กรุณากรอกที่อยู่ร้านอาหาร',
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณากรอกที่อยู่ร้านอาหารด้วยค่ะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {},
    );
  }

  Widget nameDetailText() {
    Color color = Colors.blue;
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        icon: Icon(
          Icons.details,
          color: color,
          size: 36.0,
        ),
        labelText: 'รายละเอียด',
        labelStyle: TextStyle(color: color),
        helperText: 'กรุณากรอกรายละเอียดร้านอาหาร',
        helperStyle: TextStyle(color: color),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'กรุณากรอกรายละเอียดด้วยค่ะ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {},
    );
  }

  Widget showFoodImage() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.5,
      child: file == null ? Image.asset('images/food.png') : Image.file(file),
    );
  }

  Widget galleryButton() {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.image),
        label: Text('Choose image'),
        onPressed: () {
          chooseImageThread();
        },
      ),
    );
  }

  Future<void> chooseImageThread() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = image;
    });
  }

  Widget showLat() {
    return ListTile(
      title: Text('13.1234567'),
      subtitle: Text('ละติจูด'),
    );
  }

  Widget showLng() {
    return ListTile(
      title: Text('100.1234567'),
      subtitle: Text('ลองติจูด'),
    );
  }

  Widget uploadeButton() {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.cloud_upload),
        label: Text('Upload Value'),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (file == null) {
              myAlert('ยังไม่ได้อัปโหลดรูปภาพค่ะ');
            } else {
              // upload
            }
          } else{
            myAlert('กรอกข้อมูลไม่ครบค่ะ');
          }
        },
      ),
    );
  }

  void myAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('มีความผิดปกติเกิดขึ้น'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          nameFoodText(),
          nameShopText(),
          nameAddressText(),
          nameDetailText(),
          SizedBox(
            height: 16.0,
          ),
          showFoodImage(),
          SizedBox(
            height: 16.0,
          ),
          galleryButton(),
          SizedBox(
            height: 16.0,
          ),
          showLat(),
          showLng(),
          SizedBox(
            height: 16.0,
          ),
          uploadeButton(),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
