import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/authentication/screens/login/login_screen.dart';

import '../../../models/user_model.dart';
import '../../../repository/authentication_repository.dart';
import '../../../repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final phone = _authRepo.firebaseUser.value?.phoneNumber;

    if (phone != null) {
      if (kDebugMode) {
        print(_authRepo.firebaseUser.value);
      }
      return _userRepo.getUserDetails(phone);
    } else {
      Get.snackbar("Error", "Login to continue");
      Get.to(() => const LoginScreen());
    }
  }

  updateRecord(UserModel user) async{
    await _userRepo.updateUser(user);
  }
}