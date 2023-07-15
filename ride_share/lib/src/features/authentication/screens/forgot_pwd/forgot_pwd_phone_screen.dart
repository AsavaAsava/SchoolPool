import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/authentication/screens/forgot_pwd/forgot_pwd_otp_screen.dart';
import 'package:ride_share/src/repository/authentication_repository.dart';

import '../../../../common_widgets/form_header_widget.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  State<ForgotPasswordPhoneScreen> createState() => _ForgotPasswordPhoneScreenState();
}

class _ForgotPasswordPhoneScreenState extends State<ForgotPasswordPhoneScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const SizedBox(
                  height: tDefaultSize * 4,
                ),
                const FormHeaderWidget(
                  image: tForgotPwdScreenImage,
                  title: tResetMailTitle,
                  subTitle: tViaPhoneSubtitle,
                  heightBetween: 10.0,
                  imageHeight: 0.4,
                  lineWidth: 0.2,
                ),
                const SizedBox(height: tFormHeight),

                Form(
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: tSecondaryColor,
                          controller: controller,
                          decoration: const InputDecoration(
                            label: Text(tPhoneNo),
                            hintText: tPhoneHintText,
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async{
                                await AuthenticationRepository.instance.phoneAuthentication(controller.text.trim());
                                Get.to(() => ForgotPwdOTPScreen(phoneNo: controller.text.trim()));
                              },
                              child: const Text("Next")
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}