import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OfferedRideModel {
  final String? id;
  final String userId;
  final String userName;
  final String source;
  final String destination;
  final String encodedPolyline;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleColor;
  final String numberPlate;
  final String seatsAvailable;
  final Map<String, String> dayAndTimeAvailable;

  OfferedRideModel(
      {this.id,
      required this.userId,
      required this.userName,
      required this.source,
      required this.destination,
      required this.encodedPolyline,
      required this.vehicleMake,
      required this.vehicleModel,
      required this.vehicleColor,
      required this.seatsAvailable,
      required this.numberPlate,
      required this.dayAndTimeAvailable,
      });

  toJson() {
    return {
      "UserID": userId,
      "UserName": userName,
      "Source": source,
      "Destination": destination,
      "EncodedPolyLine": encodedPolyline,
      "VehicleMake": vehicleMake,
      "VehicleModel": vehicleModel,
      "VehicleColor": vehicleColor,
      "SeatsAvailable": seatsAvailable,
      "NumberPlate": numberPlate,
      "DayAndTimeAvailable": dayAndTimeAvailable,
    };
  }

  factory OfferedRideModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return OfferedRideModel(
      id: document.id,
      userId: data["UserID"],
      userName: data["UserName"],
      source: data["Source"],
      destination: data["Destination"],
      vehicleModel: data["VehicleModel"],
      vehicleMake: data["VehicleMake"],
      vehicleColor: data["VehicleColor"],
      numberPlate: data["NumberPlate"],
      seatsAvailable: data["SeatsAvailable"],
      dayAndTimeAvailable: data["DayAndTimeAvailable"],
      encodedPolyline: data["EncodedPolyLine"],
    );
  }
}
