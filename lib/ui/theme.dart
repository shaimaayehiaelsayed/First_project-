import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
static  final light=ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
  static final dark=ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );

}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
          fontWeight: FontWeight.bold,
          color:Get.isDarkMode?Colors.white:darkGreyClr,
          fontSize: 24)
  );
}
TextStyle get supHeadingStyle{
  return GoogleFonts.lato(
      textStyle:TextStyle(
          fontWeight: FontWeight.w600,
          color:Get.isDarkMode?Colors.white:darkGreyClr,
          fontSize: 20
      )
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(

          fontWeight: FontWeight.w400,
          color:Get.isDarkMode?Colors.white:darkGreyClr,fontSize: 20)
  );
}
TextStyle get supTitleStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
          fontWeight: FontWeight.w400,
          color:Get.isDarkMode?Colors.white:darkGreyClr,fontSize: 16)
  );
}
TextStyle get bodyStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(

          fontWeight: FontWeight.w300,
          color:Get.isDarkMode?Colors.white:darkGreyClr,fontSize: 16)
  );
}