import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/features/authentication/screens/forgot_pwd/forgot_password_bottom_modal.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/login_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;
  bool invalidCredentials = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter an email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: tEmail,
                    hintText: tEmail,
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              TextFormField(
                cursorColor: tSecondaryColor,
                controller: controller.password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter your password';
                  }
                  return null;
                },
                obscureText: obscurePassword,
                autocorrect: false,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password_outlined),
                    labelText: tPassword,
                    hintText: tPassword,
                    border: const OutlineInputBorder(),
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
                    )),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              Visibility(
                  visible: invalidCredentials,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const Text(
                    "Invalid Credentials. Please try again.",
                    style: TextStyle(color: Colors.red),
                  )),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0))),
                    ),
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   bool result = await AuthenticationRepository.instance
                      //       .loginUserWithEmailAndPassword(
                      //       controller.email.text.trim(),
                      //       controller.password.text.trim());
                      //   if (result == true) {
                      //     Get.offAll(() => const DashboardScreen());
                      //   } else {
                      //     setState(() {
                      //       invalidCredentials = true;
                      //     });
                      //   }
                      // }
                    },
                    child: Text(tLogin.toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.5))),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgotPasswordModal.buildShowModalSheet(context);
                    },
                    child: const Text(tForgotPassword, style: TextStyle(color: tSecondaryColor),)),
              ),
            ],
          ),
        ));
  }
}