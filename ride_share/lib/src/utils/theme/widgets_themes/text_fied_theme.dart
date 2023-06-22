import 'package:flutter/material.dart';
import 'package:ride_share/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
  const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: tSecondaryColor,
    floatingLabelStyle: TextStyle(color: tSecondaryColor),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: tSecondaryColor)),
  );

  static InputDecorationTheme darkInputDecorationTheme =
  const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: tSecondaryColor,
    floatingLabelStyle: TextStyle(color: tSecondaryColor),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: tSecondaryColor)),
  );
}