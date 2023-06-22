import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/authentication/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget{
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Stack(
        children: const [
          Positioned(
              child: Image(image: AssetImage(tSplashImage)),
          ),
          Positioned(
              bottom: 40,
              child: Text(tTagLine),
          )
        ],
      )
    );
  }
}