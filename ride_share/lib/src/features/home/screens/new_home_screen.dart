import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:google_maps_webservice/places.dart';
import 'dart:ui' as ui;

import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/home/controllers/map_controller.dart';
import 'package:ride_share/src/features/home/screens/profile/edit_profile.dart';
import 'package:ride_share/src/features/home/screens/requests/ride_request.dart';
import 'package:ride_share/src/features/home/screens/ride/ride_registration.dart';
import 'package:ride_share/src/features/home/screens/schedule/user_schedule.dart';
import 'package:ride_share/src/models/ride_request_model.dart';
import 'package:ride_share/src/repository/ride_repository.dart';

import '../../../common_widgets/text_widget.dart';
import '../../../constants/image_strings.dart';
import '../../../models/offered_ride_model.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class CarInfo {
  final String name;
  final String model;
  final double cash;
  final String to;

  CarInfo(this.name, this.model, this.cash, this.to);
}

var items = [
  CarInfo('Nathan Mbugua', "Toyota Mark X", 350, "Makini School"),
  CarInfo('Nathan Mbugua', "Toyota Mark X", 350, "Makini School"),
  CarInfo('Wayne Asava', "Toyota Vitz", 350, "Starthmore University"),
];

class _NewHomeScreenState extends State<NewHomeScreen> {
  final rideRepository = Get.put(RideRepository());
  MapController mapController = Get.put(MapController());

  late LatLng source;
  late LatLng destination;
  final Set<Polyline> polyline = {};
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    super.initState();

