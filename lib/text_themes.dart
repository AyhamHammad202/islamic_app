import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/constant.dart';

class TextThemes {
  //Home Screen
  static TextStyle sectionsTextStyle(BuildContext context) {
    return GoogleFonts.tajawal(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xff40C9A2)
          : const Color(0xff004B40),
    );
  }

  static TextStyle lastReadTextStyle(BuildContext context) {
    return GoogleFonts.tajawal(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xffFFFFFF),
    );
  }

  static TextStyle lastSuraNameTextStyle(BuildContext context) {
    return GoogleFonts.tajawal(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: const Color(0xffFFFFFF),
    );
  }

  static TextStyle lastInfoTextStyle(BuildContext context) {
    return GoogleFonts.tajawal(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xffFFFFFF),
    );
  }

  //Search Screen
  static TextStyle searchResultsTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff313131),
      );
  static TextStyle searchTextTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      );
  static TextStyle searchSuraTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff313131),
      );
  static TextStyle searchAyaTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white60
            : const Color(0xff5A5A5A),
      );
  static TextStyle searchInfoTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade300
            : const Color(0xffA0A0A0),
      );
  static TextStyle searchHintTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff8CA1A3),
      );

  //Quran Screen
  static TextStyle quranTitleTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xff365C5E),
      );
  static TextStyle suraNumTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xff765B37),
      );
  static TextStyle tabTextStyle(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff6DAFB7)
            : const Color(0xff043336),
      );
  static TextStyle suraInfoTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xff5A5A5A),
      );
  static TextStyle juzTextStyle(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xffD7A664),
      );
  static TextStyle ayaOfJuzTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff5A5A5A),
      );
  static TextStyle juzPageTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff757575),
      );

  //Ayat View
  static TextStyle pageInfoTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffD7A664),
      );
  static TextStyle pageNumTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff5A5A5A),
      );
  static TextStyle suraNameTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xff365C5E),
      );
  static TextStyle readerTextStyle(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );
  static TextStyle ayaTimeTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffB5B5B5),
      );

  //Aya Info screen
  static TextStyle ayaInfoTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffD7A664),
      );
  static TextStyle ayaTxtTextStyle(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff2D2D2D),
      );
  static TextStyle tafserTextStyle(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff313131),
      );
  static TextStyle ayaInTafserTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff365C5E),
      );

  //Sura info Screen
  static TextStyle suraInfoTitleTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffD7A664),
      );
  static TextStyle suraInfoDescTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff313131),
      );

  //Allah Names screen
  static TextStyle allahNameTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xff5A5A5A),
      );
  static TextStyle nameIndexTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffD7A664),
      );

  //Tasbeh screen
  static TextStyle tasbehTextStyle(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : const Color(0xff313131),
      );
  static TextStyle tasbehDescTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xffA0A0A0),
      );
  static TextStyle timesTextStyle(BuildContext context) => GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xffFFFFFF),
      );

  //Occasions screen
  static TextStyle occasionTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xff043336),
      );
  static TextStyle occasionDateTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xffC4975B),
      );
  static TextStyle occasionStatueTextStyle(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xffC19A6B)
            : const Color(0xff765B37),
      );

  //Bookmark screen
  static TextStyle bookmarkedAyaTextStyle(BuildContext context) => TextStyle(
        fontFamily: kFontUthmanicHafs,
        color: const Color(0xff043336),
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle bookmarkedInfoTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xffA0A0A0),
      );

  //Drawer
  static TextStyle drawerItemTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xffE6EBEB),
      );

  //Settings screen
  static TextStyle settingTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  //Radio Screen
  static TextStyle radioChannelTextStyle(BuildContext context) =>
      GoogleFonts.tajawal(
        color: const Color(0xff043336),
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );
}
