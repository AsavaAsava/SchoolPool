import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/constants/text_strings.dart';
import 'package:ride_share/src/features/authentication/screens/forgot_pwd/forgot_pwd_phone_screen.dart';

import '../../../../constants/sizes.dart';
import 'forgot_pwd_btn_widget.dart';
import 'forgot_pwd_mail_screen.dart';

class ForgotPasswordModal {
  static void buildShowModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tForgotPwdTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textScaleFactor: 1.8,
            ),
            Text(
              tForgotPwdSubTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textScaleFactor: 1.3,
            ),
            const SizedBox(
              height: 30.0,
            ),
            ForgotPasswordWidget(
                icon: Icons.mail_outline_outlined,
                title: tEmail,
                subTitle: tResetViaEmail,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgotPasswordMailScreen());
                }),
            const SizedBox(
              height: 20.0,
            ),
            ForgotPasswordWidget(
                icon: Icons.mobile_friendly_outlined,
                title: tPhoneNo,
                subTitle: tResetViaPhone,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgotPasswordPhoneScreen());
                }),
          ],
        ),
      ),
    );
  }
}