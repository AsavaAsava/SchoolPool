import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  // late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("users");

  Future<void> createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJsonInitial())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
      if (kDebugMode) {
        print("Error - $error");
      }
    });
  }
  //
  // Future<void> createRealTimeUser(String fullname, String email, String phone) async{
  //   Map<String, String> users = {
  //     'Fullname': fullname,
  //     'Email': email,
  //     'PhoneNo': phone,
  //   };
  //   await dbRef.push().set(users);
  // }

  Future<UserModel> getUserDetails(String? phone) async {
    final snapshot = await _db.collection("Users").where("Phone", isEqualTo: phone).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateUser(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
}