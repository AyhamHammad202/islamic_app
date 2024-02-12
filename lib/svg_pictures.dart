import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget tafsir_icon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/tafsir_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget copy_icon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/copy_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget share_icon({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/share_icon.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget play_arrow({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/play-arrow.svg',
    width: width,
    height: height ?? 60,
  );
}

Widget pause_arrow({double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/pause_arrow.svg',
    width: width,
    height: height ?? 60,
  );
}