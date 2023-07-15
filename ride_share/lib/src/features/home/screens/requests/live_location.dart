import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';

import '../../../../../auth/secrets.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({Key? key}) : super(key: key);

  @override
  State<LiveTrackingPage> createState() => LiveTrackingPageState();
}

class LiveTrackingPageState extends State<LiveTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(1.3093299,36.8099464);
  static const LatLng destination = LatLng(-1.2987826,36.7606058);
  static const LatLng currentLocation = LatLng(1.3093299,36.8099464);


  List<LatLng> polylineCoordinates = [];

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {

  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapsAPIKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) =>
            polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcons() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, tpinsource)
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, tpindest)
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, tbadge)
        .then(
          (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  @override
  void initState() {
    setCustomMarkerIcons();;
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Tracking",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 13.5),
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: tSecondaryColor,
            width: 6,
          ),
        },
        markers: {
          const Marker(
              markerId: MarkerId("source"), position: sourceLocation),
          const Marker(
              markerId: MarkerId("destination"), position: destination),
          const Marker(
              markerId: MarkerId("current"), position: currentLocation),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}