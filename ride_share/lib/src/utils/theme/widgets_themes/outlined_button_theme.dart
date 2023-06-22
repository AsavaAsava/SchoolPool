import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class TOutlinedButtonTheme{
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor, width: 2.0,),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor, width: 2.0,),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );

}