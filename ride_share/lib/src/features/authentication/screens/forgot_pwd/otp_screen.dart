// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:ride_share/src/constants/colors.dart';
// import 'package:ride_share/src/constants/image_strings.dart';
// import 'package:ride_share/src/utils/theme/widgets_themes/text_theme.dart';
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_strings.dart';
//
// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key, required this.phoneNo});
//
//   final String phoneNo;
//
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     var otp;
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             child: Container(
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Colors.orange,
//                   Colors.deepOrange,
//                 ],
//               )),
//               height: size.height * 0.45,
//               alignment: Alignment.center,
//             ),
//           ),
//           Positioned(
//             top: size.height * 0.5,
//             child: Container(
//               height: size.height - (size.height * 0.5),
//               width: size.width,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     // Text(
//                     //   tOtpTitle,
//                     //   textAlign: TextAlign.center,
//                     //   style: Theme.of(context).textTheme.headlineMedium,
//                     //   textScaleFactor: 1.8,
//                     // ),
//                     // Container(
//                     //   decoration: BoxDecoration(
//                     //     borderRadius: BorderRadius.circular(10),
//                     //     color: tSecondaryColor,
//                     //   ),
//                     //   height: 5,
//                     //   width: size.width * 0.3,
//                     // ),
//                     // const SizedBox(height: 20.0),
//                     // Text(
//                     //   "$tOtpMessage $phoneNo",
//                     //   textAlign: TextAlign.center,
//                     // ),
//                     // const SizedBox(height: 20.0),
//                     OtpTextField(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       numberOfFields: 6,
//                       fillColor: Colors.black.withOpacity(0.1),
//                       filled: true,
//                       keyboardType: TextInputType.number,
//                       onSubmit: (code) {
//                         otp = code;
//                         // OTPController.instance.verifyOTP(otp);
//                       },
//                     ),
//                     // const SizedBox(
//                     //   height: 30.0,
//                     // ),
//                     // SizedBox(
//                     //   width: size.width * 0.75,
//                     //   child: ElevatedButton(
//                     //     onPressed: () {
//                     //       // OTPController.instance.verifyOTP(otp);
//                     //     },
//                     //     child: const Text(
//                     //       "Next",
//                     //       style: TextStyle(
//                     //           fontWeight: FontWeight.w600,
//                     //           fontSize: 18,
//                     //           letterSpacing: 1.5),
//                     //     ),
//                     //   ),
//                     // ),
//                     // const SizedBox(
//                     //   height: tFormHeight - 10.0,
//                     // ),
//                     // TextButton(
//                     //     onPressed: () {},
//                     //     child: Text.rich(TextSpan(
//                     //         text: "$tOtpNotSent ",
//                     //         style: Theme.of(context).textTheme.bodyMedium,
//                     //         children: const [
//                     //           TextSpan(
//                     //             text: tResendOtp,
//                     //             style: TextStyle(
//                     //                 color: tSecondaryColor,
//                     //                 decoration: TextDecoration.underline),
//                     //           )
//                     //         ],
//                     //     ),
//                     //     ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Positioned(
//           //   top: 26,
//           //   child: Image(
//           //     image: const AssetImage(tOTPScreenImage),
//           //     height: size.height * 0.45,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.phoneNo});

  final String phoneNo;

  @override
  Widget build(BuildContext context) {
    // var otpController = Get.put(OTPController());
    var otp;
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
                          // otp = code;
                          // OTPController.instance.verifyOTP(otp);
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: ElevatedButton(
                          onPressed: () {
                            // OTPController.instance.verifyOTP(otp);
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
                        onPressed: () {},
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
      )),
    );
  }
}
