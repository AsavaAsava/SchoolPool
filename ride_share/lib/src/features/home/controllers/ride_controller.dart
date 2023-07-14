import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/home/screens/home_screen.dart';
import 'package:ride_share/src/features/home/screens/new_home_screen.dart';
import 'package:ride_share/src/models/offered_ride_model.dart';
import 'package:ride_share/src/repository/ride_repository.dart';

class RideController extends GetxController{
  static RideController get instance => Get.find();

  final rideRepo = Get.put(RideRepository());

  final vehicleMake = TextEditingController();
  final vehicleModel = TextEditingController();
  final numberPlate = TextEditingController();
  final vehicleColor = TextEditingController();
  final seatsAvailable = TextEditingController();

  Future<void> addRide(OfferedRideModel ride) async {
    await rideRepo.addRide(ride);
    Get.to(() => const NewHomeScreen());
  }
}