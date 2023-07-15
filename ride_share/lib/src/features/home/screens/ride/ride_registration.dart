import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/features/home/controllers/ride_controller.dart';
import 'package:ride_share/src/features/home/screens/ride/registration_pages/schedule_page.dart';
import 'package:ride_share/src/features/home/screens/ride/registration_pages/vehicle_details_page.dart';
import 'package:ride_share/src/features/home/screens/ride/registration_pages/route_page.dart';

import '../../../../common_widgets/registration_header.dart';
import '../../../../models/offered_ride_model.dart';
import '../../../../models/user_model.dart';
import '../../../../repository/user_repository.dart';

class RideRegistrationTemplate extends StatefulWidget {
  const RideRegistrationTemplate({Key? key}) : super(key: key);

  @override
  State<RideRegistrationTemplate> createState() =>
      _RideRegistrationTemplateState();
}

class _RideRegistrationTemplateState extends State<RideRegistrationTemplate> {
  String sourceLocation = '';
  String destinationLocation = '';
  String vehicleMake = '';
  String vehicleModel = '';
  String numberPlate = '';
  String seatsAvailable = '';
  String vehicleColor = '';
  String encodedPolyline = '';
  Map<String, String> availableDaysAndTimes = {};
  PageController pageController = PageController();

  RideController rideController = Get.put(RideController());
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          regHeaderPlain(
              title: 'Vehicle Registration',
              subtitle: 'Fill in your car\'s details'),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PageView(
                onPageChanged: (int page) {
                  currentPage = page;
                },
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  RoutePage(
                    sourceLocation: sourceLocation,
                    destinationLocation: destinationLocation,
                    encodedPolyline: encodedPolyline,
                    onSubmit:
                        (String source, String destination, String polyline) {
                      setState(() {
                        sourceLocation = source;
                        destinationLocation = destination;
                        encodedPolyline = polyline;
                      });
                    },
                  ),
                  VehicleDetailsPage(
                    controller: rideController,
                  ),
                  SchedulePage(
                    availableDaysAndTimes: availableDaysAndTimes,
                    onSelect: (Map<String, String> mappings) {
                      setState(() {
                        availableDaysAndTimes = mappings;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => isUploading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FloatingActionButton(
                          onPressed: () {
                            if (currentPage < 2) {
                              pageController.animateToPage(currentPage + 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            } else {
                              uploadVehicleDetails();
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          backgroundColor: tSecondaryColor,
                        ),
                ),
              )),
        ],
      ),
    );
  }

  var isUploading = false.obs;

  uploadVehicleDetails() async {
    isUploading(true);

    UserModel user =
        await UserRepository.instance.getUserDetails("+254706446072");

    // TODO: modify ride-details model to accommodate new fields

    final rideDetails = OfferedRideModel(
      userId: user.id!,
      userName: user.fullName,
      source: sourceLocation,
      destination: destinationLocation,
      encodedPolyline: encodedPolyline,
      vehicleMake: rideController.vehicleMake.text.trim(),
      vehicleModel: rideController.vehicleModel.text.trim(),
      vehicleColor: rideController.vehicleColor.text.trim(),
      seatsAvailable: rideController.seatsAvailable.text.trim(),
      numberPlate: rideController.numberPlate.text.trim(),
      dayAndTimeAvailable: availableDaysAndTimes,
    );


    RideController.instance.addRide(rideDetails);

    isUploading(false);
    // Get.off(() => SuccessfulUploadScreen());
  }
}
