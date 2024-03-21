
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/constant.dart';

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
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xff997647),
      ),
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
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
        headlineSmall: GoogleFonts.tajawal(
          color: const Color(0xffC4975B),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: GoogleFonts.tajawal(
          color: const Color(0xffD7A664),
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: GoogleFonts.tajawal(
          color: const Color(0xff313131),
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
        displayLarge: GoogleFonts.tajawal(
          color: const Color(0xff5A5A5A),
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: GoogleFonts.tajawal(
          color: const Color(0xff043336),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: GoogleFonts.tajawal(
          color: const Color(0xff757575),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: GoogleFonts.poppins(
          color: const Color(0xff765B37),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: GoogleFonts.tajawal(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.tajawal(
          color: const Color(0xff004B40),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: GoogleFonts.tajawal(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: kFontUthmanicHafs,
          color: const Color(0xff043336),
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        )),
  );
  static final dark = ThemeData(
      useMaterial3: true,
      primaryColor: darkBackgroundClr,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffFFFFFF),
        elevation: 0,
        surfaceTintColor: Color(0xffFFFFFF),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 32.sp,
          color: const Color(0xff997647),
        ),
      )
      // colorScheme: const ColorScheme(
      //   brightness: Brightness.dark,
      //   primary: c4,
      //   onPrimary: Colors.white,
      //   secondary: c4,
      //   onSecondary: c4,
      //   error: Colors.red,
      //   onError: Colors.red,
      //   background: darkBackgroundClr,
      //   onBackground: darkTextClr,
      //   surface: darkBackgroundClr,
      //   onSurface: darkTextClr,
      // ),
      // iconButtonTheme: const IconButtonThemeData(
      //     style: ButtonStyle(iconColor: MaterialStatePropertyAll(darkiconClr))),
      // splashColor: darkPrimaryClr.withOpacity(0.2),
      // hoverColor: Colors.transparent,
      // highlightColor: darkPrimaryClr.withOpacity(0.2),
      // fontFamily: 'Ibmp',
      // iconTheme: const IconThemeData(color: darkiconClr),
      );
}

TextStyle get textStyle => TextStyle(
      fontFamily: 'Ibmp',
      color: Get.isDarkMode ? darkTextClr : black,
    );

TextStyle get headeTtextStyle => const TextStyle(
      fontFamily: 'Ibmp',
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
    );



// colorScheme: const ColorScheme(
      //   brightness: Brightness.light,
      //   primary: c3,
      //   onPrimary: Colors.black,
      //   secondary: c3,
      //   onSecondary: c3,
      //   error: Colors.red,
      //   onError: Colors.red,
      //   background: c1,
      //   onBackground: black,
      //   surface: c1,
      //   onSurface: black,
      // ),
      // iconButtonTheme: const IconButtonThemeData(
      //   style: ButtonStyle(
      //     iconColor: MaterialStatePropertyAll(
      //       ligthiconClr,
      //     ),
      //   ),
      // ),
      // splashColor: ligthPrimaryClr.withOpacity(0.2),
      // hoverColor: Colors.transparent,
      // highlightColor: ligthPrimaryClr.withOpacity(0.2),
      // fontFamily: 'Ibmp',
      // iconTheme: const IconThemeData(color: ligthiconClr),