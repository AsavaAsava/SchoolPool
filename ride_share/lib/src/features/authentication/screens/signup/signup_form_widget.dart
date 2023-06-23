import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ride_share/src/constants/text_strings.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../models/user_model.dart';
import '../../controllers/signup_controller.dart';
import '../forgot_pwd/otp_screen.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool obscurePassword = true;


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.fullName,
                decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*This field is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.email,
                decoration: const InputDecoration(
                  label: Text(tEmail),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                onFieldSubmitted: (val) {
                  validateEmail(val);
                },
                validator: (email) {
                  bool result = validateEmail(email!);
                  if (result) {
                    return null;
                  }
                  return '*Invalid email address';
                },
              ),
              const SizedBox(height: tFormHeight - 20),

              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.phoneNo,
                decoration: const InputDecoration(
                  label: Text(tPhoneNo),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Phone Number is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.password,
                obscureText: obscurePassword,
                autocorrect: false,
                decoration: InputDecoration(
                    label: const Text(tPassword),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword
                          ? LineAwesomeIcons.eye
                          : LineAwesomeIcons.eye_slash),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*This field is required';
                  } else if (value.isNotEmpty) {
                    bool result = validatePassword(value);
                    return result ? null : 'Please use a strong password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                cursorColor: tSecondaryColor,
                obscureText: obscurePassword,
                autocorrect: false,
                decoration: const InputDecoration(
                  label: Text(tCFMPassword),
                  prefixIcon: Icon(Icons.gpp_good_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please Confirm Your Password';
                  } else if (value != controller.password.text.trim()) {
                    return 'Passwords do not Match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0))),
                    ),
                    onPressed: () {
                      // Get.to(() => OTPScreen(phoneNo: controller.phoneNo.text.trim()));
                      // Get.to(() => const OTPScreen());
                      if (_formKey.currentState!.validate()) {
                        // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                        // Get.to(() => OTPScreen(phoneNo: controller.phoneNo.text.trim()));

                        final user = UserModel(
                            email: controller.email.text.trim(),
                            password: controller.password.text.trim(),
                            fullName: controller.fullName.text.trim(),
                            emailVerified: false,
                            phoneNo: controller.phoneNo.text.trim(),
                        );

                        SignUpController.instance.createUser(user);
                      }
                    },
                    child: Text(tSignup.toUpperCase())),
              ),
            ],
          )),
    );
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      return false;
    } else if (!EmailValidator.validate(email, true)) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }
}