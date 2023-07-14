import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ride_share/src/features/home/screens/ride/ride_registration.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({
    Key? key,
    required this.onSelect,
    required this.availableDaysAndTimes,
  }) : super(key: key);

  final Map<String, String> availableDaysAndTimes;
  final Function onSelect;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final values = List.filled(7, false);
  String btnText = "SUBMIT";

  TextEditingController mondayTime = TextEditingController();
  TextEditingController tuesdayTime = TextEditingController();
  TextEditingController wednesdayTime = TextEditingController();
  TextEditingController thursdayTime = TextEditingController();
  TextEditingController fridayTime = TextEditingController();
  TextEditingController saturdayTime = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    DateFormat inputFormat = DateFormat('hh:mm');
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Select the days you are available"),
              const SizedBox(
                height: 10,
              ),
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
                  setState(() {
                    values[v % 7] = !values[v % 7];
                  });
                },
                values: values,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Select the respective times of departure"),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    controller: mondayTime,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Monday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                            DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          mondayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextField(
                    controller: tuesdayTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Tuesday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          tuesdayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextField(
                    controller: wednesdayTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Wednesday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          wednesdayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextField(
                    controller: thursdayTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Thursday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          thursdayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextField(
                    controller: fridayTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Friday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          fridayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextField(
                    controller: saturdayTime,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Time on Saturday',
                        hintText: '6:00'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        DateTime parsedTime = inputFormat
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);

                        setState(() {
                          saturdayTime.text = formattedTime;
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0))),
                    ),
                    onPressed: () async {
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

                      for (var time in initialTimes) {
                        if (time.isNotEmpty) {
                          times.add(time);
                        }
                      }
                      List<String> days = valuesToEnglishDays(values, true);
                      Map<String, String> mappings = {};

                      for (int i = 0; i < days.length; i++) {
                        Map<String, String> entry = {days[i]: times[i]};
                        mappings.addAll(entry);
                      }
                      print(mappings);
                      widget.onSelect(mappings);

                      setState(() {
                        btnText = "SUBMITTED";
                      });
                    },
                    child: Text(btnText),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw 'This should never have happened: $day';
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
