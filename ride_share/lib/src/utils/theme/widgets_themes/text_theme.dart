import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_share/src/constants/colors.dart';

class TTextTheme{
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(fontSize:28.0, fontWeight:FontWeight.bold, color: tBlackColor,),
    displayMedium: GoogleFonts.montserrat(fontSize:24.0, fontWeight:FontWeight.w700, color: tBlackColor,),
    displaySmall: GoogleFonts.poppins(fontSize:24.0, fontWeight:FontWeight.w700, color: tBlackColor,),
    headlineMedium: GoogleFonts.poppins(fontSize:16.0, fontWeight:FontWeight.w600, color: tBlackColor,),
    titleLarge: GoogleFonts.poppins(fontSize:14.0, fontWeight:FontWeight.w600, color: tBlackColor,),
    bodyLarge: GoogleFonts.poppins(fontSize:18.0, fontWeight:FontWeight.normal, color: tBlackColor,),
    bodyMedium: GoogleFonts.poppins(fontSize:14.0, fontWeight:FontWeight.normal, color: tBlackColor,),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(fontSize:28.0, fontWeight:FontWeight.bold, color: tWhiteColor,),
    displayMedium: GoogleFonts.montserrat(fontSize:24.0, fontWeight:FontWeight.w700, color: tWhiteColor,),
    displaySmall: GoogleFonts.poppins(fontSize:24.0, fontWeight:FontWeight.w700, color: tWhiteColor,),
    headlineMedium: GoogleFonts.poppins(fontSize:16.0, fontWeight:FontWeight.w600, color: tWhiteColor,),
    titleLarge: GoogleFonts.poppins(fontSize:14.0, fontWeight:FontWeight.w600, color: tWhiteColor,),
    bodyLarge: GoogleFonts.poppins(fontSize:18.0, fontWeight:FontWeight.normal, color: tWhiteColor,),
    bodyMedium: GoogleFonts.poppins(fontSize:14.0, fontWeight:FontWeight.normal, color: tWhiteColor,),
  );
}