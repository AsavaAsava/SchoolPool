import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ride_share/src/features/home/controllers/ride_controller.dart';
import 'package:ride_share/src/models/network_utility.dart';
import 'package:ride_share/src/models/place_autocomplete_response.dart';
import 'package:ride_share/src/models/polyline_generator.dart';
import 'package:ride_share/src/models/user_model.dart';
import 'package:ride_share/src/repository/user_repository.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

import '../../../../common_widgets/location_list_tile.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../models/autocomplete_prediction.dart';
import '../../../../models/offered_ride_model.dart';
import '../../controllers/profile_controller.dart';

printIntAsDay(int day) {
  print('Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
}

String intDayToEnglish(int day) {
  if (day % 7 == DateTime.monday % 7) return 'Monday';
  if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
  if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
  if (day % 7 == DateTime.thursday % 7) return 'Thursday';
  if (day % 7 == DateTime.friday % 7) return 'Friday';
  if (day % 7 == DateTime.saturday % 7) return 'Saturday';
  if (day % 7 == DateTime.sunday % 7) return 'Sunday';
  throw '🐞 This should never have happened: $day';
}

class OfferRideScreen extends StatefulWidget {
  const OfferRideScreen({super.key});

  @override
  State<OfferRideScreen> createState() => _OfferRideScreenState();
}

class _OfferRideScreenState extends State<OfferRideScreen> {
  final userController = Get.put(ProfileController());
  // late LatLng destination;
  // late LatLng source;
  LatLng drop = const LatLng(-1.2955025, 36.6917596);
  LatLng source = const LatLng(-1.3261827,36.8396128);
  List<LatLng> route = [];

  final values = List.filled(7, false);
  TextEditingController mondayTime = TextEditingController();
  TextEditingController tuesdayTime = TextEditingController();
  TextEditingController wednesdayTime = TextEditingController();
  TextEditingController thursdayTime = TextEditingController();
  TextEditingController fridayTime = TextEditingController();
  TextEditingController saturdayTime = TextEditingController();

  TextEditingController destinationController = TextEditingController();
  TextEditingController sourceController = TextEditingController();

  @override
  void initState() {
    mondayTime.text = "";
    tuesdayTime.text = "";
    wednesdayTime.text = "";
    thursdayTime.text = "";
    fridayTime.text = "";
    saturdayTime.text = "";
    super.initState();
  }

  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": ''});

    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);

      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RideController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Offer a Ride"),
        iconTheme: const IconThemeData(
            size: 45.0, weight: 7, fill: 1, color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.carMake,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the car make and model';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.directions_car),
                    labelText: "Car Model",
                    hintText: "Toyota",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.numberPlate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter the car model';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.directions_car_filled_outlined),
                    labelText: "Make of Car",
                    hintText: "Mark X",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              // Text(
              //   'The days that are currently selected are: '
              //   '${valuesToEnglishDays(values, true)}.',
              // ),
              WeekdaySelector(
                // Just some days you want to display to your users.
                selectedFillColor: Colors.orange,
                displayedDays: const {
                  DateTime.sunday,
                  DateTime.monday,
                  DateTime.tuesday,
                  DateTime.wednesday,
                  DateTime.thursday,
                  DateTime.friday,
                },
                onChanged: (v) {
                  // printIntAsDay(v);
                  print(values[v % 7]);
                  setState(() {
                    values[v % 7] = !values[v % 7];
                  });
                },
                values: values,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: mondayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              mondayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: tuesdayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              tuesdayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: wednesdayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              wednesdayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: thursdayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              thursdayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: fridayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              fridayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextField(
                        controller: saturdayTime,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Time',
                            hintText: '6:00'),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              saturdayTime.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //
              TextFormField(
                controller: destinationController,
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "source location",
                ),
              ),
              const Divider(
                height: 4,
                thickness: 4,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      // route = getPolylines(source, drop);
                    },
                    child: Text("get lines")),
              ),
              const Divider(
                height: 4,
                thickness: 4,
                color: Colors.grey,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index) => LocationListTile(
                    press: () async {
                      String selectedPlace =
                          placePredictions[index].description!;
                      destinationController.text = selectedPlace;

                      List<geoCoding.Location> locations =
                          await geoCoding.locationFromAddress(selectedPlace);
                      source = LatLng(
                          locations.first.latitude, locations.first.longitude);
                      // route = getPolylines(source, drop);
                    },
                    location: placePredictions[index].description!,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0))),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserModel user = await UserRepository.instance.getUserDetails("+254706446072");
                      List<String> polyline =  await getPolylines(source, drop);
                      Map<String, String> dayAndTime = {};
                      List<String> initialTimes = [
                        mondayTime.text.trim(),
                        tuesdayTime.text.trim(),
                        wednesdayTime.text.trim(),
                        thursdayTime.text.trim(),
                        fridayTime.text.trim(),
                        saturdayTime.text.trim()
                      ];
                      List<String> times = [];

                      for(var time in initialTimes){
                        if(time.isNotEmpty){
                          times.add(time);
                        }
                      }
                      List<String> days = valuesToEnglishDays(values, true);
                      Map<String, String> mappings = {};

                      for(int i = 0; i< days.length; i++){
                          Map<String, String> entry= {days[i]: times[i]};
                          mappings.addAll(entry);
                      }

                      final rideDetails = OfferedRideModel(
                          userId: user.id!,
                          carModel: controller.carMake.text.trim(),
                          numberPlate: controller.numberPlate.text.trim(),
                          dayAndTimeAvailable: mappings,
                          routePolyline: polyline
                      );

                      RideController.instance.addRide(rideDetails);

                      // print(rideDetails);
                      // print(rideDetails.toJson());
                    }
                  },
                  child: Text("ADD RIDE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  valuesToEnglishDays(List<bool?> values, bool? searchedValue) {
    final days = <String>[];
    for (int i = 0; i < values.length; i++) {
      final v = values[i];
      // Use v == true, as the value could be null, as well (disabled days).
      if (v == searchedValue) days.add(intDayToEnglish(i));
    }
    if (days.isEmpty) return 'NONE';
    return days;
  }
}
