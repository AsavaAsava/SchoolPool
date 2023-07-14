import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_share/src/constants/colors.dart';

Widget regHeaderPlain({required String title, String? subtitle}) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      color: tSecondaryColor,
    ),
    height: Get.height * 0.25,
    child: Container(
        height: Get.height * 0.1,
        width: Get.width,
        margin: EdgeInsets.only(top: Get.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
          ],
        )),
  );
}
