import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/models/active_ride_model.dart';
import 'package:ride_share/src/models/offered_ride_model.dart';
import 'package:ride_share/src/models/ride_request_model.dart';

class RideRepository extends GetxController {
  static RideRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //add ride
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

  //fetch all rides
  Future<List<OfferedRideModel>> allRides() async {

    final snapshot = await _db.collection("OfferedRides").get();
    final rides = snapshot.docs.map((e) => OfferedRideModel.fromSnapshot(e)).toList();
    return rides;

    }


  //make ride request
  Future<void> makeRideRequest(RideRequestModel rideRequest) async {
    await _db
        .collection("RideRequests")
        .add(rideRequest.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your request has been made",
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

  //fetch all ride requests
  Future<List<RideRequestModel>> allRideRequests(String userId) async {
    final snapshot = await _db.collection("RideRequests").where("OwnerId", isEqualTo: userId).get();
    final requests= snapshot.docs.map((e) => RideRequestModel.fromSnapshot(e)).toList();
    return requests;
  }

  //accept ride request
  Future<void> acceptRideRequest(RideRequestModel rideRequest) async {
    await _db.collection("RideRequests").doc(rideRequest.id).update(rideRequest.toJson());
  }

  //decline ride request
  Future<void> declineRideRequest(RideRequestModel rideRequest) async {
    await _db.collection("RideRequests").doc(rideRequest.id).delete();
  }

  //add active ride
  Future<void> addActiveRide(ActiveRide activeRide) async {
    await _db
        .collection("ActiveRides")
        .add(activeRide.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your ride has started",
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

  //remove active ride
  Future<void> removeActiveRide(ActiveRide activeRide) async {
    await _db.collection("ActiveRides").doc(activeRide.id).update(activeRide.toJson());
  }
}
