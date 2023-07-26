import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/authentication/screens/forgot_pwd/password_reset_screen.dart';
import 'package:ride_share/src/features/home/screens/home_screen.dart';

import '../../../repository/authentication_repository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }

  void verifyForgotPwdOTP(String otp, String phoneNo) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(PasswordResetScreen(phoneNo: phoneNo)) : Get.back();
  }

  void verifyEmailOTP(String otp, String email) async{
    var isVerified = await AuthenticationRepository.instance.verifyEmailOTP(email, otp);
    isVerified ? Get.offAll(PasswordResetScreen(phoneNo: email)) : Get.back();
  }
}