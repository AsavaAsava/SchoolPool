import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/text_strings.dart';

import '../../../../common_widgets/form_header_widget.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../signup/signup_screen.dart';
import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const FormHeaderWidget(
                      image: tLoginScreenImage,
                      title: tLoginTitle,
                      subTitle: tLoginSubTitle
                  ),
                  const LoginForm(),

                  Column(
                    children: [
                      const SizedBox(height: tFormHeight - 10.0,),

                      TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: Text.rich(
                              TextSpan(
                                  text: "$tDontHaveAnAccount ",
                                  style: Theme.of(context).textTheme.bodyMedium,

                                  children: const [
                                    TextSpan(
                                      text: tSignup,
                                      style: TextStyle(color: tSecondaryColor, decoration: TextDecoration.underline),
                                    )
                                  ]
                              )
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

}