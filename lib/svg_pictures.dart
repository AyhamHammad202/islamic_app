import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/constants/assets.dart';

class SvgPicturesMethods {
  SvgPicturesMethods._();
  static Widget menuIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgMenu,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget calendarIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgCalendar,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget suraNumBorderIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgSuraNumBorder,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget alertCircleIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgAlertCircle,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget searchIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgSearch,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget prayIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgPray,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget lastReadIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgBook,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget lastReadBackgroundIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgLastReadBack,
      width: width ?? 30.w,
      height: height ?? 30.h,
      // fit: BoxFit.fitWidth,
    );
  }

  static Widget quranBookIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgQuranImage,
      width: width ?? 30.w,
      height: height ?? 30.h,
      fit: BoxFit.contain,
      // colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
    );
  }

  static Widget prayTimesIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgPrayTimes,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget azkarIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgAzkar,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget tasbeehIcon({double? height, double? width}) {
    return Image.asset(
      Assets.svgTassbehPng,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget mesbahaIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgMesbaha,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget qublaDirectonIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgQublaDirecton,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget allahNamesIcon({double? height, double? width}) {
    return Image.asset(
      Assets.svgAllahNamesPng,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget backIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgBackArrow,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget bookmarkIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgBookmark,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget bookmarkedIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgBookmarkedAlready,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget copyIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgCopyIcon,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget shareIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgShareIcon,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget playAudioIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgPlayAudioIcon,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }

  static Widget showTafserIcon({double? height, double? width}) {
    return SvgPicture.asset(
      Assets.svgShowTafserIcon,
      width: width ?? 30.w,
      height: height ?? 30.h,
    );
  }
}

Widget tafsirIcon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/tafsir_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget copyIcon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/copy_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget shareIcon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/share_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget playArrow({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/play-arrow.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget pauseArrow({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/pause_arrow.svg',
    width: width,
    height: height ?? 60,
  );
}
