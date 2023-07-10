import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/models/offered_ride_model.dart';

class RideRepository extends GetxController {
  static RideRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> addRide(OfferedRideModel rideDetails) async {
    await _db
        .collection("OfferedRides")
        .add(rideDetails.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your ride has been added",
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
}
