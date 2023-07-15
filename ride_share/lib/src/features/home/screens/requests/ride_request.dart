import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/features/home/screens/requests/live_location.dart';
import 'package:ride_share/src/models/ride_request_model.dart';
import 'package:ride_share/src/models/user_model.dart';
import 'package:ride_share/src/repository/ride_repository.dart';
import 'package:ride_share/src/repository/user_repository.dart';

class RideRequests extends StatefulWidget {
  @override
  _RideRequestsState createState() => _RideRequestsState();
}

class _RideRequestsState extends State<RideRequests> {
  RideRepository rideRepository = Get.put(RideRepository.instance);
  final double _borderRadius = 24;
  // UserModel user =
  //     UserRepository.instance.getUserDetails("+254706446072") as UserModel;

  var items = [
    PlaceInfo('Mary Jane', 4.4, 'Chalbi Court', 350),
    PlaceInfo('John Doe', 4.0, 'Riverside', 200),
    PlaceInfo('Mary Jane', 4.7, 'Junction Mall', 230),
    PlaceInfo('Mary Jane', 5.0, 'Lavington Mall', 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Requests'),
        backgroundColor: tSecondaryColor,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(Icons.person),
                title: Text(items[index].name),
                trailing: ElevatedButton(onPressed: () {
                  Get.to(() => const LiveTrackingPage());
                }, child: Text("Pickup"),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[index].location),
                    Text("Paying 350"),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
// child: Container(
// width: 300,
// height: 200,
// padding: new EdgeInsets.all(10.0),
// child: Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15.0),
// ),
// color: Colors.red,
// elevation: 10,
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: <Widget>[
// const ListTile(
// leading: Icon(Icons.album, size: 60),
// title: Text(
// 'Sonu Nigam',
// style: TextStyle(fontSize: 30.0)
// ),
// subtitle: Text(
// 'Best of Sonu Nigam Music.',
// style: TextStyle(fontSize: 18.0)
// ),
// ),
// ButtonBar(
// children: <Widget>[
// ElevatedButton(
// child: const Text('Play'),
// onPressed: () {/* ... */},
// ),
// ElevatedButton(
// child: const Text('Pause'),
// onPressed: () {/* ... */},
// ),
// ],
// ),
// ],
// ),
// ),
// )

class PlaceInfo {
  final String name;
  final String location;
  final double rating;
  final int paying;

  PlaceInfo(this.name, this.rating, this.location, this.paying);
}
