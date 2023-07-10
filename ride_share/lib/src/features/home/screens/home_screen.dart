import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_share/src/common_widgets/nav_drawer.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/home/screens/ride/offer_ride_screen.dart';

import '../../../constants/colors.dart';

List histories = [
  {'id': 1, 'name': 'Balozi Estate', 'city': 'Nairobi'},
  {'id': 2, 'name': 'Ridgeways Country Homes', 'city': 'Ridgeways Rd, Nairobi'},
  {'id': 3, 'name': 'Chalbi Court', 'city': 'Nairobi'}
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-1.3093299, 36.8099464);

  List<Widget> options = <Widget>[Text('Offer'), Text('Request')];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final List<bool> _selectedOptions = <bool>[false, true];
    bool vertical = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        drawer: NavDrawer(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(size: 45.0, weight: 7, fill: 1, color: Colors.black),
          actions: <Widget>[
            ElevatedButton(onPressed: (){Get.to(() => const OfferRideScreen());}, child: Text("Offer")),
            // TextButton(
            //   onPressed: () {
            //     Get.to(() => const OfferRideScreen());
            //   },
            //   child: Row(
            //     children: [
            //       Text("Offer"),
            //     ],
            //   ),
            // ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight / 2,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),
                );
              },
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.zero,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(color: Colors.black, width: 1.0),
            //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
            //       ),
            //       child: TextButton(
            //         onPressed: () {
            //           Get.to(() => const OfferRideScreen());
            //         },
            //         child: Row(
            //           children: [
            //             Text("Offer"),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // Positioned(
            //   top: 50,
            //   left: 10,
            //   child: Padding(
            //     padding: const EdgeInsets.all(7.0),
            //     child: Align(
            //       alignment: Alignment.topLeft,
            //       child: FloatingActionButton(
            //         onPressed: () => NavDrawer(),
            //         materialTapTargetSize: MaterialTapTargetSize.padded,
            //         backgroundColor: Colors.white,
            //         child: const Icon(Icons.menu, size: 30.0),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: const Alignment(0.9, 0.75),
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(7.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.my_location,
                  size: 30.0,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 1,
              snapSizes: const [0.5, 1],
              snap: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      itemCount: histories.length,
                      itemBuilder: (BuildContext context, int index) {
                        final history = histories[index];
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: 50,
                                  child: Divider(
                                    thickness: 5,
                                  ),
                                ),
                                TextFormField(
                                  cursorColor: tSecondaryColor,
                                  decoration: const InputDecoration(
                                      hintText: tPickUpLocation,
                                      border: OutlineInputBorder()),
                                ),
                              ],
                            ),
                          );
                        }
                        return Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          elevation: 0,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(5),
                            onTap: () {},
                            leading: Icon(Icons.access_time),
                            title: Text(history['name']),
                            subtitle: Text(history['city']),
                          ),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
