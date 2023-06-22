import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();

  // final userRepo = Get.put(UserRepository());

  // void registerUser(String email, String password, String phoneNo) {
  //   String? error = AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password) as String?;
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(message: error.toString()));
  //   }
  // }

  // Future<void> createUser(UserModel user) async {
  //   await userRepo.createUser(user);
  //   AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password!);
  //   // phoneAuthentication(user.phoneNo);
  //   // Get.to(() => const OTPScreen());
  // }



  // Future<void>  phoneAuthentication(String fullname, String email, String phone)async {
  //   await userRepo.createRealTimeUser(fullname, email, phone);
  //   AuthenticationRepository.instance.phoneAuthentication(phone);
  // }
  // phoneAuthentication(String phone) {
  //   AuthenticationRepository.instance.phoneAuthentication(phone);
  // }
}