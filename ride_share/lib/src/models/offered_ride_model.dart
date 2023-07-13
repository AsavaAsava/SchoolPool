import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OfferedRideModel {
  final String? id;
  final String userId;
  final String carModel;
  final String numberPlate;
  final Map<String, String> dayAndTimeAvailable;
  // final List<String> routePolyline;
  final String routePolyline;

  OfferedRideModel(
      {this.id,
      required this.userId,
      required this.carModel,
      required this.numberPlate,
      required this.dayAndTimeAvailable,
      required this.routePolyline});

  // toJsonInitial() {
  //   return {
  //     "UserID": userId,
  //     "CarModel": carModel,
  //     "NumberPlate": numberPlate,
  //     "DayAndTimeAvailable": dayAndTimeAvailable,
  //     "RoutePolyline": routePolyline,
  //   };
  // }

  toJson() {
    return {
      "UserID": userId,
      "CarModel": carModel,
      "NumberPlate": numberPlate,
      "DayAndTimeAvailable": dayAndTimeAvailable,
      "RoutePolyline": routePolyline,
    };
  }

  factory OfferedRideModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return OfferedRideModel(
      id: document.id,
      userId: data["UserID"],
      carModel: data["CarModel"],
      numberPlate: data["NumberPlate"],
      dayAndTimeAvailable: data["DayAndTimeAvailable"],
      routePolyline: data["RoutePolyline"],
    );
  }
}
