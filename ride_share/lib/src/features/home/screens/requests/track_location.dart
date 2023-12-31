import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ride_share/src/constants/colors.dart';

import '../../../../../auth/secrets.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({Key? key}) : super(key: key);

  @override
  State<LiveTrackingPage> createState() => LiveTrackingPageState();
}

class LiveTrackingPageState extends State<LiveTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.4221, -122.0841);
  static const LatLng destination = LatLng(37.4116, -122.0713);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            ),
          ),
        ),
      );
      setState(() {});
    });
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
        ImageConfiguration.empty, "asset/Pin_source.png")
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "asset/Pin_destination.png")
        .then(
          (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "asset/Badge.png")
        .then(
          (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  @override
  void initState() {
    setCustomMarkerIcons();
    getCurrentLocation();
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
          Marker(
              icon: currentLocationIcon,
              markerId: const MarkerId("currentLocation"),
              position: LatLng(currentLocation!.latitude!,
                  currentLocation!.longitude!)),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
