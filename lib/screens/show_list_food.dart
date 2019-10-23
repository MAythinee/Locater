import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locater/models/food_model.dart';
import 'package:locater/screens/detail_food.dart';
import 'package:locater/screens/my_style.dart';

class ShowListFood extends StatefulWidget {
  @override
  _ShowListFoodState createState() => _ShowListFoodState();
}

class _ShowListFoodState extends State<ShowListFood> {
// Explicit
  List<FoodModel> foodModels = [];

// Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference =
        firestore.collection('Food'); //อ่านข้อมูลใน firebase
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        // String nameFood = snapshot.data['NameFood'];
        // print('nameFood = $nameFood');

        FoodModel foodModel = FoodModel(
            snapshot.data['NameFood'],
            snapshot.data['PathURL'],
            snapshot.data['NameShop'],
            snapshot.data['Address'],
            snapshot.data['TimeOpenClose'],
            snapshot.data['Detail'],
            snapshot.data['Lat'],
            snapshot.data['Lng'],
            snapshot.data['PostBy']);

        setState(() {
          foodModels.add(foodModel);
        });
      }
    });
  }

  Widget foodListView() {
    return ListView.builder(
      itemCount: foodModels.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            decoration: index % 2 == 0
                ? BoxDecoration(color: Colors.orange[100])
                : BoxDecoration(color: Colors.orange[300]),
            child: Row(
              children: <Widget>[
                showFoodImage(index),
                showText(index),
              ],
            ),
          ),
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => DetailFood(foodModel: foodModels[index],)); // ตัวส่งโมเดลไปยัง key
            Navigator.of(context).push(materialPageRoute);
          },
        );
      },
    );
  }

  Widget showFoodImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.network(
        foodModels[index].pathURL,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      //color: Colors.grey,
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // แยกตัวอักษร
        children: <Widget>[
          showNameFood(index),
          showDetailShot(index),
        ],
      ),
    );
  }

  Widget showNameFood(int index) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          foodModels[index].nameFood,
          style: TextStyle(fontSize: MyStyle().h1),
        ),
      ],
    );
  }

  Widget showDetailShot(int index) {
    String detail = foodModels[index].detail;

    if (detail.length > 80) {
      detail = detail.substring(0, 80);
      detail = '$detail ...';
    }

    return Text(detail);
  }

  @override
  Widget build(BuildContext context) {
    return foodListView();
  }
}
