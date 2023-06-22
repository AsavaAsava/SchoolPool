import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_share/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:ride_share/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:ride_share/src/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}
