import 'package:flutter/material.dart';
import 'package:locater/models/food_model.dart';
import 'package:locater/screens/my_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailFood extends StatefulWidget {
  final FoodModel foodModel;
  DetailFood({Key key, this.foodModel}) : super(key: key); // รับค่าโมเดล

  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  // Explict

  FoodModel myFoodModel;
  static const LatLng centerMap = const LatLng(13.650237, 100.628556);
  CameraPosition cameraPosition = CameraPosition(
      target: centerMap,
      zoom: 16); // 0 = โลก , 20 = มองชิดโลก , 16 = มองระยะกลาง

  // Method

  @override
  void initState() {
    super.initState();

    myFoodModel = widget.foodModel;
  }

  Widget showNameShop() {
    return Text('ชื่อร้านค้า : ${myFoodModel.nameShop}',
        style: TextStyle(
          fontSize: MyStyle().h2,
        ));
  }

  Widget showAddressShop() {
    return Text('ที่อยู่ : ${myFoodModel.address}',
        style: TextStyle(
          fontSize: MyStyle().h2,
        ));
  }

  Widget showTimeShop() {
    return Text('เวลาเปิด - ปิดร้าน : ${myFoodModel.timeOpenClose}',
        style: TextStyle(
          fontSize: MyStyle().h2,
        ));
  }

  Widget showDetailFood() {
    return Text('รายละเอียด : ${myFoodModel.detail}',
        style: TextStyle(
          fontSize: MyStyle().h2,
        ));
  }

  Widget showImageFood() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.all(20.0),
      child: Image.network(
        myFoodModel.pathURL,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showNameFood() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          myFoodModel.nameFood,
          style:
              TextStyle(fontSize: MyStyle().h1, color: MyStyle().myTextColor),
        ),
      ],
    );
  }

  Widget showMap() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.5,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController googleMapController) {},
      ),
    );
  }

  Widget showDetail() {
    return ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        showNameFood(),
        showImageFood(),
        showNameShop(), Divider(),
        // SizedBox(height: 8.0,),  // ช่องว่างแยก
        showAddressShop(), Divider(),
        showTimeShop(), Divider(),
        showDetailFood(),
        SizedBox(
          height: 8.0,
        ),
        showMap(),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().myMainColor,
        title: Text('Detail'),
      ),
      body: showDetail(),
    );
  }
}
