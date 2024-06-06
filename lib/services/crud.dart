import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) { // Updated method to access currentUser
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(Map<String, dynamic> restaurantData) async { // Ensure your restaurantData is a Map
    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('RestaurantData')
          .add(restaurantData)
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }
}
