import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/sizes.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/authentication/screens/login/login_screen.dart';

import '../signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Image(image: const AssetImage(tWelcomeScreenImage), height: height * 0.65, ),
              Column(
                children: [
                  RichText(
                      text: TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily, fontWeight: FontWeight.bold, fontSize: 30.0, color: isDarkMode ? tWhiteColor : tBlackColor,),
                        children: const <TextSpan>[
                          TextSpan(text: "Ride"),
                          TextSpan(text: "Share", style: TextStyle(color: tSecondaryColor)),
                        ],
                      ),
                  ),
                  Text(tWelcomeSubtitle, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),

                        child: Text(tLogin.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.5),),
                    ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(child: OutlinedButton(
                        onPressed: () => Get.to(() => const SignUpScreen()),

                        child: Text(tSignup.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.5)))),
                  ],
              )
            ],
          ),
        )
    );
  }
}