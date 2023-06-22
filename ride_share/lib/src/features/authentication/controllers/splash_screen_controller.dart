import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/authentication/screens/welcome/welcome_screen.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find => Get.find();

  Future<void> startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.to(WelcomeScreen());
  }
}