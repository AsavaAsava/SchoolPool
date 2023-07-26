import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../controllers/ride_controller.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({
    Key? key,
    required this.controller
  }) : super(key: key);

  final RideController controller;

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(

        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: widget.controller.vehicleMake,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the vehicle make';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Vehicle Make",
                    hintText: "Toyota",
                    border: OutlineInputBorder()),
              ),

              const SizedBox(
                height: tFormHeight-10,
              ),

              TextFormField(
                cursorColor: tSecondaryColor,
                controller: widget.controller.vehicleModel,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the vehicle model';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Vehicle Model",
                    hintText: "Mark X",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: tFormHeight-10,
              ),

              TextFormField(
                cursorColor: tSecondaryColor,
                controller: widget.controller.numberPlate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the vehicle\'s number plate';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Number plate",
                    hintText: "KXX ***X",
                    border: OutlineInputBorder()),
              ),

              const SizedBox(
                height: tFormHeight-10,
              ),

              TextFormField(
                cursorColor: tSecondaryColor,
                controller: widget.controller.vehicleColor,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the vehicle\'s color';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Color",
                    hintText: "White",
                    border: OutlineInputBorder()),
              ),

              const SizedBox(
                height: tFormHeight-10,
              ),

              TextFormField(
                cursorColor: tSecondaryColor,
                keyboardType: TextInputType.number,
                controller: widget.controller.seatsAvailable,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the number of seats available';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Seats Available",
                    hintText: "4",
                    border: OutlineInputBorder()),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
