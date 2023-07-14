import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';

class RideRequests extends StatefulWidget {
  @override
  _RideRequestsState createState() => _RideRequestsState();
}

class _RideRequestsState extends State<RideRequests> {
  final double _borderRadius = 24;

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
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Center(
              child: Container(
                width: 300,
                height: 200,
                padding: new EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.red,
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.album, size: 60),
                        title: Text(
                            'Sonu Nigam',
                            style: TextStyle(fontSize: 30.0)
                        ),
                        subtitle: Text(
                            'Best of Sonu Nigam Music.',
                            style: TextStyle(fontSize: 18.0)
                        ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          ElevatedButton(
                            child: const Text('Play'),
                            onPressed: () {/* ... */},
                          ),
                          ElevatedButton(
                            child: const Text('Pause'),
                            onPressed: () {/* ... */},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final String location;
  final double rating;
  final int paying;

  PlaceInfo(this.name, this.rating, this.location, this.paying);
}
