import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideRequestModel {
  final String? id;
  final String rideId;
  final String ownerId;
  final String requestedByUser;
  final String pickupLocation;
  final String seatsAvailable;
  final double similarityScore;
  final bool acceptedStatus;

  RideRequestModel(
      {this.id,
        required this.rideId,
        required this.ownerId,
        required this.requestedByUser,
        required this.pickupLocation,
        required this.seatsAvailable,
        required this.similarityScore,
        required this.acceptedStatus,
      });

  toJson() {
    return {
      "RideId": rideId,
      "OwnerId": ownerId,
      "RequestedByUser": requestedByUser,
      "PickupLocation": pickupLocation,
      "SeatsAvailable": seatsAvailable,
      "SimilarityScore": similarityScore,
      "AcceptedStatus": acceptedStatus,
    };
  }

  factory RideRequestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return RideRequestModel(
      id: document.id,
      rideId: data["RideId"],
      ownerId: data["OwnerId"],
      requestedByUser: data["RequestedByUser"],
      pickupLocation: data["PickupLocation"],
      seatsAvailable: data["SeatsAvailable"],
      similarityScore: data["SimilarityScore"],
      acceptedStatus: data["AcceptedStatus"],
    );
  }
}
