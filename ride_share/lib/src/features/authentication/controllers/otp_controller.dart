import 'package:get/get.dart';
import 'package:ride_share/src/features/home/screens/home_screen.dart';

import '../../../repository/authentication_repository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}