import 'package:flutter/material.dart';
import 'package:ride_share/src/constants/colors.dart';
import 'package:ride_share/src/constants/image_strings.dart';
import 'package:ride_share/src/constants/text_strings.dart';

import '../../../../common_widgets/form_header_widget.dart';
import '../../../../constants/sizes.dart';

class ForgotPasswordMailScreen extends StatefulWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  State<ForgotPasswordMailScreen> createState() => _ForgotPasswordMailScreenState();
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordMailScreen> {
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
                  subTitle: tViaEmailSubtitle,
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
                            label: Text(tEmail),
                            hintText: tEmail,
                            prefixIcon: Icon(Icons.mail_outline_outlined),
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {

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