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
          helperStyle: TextStyle(color: color)),
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
          helperStyle: TextStyle(color: color)),
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
          helperStyle: TextStyle(color: color)),
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
          helperStyle: TextStyle(color: color)),
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

  @override
  Widget build(BuildContext context) {
    return ListView(
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
      ],
    );
  }
}