    // loadCustomMarker();
  }

  // String dropdownValue = '**** **** **** 8789';
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(-1.3093299, 36.8099464),
    zoom: 10,
  );

  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: tSecondaryColor,
        elevation: 0.0,
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   centerTitle: true,
      //   title: const Text(
      //     'Navigation Drawer',
      //   ),
      //   backgroundColor: const Color(0xff764abc),
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              markers: markers,
              polylines: polyline,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;

                // myMapController!.setMapStyle(_mapStyle);
              },
              initialCameraPosition: _kGooglePlex,
            ),
          ),
          buildProfileTile(),
          buildTextField(),
          showDestinationField ? buildTextFieldForDestination() : Container(),
          buildCurrentLocationIcon(),
          buildBottomSheet(),
        ],
      ),
    );
  }

  Widget buildProfileTile() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child:
          // Obx(() => authController.myUser.value.name == null
          //     ? Center(
          //   child: CircularProgressIndicator(),
          // )
          //     :
          Container(
        width: Get.width,
        height: Get.width * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'Welcome, ',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    TextSpan(
                        text: "Nathan Mbugua",
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  bool showDestinationField = false;

  Widget buildTextField() {
    return Positioned(
      top: 80,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
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
                title: 'Destination: $selectedPlace',
              ),
              position: source,
              // icon: BitmapDescriptor.fromBytes(markIcons),
            ));

            myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: source, zoom: 14)
                //17 is new zoom level
                ));

            // TODO build driver bottom sheet
            buildRideConfirmationSheet();

            // setState(() {
            //   showDestinationField = true;
            // });
          },
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
          decoration: InputDecoration(
            hintText: 'Where to?',
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
      ),
    );
  }

  Widget buildTextFieldForDestination() {
    return Positioned(
      top: 150,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          controller: destinationController,
          readOnly: true,
          onTap: () async {
            // buildSourceSheet();
          },
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'From:',
            hintStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildCurrentLocationIcon() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30, right: 8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 4,
                  blurRadius: 10)
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Center(
          child: Container(
            width: Get.width * 0.3,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }

  buildDrawerItem(
      {required String title,
      required Function onPressed,
      required Icon icon,
      Color color = Colors.black,
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.w700,
      double height = 45,
      bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(
        leading: icon,
        onTap: () => onPressed(),
        title: Row(
          children: [
            Text(
              title,
            ),
            const SizedBox(
              width: 5,
            ),
            isVisible
                ? CircleAvatar(
                    backgroundColor: tSecondaryColor,
                    radius: 15,
                    child: Text(
                      '1',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => EditProfileScreen());
            },
            child: SizedBox(
              height: 150,
              child: DrawerHeader(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(tProfilePic), fit: BoxFit.fill)
                        // : DecorationImage(
                        // image: NetworkImage(
                        //     authController.myUser.value.image!),
                        // fit: BoxFit.fill)
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Good Morning, ',
                            style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.28),
                                fontSize: 14)),
                        Text(
                          // authController.myUser.value.name == null
                          //     ? "Mark"
                          //     : authController.myUser.value.name!,
                          "Nathan",
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // buildDrawerItem(title: 'Payment History', onPressed: () => Get.to(()=> PaymentScreen())),
                buildDrawerItem(
                    title: tPayment,
                    onPressed: () {},
                    icon: const Icon(Icons.wallet_outlined)),
                buildDrawerItem(
                    title: tMySchedule,
                    onPressed: () {
                      Get.to(() => UserSchedule());
                    },
                    icon: const Icon(Icons.calendar_month)),
                buildDrawerItem(
                    title: tTripHistory,
                    onPressed: () {},
                    icon: const Icon(Icons.history)),
                buildDrawerItem(
                    title: tRideRequests,
                    onPressed: () {
                      Get.to(() => RideRequests());
                    },
                    icon: const Icon(Icons.people_alt_outlined)),

                const Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.grey,
                ),

                buildDrawerItem(
                    title: "Offer a Ride",
                    onPressed: () {
                      Get.to(() => const RideRegistrationTemplate());
                    },
                    icon: const Icon(Icons.drive_eta)),

                const Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.grey,
                ),

                buildDrawerItem(
                    title: tSupport,
                    onPressed: () {},
                    icon: const Icon(Icons.contact_support_outlined)),
                buildDrawerItem(
                    title: tAbout,
                    onPressed: () {},
                    icon: const Icon(Icons.info_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }

// late Uint8List markIcons;

// loadCustomMarker() async {
//   markIcons = await loadAsset('assets/dest_marker.png', 100);
// }

// Future<Uint8List> loadAsset(String path, int width) async {
//   ByteData data = await rootBundle.load(path);
//   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//       targetHeight: width);
//   ui.FrameInfo fi = await codec.getNextFrame();
//   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//       .buffer
//       .asUint8List();
// }

// void drawPolyline(String placeId) {
//   _polyline.clear();
//   _polyline.add(Polyline(
//     polylineId: PolylineId(placeId),
//     visible: true,
//     points: [source, destination],
//     color: AppColors.greenColor,
//     width: 5,
//   ));
// }

  void buildDestinationSheet() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Select Your Location",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Home Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              // source = authController.myUser.value.homeAddress!;
              destination = LatLng(-1.22233, 36.9187);
              // sourceController.text = authController.myUser.value.hAddress!;
              destinationController.text = "Home";

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  // markerId: MarkerId(authController.myUser.value.hAddress!),
                  markerId: MarkerId("Home"),
                  infoWindow: InfoWindow(
                    // title: 'Source: ${authController.myUser.value.hAddress!}',
                    title: 'Source: Home}',
                  ),
                  position: destination));

              // await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)));
              setState(() {});

              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: const [
                  Text(
                    // authController.myUser.value.hAddress!,
                    "Home",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Business Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              // source = authController.myUser.value.bussinessAddres!;
              destination = LatLng(-1.23434, 34.272753);
              // sourceController.text = authController.myUser.value.bAddress!;
              destinationController.text = "Home";

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  // markerId: MarkerId(authController.myUser.value.bAddress!),
                  markerId: MarkerId("hnb"),
                  infoWindow: InfoWindow(
                    // title: 'Source: ${authController.myUser.value.bAddress!}',
                    title: 'Source: ',
                  ),
                  position: destination));

              // await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)));
              setState(() {});

              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  Text(
                    // authController.myUser.value.bAddress!,
                    "HOME",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              Prediction? p =
                  await mapController.showGoogleAutoComplete(context);

              String place = p!.description!;

              destinationController.text = place;

              // source = await authController.buildLatLngFromAddress(place);

              if (markers.length >= 2) {
                markers.remove(markers.last);
              }
              markers.add(Marker(
                  markerId: MarkerId(place),
                  infoWindow: InfoWindow(
                    title: 'Source: $place',
                  ),
                  position: destination));

              // await getPolylines(source, destination);

              // drawPolyline(place);

              myMapController!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: destination, zoom: 14)));
              setState(() {});
              buildRideConfirmationSheet();
            },
            child: Container(
              width: Get.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        spreadRadius: 4,
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Search for Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  buildRideConfirmationSheet() {
    Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height * 0.5,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: Get.width * 0.2,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          textWidget(
              text: 'We found the following matches',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          textWidget(
              text: 'Select an option:',
              fontSize: 16,
              fontWeight: FontWeight.normal),
          const SizedBox(
            height: 20,
          ),
          buildDriversList(),
        ],
      ),
    ));
  }

  int selectedRide = 0;

  buildDriversList() {
    return Container(
      height: 250,
      width: Get.width,
      // child: FutureBuilder<List<OfferedRideModel>>(
      //   future: rideRepository.allRides(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasData) {
      //         return ListView.builder(
      //           itemBuilder: (ctx, i) {
      //             return InkWell(
      //               onTap: () {},
      //               child: buildDriverCard(snapshot.data!, i),
      //             );
      //           },
      //           itemCount: snapshot.data!.length,
      //           scrollDirection: Axis.horizontal,
      //         );
      //       }
      //     }
      //     return Text("no data");
      //   },
      // ),

      child: StatefulBuilder(builder: (context, set) {
        return ListView.builder(
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {
                set(() {
                  selectedRide = i;
                });
              },
              child: buildDriverCard(selectedRide == i),
            );
          },
          itemCount: 5,
          scrollDirection: Axis.horizontal,
        );
      }
      ),
    );
  }

  buildDriverCard(bool selected) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      height: 170,
      width: 235,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: tSecondaryColor,
            offset: Offset(0, 5),
            blurRadius: 5,
            spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(12), color: tSecondaryColor),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text:"Nathan Mbugua",
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textWidget(
                    text:
                    "Toyota Mark X",
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                SizedBox(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("Days"),
                          Text("Mon, Tue"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Seats"),
                          Text("4"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Pay"),
                          Text("350"),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      // final rideRequest = RideRequestModel(
                      //     rideId: rides[index].id!,
                      //     ownerId: rides[index].userId,
                      //     requestedByUser: rides[index].userId,
                      //     pickupLocation: 'Strathmore University, Ole Sangale Rd',
                      //     seatsAvailable: rides[index].seatsAvailable,
                      //     similarityScore: 1.0,
                      //     acceptedStatus: false);
                      // await rideRepository.makeRideRequest(rideRequest);
                      // TODO get to success page or show modal and return

                    },
                    child: Text("REQUEST"))
              ],
            ),
          ),
          // ElevatedButton(onPressed: () {}, child: Text("Request"))
          // Positioned(
          //     right: -20,
          //     top: 0,
          //     bottom: 0,
          //     child: Image.asset('assets/Mask Group 2.png'))
        ],
      ),
    );
  }
}
