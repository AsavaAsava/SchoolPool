import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/text_strings.dart';

import '../../../../common_widgets/form_header_widget.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../login/login_screen.dart';
import 'signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children:  [
                const FormHeaderWidget(
                  image: tSignUpScreenImage,
                  title: tSignupTitle,
                  subTitle: tSignupSubTitle,
                  imageHeight: 0.17,
                ),
                const SignUpFormWidget(),

                Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),

                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(text: "$tAlreadyHaveAnAccount ", style: Theme.of(context).textTheme.bodyMedium),
                                  const TextSpan(text: tLogin,style: TextStyle(color: tSecondaryColor, decoration: TextDecoration.underline),)
                                ]
                            )
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}