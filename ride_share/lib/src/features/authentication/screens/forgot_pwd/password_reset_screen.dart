import 'package:dbcrypt/dbcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/authentication/controllers/otp_controller.dart';
import 'package:ride_share/src/features/authentication/screens/login/login_screen.dart';
import 'package:ride_share/src/models/user_model.dart';
import 'package:ride_share/src/repository/authentication_repository.dart';
import 'package:ride_share/src/repository/user_repository.dart';

import '../../../../common_widgets/form_header_widget.dart';
import '../../../../constants/sizes.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key, required this.phoneNo});

  final String phoneNo;

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OTPController());
    final _formKey = GlobalKey<FormState>();


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
                  image: tResetPwdScreenImage,
                  title: tResetMailTitle,
                  subTitle: tViaEmailSubtitle,
                  heightBetween: 7.0,
                  imageHeight: 0.3,
                  lineWidth: 0.2,
                ),
                const SizedBox(height: tFormHeight),

                Form(
                  key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: tSecondaryColor,
                          controller: controller.newPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text(tPassword),
                            hintText: tPassword,
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                        TextFormField(
                          cursorColor: tSecondaryColor,
                          controller: controller.confirmPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text(tCFMPassword),
                            hintText: tCFMPassword,
                            prefixIcon: Icon(Icons.gpp_good_outlined),
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  UserModel user = await UserRepository.instance.getUserDetails(widget.phoneNo);
                                  // user.password = encryptPassword(controller.newPassword.text.trim());
                                  print(user.fullName);
                                  user.password = controller.newPassword.text.trim();
                                  UserRepository.instance.updateUser(user);
                                  Get.offAll(() => const LoginScreen());
                                }
                              },
                              child: const Text("Reset")
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

  String encryptPassword(String pwd) {
    return DBCrypt().hashpw(pwd, DBCrypt().gensalt());
  }


// Future passwordReset() async{
//   try{
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text.trim());
//     showDialog(
//       context: context,
//       builder: (context){
//         return AlertDialog(
//           content: Text("An email with a link to reset your password has been sent to your account"),
//         );
//       },
//     );
//   }on FirebaseAuthException catch (e){
//     showDialog(
//       context: context,
//       builder: (context){
//         return AlertDialog(content: Text(e.message.toString()),
//         );
//       },
//     );
//   }
// }
}