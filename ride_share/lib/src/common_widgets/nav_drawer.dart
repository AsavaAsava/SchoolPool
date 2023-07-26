import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/home/screens/profile/profile_screen.dart';

import '../repository/authentication_repository.dart';

class NavDrawer extends StatelessWidget{
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ListTile(
              leading: Icon(
                size: 100,
                  Icons.person_outline
              ),
              title: Text(tEditProfile),
              onTap: () => Get.to(() => const ProfileScreen()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.wallet_outlined),
            title: Text(tPayment),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text(tMySchedule),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text(tTripHistory),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text(tRideRequests),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.contact_support_outlined),
            title: Text(tSupport),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red,),
            title: Text(tAbout),
            onTap: () => {AuthenticationRepository.instance.logout()},
          ),
        ],
      ),
    );
  }

}