import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:ride_share/src/models/polyline_creator.dart';

import '../../../../../models/polyline_generator.dart';
import '../../../controllers/map_controller.dart';

class RoutePage extends StatefulWidget {
  const RoutePage(
      {Key? key,
      required this.sourceLocation,
      required this.destinationLocation,
      required this.encodedPolyline,
      required this.onSubmit})
      : super(key: key);

  final String sourceLocation;
  final String destinationLocation;
  final String encodedPolyline;


  final Function onSubmit;

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String btnText = "SUBMIT";
  final sourceController = TextEditingController();
  MapController mapController = Get.put(MapController());
  late LatLng source;
  late LatLng destination;
  final Set<Polyline> polyline = {};
  String encodedPolyline = "";
  Set<Marker> markers = Set<Marker>();
  GoogleMapController? myMapController;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-1.3093299, 36.8099464),
    zoom: 10,
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // select location and show polyline on map for later
        TextFormField(
          controller: sourceController,
          readOnly: true,
          onTap: () async {
            Prediction? p = await mapController.showGoogleAutoComplete(context);

            String selectedPlace = p!.description!;

            sourceController.text = selectedPlace;

            List<geoCoding.Location> locations =
                await geoCoding.locationFromAddress(selectedPlace);

            source =
                LatLng(locations.first.latitude, locations.first.longitude);

            markers.add(Marker(
              markerId: MarkerId(selectedPlace),
              infoWindow: InfoWindow(
                title: 'Source: $selectedPlace',
              ),
              position: source,
              // icon: BitmapDescriptor.fromBytes(markIcons),
            ));

            destination = LatLng(-1.295964, 36.7320972);

            markers.add(Marker(
              markerId: const MarkerId("Makini School"),
              infoWindow: const InfoWindow(
                title: 'Destination: Makini School',
              ),
              position: destination,
              // icon: BitmapDescriptor.fromBytes(markIcons),
            ));

            myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: source, zoom: 14)
                //17 is new zoom level
                ));
            encodedPolyline = await getPolylines(source, destination);


            // await getPolylinesDrawn(source, destination);


            // setState(() {
            //   showDestinationField = true;
            // });
          },
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
          decoration: InputDecoration(
            hintText: 'Pick your source location',
            hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontStyle: FontStyle.italic),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        // The map
        Container(
          height: Get.height * 0.45,
          width: double.infinity,
          margin: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              style: BorderStyle.solid,
            ),
          ),
          child: GoogleMap(
            markers: markers,
            polylines: polyline,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              myMapController = controller;
            },
            initialCameraPosition: _kGooglePlex,
          ),

        ),

        const SizedBox(
          height: 10,
        ),

    // widget.onSubmit(source, destination, polyline);
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0))),
          ),
          onPressed: () async {
            widget.onSubmit(source.toString(), destination.toString(), encodedPolyline);
            setState(() {
              btnText = "SUBMITTED";
            });
          },
          child: Text(btnText),
        ),
      ],
    );
  }
}
