import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
// Explitcit

  File file;
  final formKey = GlobalKey<FormState>();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String urlImage = '';
  String nameFood,
      nameShop,
      address,
      detail,
      latString = '0',
      lngString = '0',
      namePost;

// Method
@override
  void initState() {
    super.initState();
    findLocation();
  }

  Future<void> findLocation() async {
    LocationData currentLocation = await locationData();
    setState(() {
      latString = currentLocation.latitude.toString();
      lngString = currentLocation.longitude.toString();
    });
  }

  Future<LocationData> locationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      print('Location Error ==> ${e.code}');
    }
  }

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
      onSaved: (String value) {
        nameFood = value.trim();
      },
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
      onSaved: (String value) {
        nameShop = value.trim();
      },
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
      onSaved: (String value) {
        address = value.trim();
      },
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
      onSaved: (String value) {
        detail = value.trim();
      },
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
      title: Text('latString'),
      subtitle: Text('ละติจูด'),
    );
  }

  Widget showLng() {
    return ListTile(
      title: Text('lngString'),
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
          } else {
            myAlert('กรอกข้อมูลไม่ครบค่ะ');
          }
        },
      ),
    );
  }

  Future<void> uploadImageThread() async {
    int randInt = Random().nextInt(1000);
    String nameImage = 'food$randInt.jpg';

    StorageReference storageReference =
        firebaseStorage.ref().child('ImageFood/$nameImage');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    await (await storageUploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((response) {
      urlImage = response;
      print('urlImage = $urlImage');
      uploadDataThread();
    });
  }

  Future<void> uploadDataThread() async {
    Map<String, dynamic> map = Map();
    map['NameFood'] = nameFood;
    map['NameShop'] = nameShop;
    map['Address'] = address;
    map['Detail'] = detail;
    map['Lat'] = latString;
    map['Lng'] = lngString;
    map['PathURL'] = urlImage;
    map['PostBy'] = 'May';
    map['TimeOpenClose'] = '9.00 - 21.00';

    Firestore firestore = Firestore.instance;
    await firestore
        .collection('Food')
        .document()
        .setData(map)
        .then((response) {
          print('Success Upload Data');
          myAlert('บันทึกข้อมูลสำเร็จแล้วค่ะ');
        });
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
