import 'package:flutter/material.dart';
import 'package:islamic_app/views/quran/widgets/juzes_sliverlist.dart';

import '../views/quran/widgets/suras_sliverlist.dart';

const Color kBackgroundColor = Color(0xffFFFBF8);
const Color kPrimaryColor = Color(0xffFFEEDC);
const Color kSecondlyColor = Color(0xffC39B7B);
const Color kThirdlyColor = Color(0xff77554C);
const Color kForthColor = Color(0x40c39b7b);
const String kSearchAsset = "assets/images/search.svg";
const String kSorahNumberFramAsset = "assets/images/sorah_number_fram.svg";
const String kTransferAsset = "assets/images/transfer.png";
const String kFramAsset = "assets/images/Group_19.png";
const String kAppIconAsset = "assets/icon/quran.png";
const String kFontUthmanicHafs = "UthmanicHafs";
const String kFontKufamItalicVariableFont = "KufamItalicVariableFont";
const String kFontNotoNaskhArabic = "NotoNaskhArabic";
const String kFontKufamRegular = "KufamRegular";
const String kFontKufamItalic = "KufamItalic";

const String kSettingAyaFontSizeKey = "ayaFontSize";
const String kSettingAyaTafserFontSizeKey = "ayaTafserFontSize";
const String kSettingSalatAldohaKey = "salatAldoha";
const String kSettingSalatAlotrKey = "salatAlotr";

class Constant {
  Constant._();
  static const String backgroundImage = "assets/svg/view_background.png";
  static List<Widget> tabsViews = [
    const SurasSliverList(),
    const JuzesSliverList(),
  ];

  static List<int> lastPlaceBannerPageIndex = [
    76,
    206,
    330,
    340,
    348,
    365,
    375,
    413,
    415,
    434,
    450,
    496,
    504,
    523,
    546,
    554,
    556,
    583
  ];
}
