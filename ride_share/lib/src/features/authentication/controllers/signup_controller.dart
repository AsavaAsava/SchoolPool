import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../repository/authentication_repository.dart';
import '../../../repository/user_repository.dart';
import '../screens/forgot_pwd/otp_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final fullName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // void registerUser(String email, String password, String phoneNo) {
  //   String? error = AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password) as String?;
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(message: error.toString()));
  //   }
  // }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password!);
    phoneAuthentication(user.phoneNo);
    Get.to(() => OTPScreen(phoneNo: user.phoneNo));
  }



  Future<void>  phoneAuthentication(String phone)async {
    // await userRepo.createRealTimeUser(fullname, email, phone);
    AuthenticationRepository.instance.phoneAuthentication(phone);
  }

}