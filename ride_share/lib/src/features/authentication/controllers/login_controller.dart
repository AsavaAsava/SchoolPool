import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();
  //
  // final userRepo = Get.put(UserRepository());

  final email = TextEditingController();
  final password = TextEditingController();

}