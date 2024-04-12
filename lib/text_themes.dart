import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/services/theme_services.dart';

class TextThemes {
  final ThemeController _themeController = Get.find();
  //Home Screen
  static TextStyle sectionsTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff004B40),
  );
  static TextStyle lastReadTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffFFFFFF),
  );
  static TextStyle lastSuraNameTextStyle = GoogleFonts.tajawal(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffFFFFFF),
  );
  static TextStyle lastInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffFFFFFF),
  );

  //Search Screen
  static TextStyle searchResultsTextStyle = GoogleFonts.tajawal(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff313131),
  );
  static TextStyle searchSuraTextStyle = GoogleFonts.tajawal(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xff313131),
  );
  static TextStyle searchAyaTextStyle = GoogleFonts.tajawal(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5A5A5A),
  );
  static TextStyle searchInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffA0A0A0),
  );
  static TextStyle searchHintTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff8CA1A3),
  );

  //Quran Screen
  static TextStyle quranTitleTextStyle = GoogleFonts.tajawal(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff365C5E),
  );
  static TextStyle suraNumTextStyle = GoogleFonts.tajawal(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xff765B37),
  );
  static TextStyle tabTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff043336),
  );
  static TextStyle suraInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff5A5A5A),
  );
  static TextStyle juzTextStyle = GoogleFonts.tajawal(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffD7A664),
  );
  static TextStyle ayaOfJuzTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5A5A5A),
  );
  static TextStyle juzPageTextStyle = GoogleFonts.tajawal(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff757575),
  );

  //Ayat View
  static TextStyle pageInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffD7A664),
  );
  static TextStyle pageNumTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5A5A5A),
  );
  static TextStyle suraNameTextStyle = GoogleFonts.tajawal(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff365C5E),
  );

  //Aya Info screen
  static TextStyle ayaInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffD7A664),
  );
  static TextStyle ayaTxtTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff2D2D2D),
  );
  static TextStyle tafserTextStyle = GoogleFonts.tajawal(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff313131),
  );
  static TextStyle ayaInTafserTextStyle = GoogleFonts.tajawal(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff365C5E),
  );

  //Sura info Screen
  static TextStyle suraInfoTitleTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffD7A664),
  );
  static TextStyle suraInfoDescTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff313131),
  );

  //Allah Names screen
  static TextStyle allahNameTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5A5A5A),
  );
  static TextStyle nameIndexTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffD7A664),
  );

  //Tasbeh screen
  static TextStyle tasbehTextStyle = GoogleFonts.tajawal(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xff313131),
  );
  static TextStyle tasbehDescTextStyle = GoogleFonts.tajawal(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffA0A0A0),
  );
  static TextStyle timesTextStyle = GoogleFonts.roboto(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffFFFFFF),
  );

  //Occasions screen
  static TextStyle occasionTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff043336),
  );
  static TextStyle occasionDateTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffC4975B),
  );
  static TextStyle occasionStatueTextStyle = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xff765B37),
  );

  //Bookmark screen
  static TextStyle bookmarkedAyaTextStyle = TextStyle(
    fontFamily: kFontUthmanicHafs,
    color: const Color(0xff043336),
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bookmarkedInfoTextStyle = GoogleFonts.tajawal(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffA0A0A0),
  );

  //Drawer
  static TextStyle drawerItemTextStyle = GoogleFonts.tajawal(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffE6EBEB),
  );

  //Settings screen
  static TextStyle settingTextStyle = GoogleFonts.tajawal(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}
