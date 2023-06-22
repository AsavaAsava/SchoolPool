import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title:
        Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfilePic)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: tSecondaryColor,
                      ),
                      child: const Icon(LineAwesomeIcons.alternate_pencil,
                          size: 20.0, color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text("Nathan kjfjg",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text("memem@hhhg",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  // onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tSecondaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(tEditProfile,
                      style: TextStyle(color: tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.mail_outline_outlined, color: Colors.grey),
                  Text("mmn@hgh"),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      child: Text(tVerify)
                  )
                ],
              ),
              const Divider(
                height: 3,
                thickness: 3,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(tLocations, style: TextStyle(fontSize: 20),),
              ListTile(
                leading: Icon(Icons.home_filled, color: Colors.grey),
                title: Text(tAddHome),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.location_on_outlined, color: Colors.grey,),
                title: Text(tAddPickup),
                onTap: () => {},
              ),
              const Divider(
                height: 3,
                thickness: 3,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Text(tLanguage, style: TextStyle(fontSize: 20),),
              Text(tLanguageUK, style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              const Divider(
                height: 3,
                thickness: 3,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.grey,),
                title: Text(tLogout),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.delete_outline_outlined, color: Colors.red,),
                title: Text(tAddPickup),
                onTap: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }

}