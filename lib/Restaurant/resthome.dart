import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/themeColor.dart';
import '../services/crud.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHomeState createState() => _RestaurantHomeState();
}

class _RestaurantHomeState extends State<RestaurantHome> {
  late String restaurantName;
  late String foodName;
  late String amount;
  late String restaurantEmail;
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    CrudMethods crudObj = CrudMethods();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 70.0),
              Container(
                color: Colors.white10,
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'AddDetails',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.url,
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Image Url",
                    labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    this.imageUrl = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 25,
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Restaurant Name",
                    labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    this.restaurantName = value;
                  },
                ),
              ),
              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Food Name",
                    labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    this.foodName = value;
                  },
                ),
              ),
              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    this.amount = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Themes.color,
                      elevation: 4.0,
                      splashFactory: InkSplash.splashFactory,
                    ),
                    onPressed: () {
                      Map<String, dynamic> restaurantData = {
                        'restaurantName': this.restaurantName,
                        'foodName': this.foodName,
                        'amount': this.amount,
                        'imageUrl': this.imageUrl,
                      };
                      crudObj.addData(restaurantData).then((result) {
                        dialogTrigger(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      elevation: 4.0,
                      splashFactory: InkSplash.splashFactory,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.of(context).pushReplacementNamed('/firstpage');
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: Text(
                      'LogOut',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Future> dialogTrigger(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Job done', style: TextStyle(fontSize: 22.0)),
        content: Text(
          'Added Successfully',
          style: TextStyle(fontSize: 20.0),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Alright',
              style: TextStyle(fontSize: 18),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Themes.color,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
