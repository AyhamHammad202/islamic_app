import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color white = Colors.white;
// const Color black = Colors.black;
// const Color darkBackgroundClr = Color(0xFF121212);
// const Color lightBackgroundClr = Color(0xff3451A1);
// const Color darkTextClr = Color(0xFFE3E6E4);
// const Color iconClr = Color(0xff6898e0);
// const Color darkiconClr = Color(0xff1b69ff);
const Color white = Colors.white;
const Color black = Colors.black;
const Color darkBackgroundClr = Color(0xFF121212);
const Color lightBackgroundClr = Color(0xfffafafa);
const Color darkTextClr = Color(0xFFE3E6E4);
const Color darkPrimaryClr = Color(0xFF43766C);
const Color ligthPrimaryClr = Color(0xFF43766C);
const Color darkiconClr = Color(0xFFB19470);
const Color ligthiconClr = Color(0xFF76453B);

//تجربة الالوان بتطبيق القران
const Color c1 = Color(0xFFF3E9DC);
const Color c2 = Color(0xFFC08552);
const Color c3 = Color(0xFF5E3023);
const Color c4 = Color(0xFF895737);
const Color c5 = Color(0xFFDAB49D);

class Themes {
  static final light = ThemeData(
    useMaterial3: true,
    // primaryColor: lightBackgroundClr,
    scaffoldBackgroundColor: const Color(0xffFFFFFF),

    // scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.black,
      titleTextStyle: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xff997647),
      ),
    ),
    sliderTheme: const SliderThemeData(
      thumbColor: Color(0xffD7A664),
      activeTrackColor: Color(0xff043336),
      inactiveTrackColor: Color.fromARGB(255, 160, 157, 157),
    ),
    
    highlightColor: const Color(0xffFFD08A).withOpacity(.2),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Color(0xffF3E3CF),
      onSecondary: Color(0xffD7A664),
      secondaryContainer: Color(0xffFBF6F0),
      error: Colors.red,
      onError: Colors.red,
      background: darkBackgroundClr,
      onBackground: darkTextClr,
      surface: lightBackgroundClr,
      onSurface: Color(0xff132D2E),
    ),
  );
  static final dark = ThemeData(
    useMaterial3: true,
    // primaryColor: lightBackgroundClr,
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),

    // scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.grey.shade300,
      titleTextStyle: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xff997647),
      ),
    ),
    sliderTheme: const SliderThemeData(
      thumbColor: Color(0xffD7A664),
      activeTrackColor: Color.fromARGB(255, 15, 161, 172),
      inactiveTrackColor: Color.fromARGB(255, 160, 157, 157),
    ),
    highlightColor: const Color(0xffFFD08A).withOpacity(.2),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black54,
      onPrimary: Colors.black54,
      secondary: Color(0xffF3E3CF),
      onSecondary: Color(0xffD7A664),
      secondaryContainer: Colors.black54,
      error: Colors.red,
      onError: Colors.red,
      background: darkBackgroundClr,
      onBackground: darkTextClr,
      surface: darkBackgroundClr,
      onSurface: Color(0xff132D2E),
    ),
  );
}
