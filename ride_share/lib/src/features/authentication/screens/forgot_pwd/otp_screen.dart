import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/repository/authentication_repository.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.phoneNo});

  final String phoneNo;

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    String otp = "";
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.orange,
                      Colors.deepOrange,
                    ],
                  ),
                  ),
                  height: size.height * 0.45,
                  alignment: Alignment.center,
                  child: Image(
                    alignment: Alignment.bottomCenter,
                    image: const AssetImage(tOTPScreenImage),
                    height: size.height * 0.5,
                  ),
                ),
                Container(
                  height: size.height * 0.45,
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Column(
                    children: [
                      Text(
                        tOtpTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textScaleFactor: 1.8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tSecondaryColor,
                        ),
                        height: 5,
                        width: size.width * 0.3,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "$tOtpMessage $phoneNo",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      OtpTextField(
                        mainAxisAlignment: MainAxisAlignment.center,
                        numberOfFields: 6,
                        fillColor: Colors.black.withOpacity(0.1),
                        filled: true,
                        cursorColor: tSecondaryColor,
                        focusedBorderColor: tSecondaryColor,
                        onSubmit: (code) {
                          otp = code;
                          otpController.verifyOTP(otp);
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: ElevatedButton(
                          onPressed: () {
                            otpController.verifyOTP(otp);
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: tFormHeight - 10.0,
                      ),
                      TextButton(
                        onPressed: () {
                          AuthenticationRepository.instance.phoneAuthentication(phoneNo);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "$tOtpNotSent ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: const [
                              TextSpan(
                                text: tResendOtp,
                                style: TextStyle(
                                    color: tSecondaryColor,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
      ),
    );
  }
}
