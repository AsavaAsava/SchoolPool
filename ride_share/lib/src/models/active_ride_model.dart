import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ActiveRide {
  final String? id;
  final String destination;
  final bool completed;
  final DateTime dateMade;

  ActiveRide({
    this.id,
    required this.destination,
    required this.completed,
    required this.dateMade,
  });

  toJson() {
    return {
      "Destination": destination,
      "Completed": completed,
      "Date": dateMade,
    };
  }

  factory ActiveRide.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ActiveRide(
      id: document.id,
      destination: data["Destination"],
      completed: data["Completed"],
      dateMade: data["Date"],
    );
  }
}
