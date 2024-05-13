import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/allah_names/allah_names_view.dart';
import 'package:islamic_app/views/home/widgets/section_widget.dart';
import 'package:islamic_app/views/quran/quran_view.dart';
import 'package:islamic_app/views/quran/widgets/juzes_sliverlist.dart';
import 'package:islamic_app/views/radio/radio_select_view.dart';
import 'package:islamic_app/views/tasbeh/tasbeh_view.dart';
import 'package:islamic_app/views/year_occasion/year_occasion_view.dart';

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

  static const String appUrl =
      "https://play.google.com/store/apps/details?id=com.NourAlmomen.islamicapp";

  static const String currentReaderKey = "currentReader";

  static const String backgroundImage = "assets/svg/view_background.png";
  static List<Widget> tabsViews = [
    const SurasSliverList(),
    const JuzesSliverList(),
  ];

  static List<String> readers = [
    S.current.abdulbasitAbdusamad,
    S.current.alMinshawi,
    S.current.elHosary,
    S.current.HusaryMuallim,
    S.current.AliJaber,
    S.current.mohammedAyoub,
    S.current.alMueaqly,
    S.current.yasserAdDussary,
    S.current.abuBakrAshShaatree,
    S.current.Nasser_Alqatami,
    S.current.Alafasy,
    S.current.ahmedAjamy,
    S.current.ahmedGhamadi,
  ];
  static List<String> readersNamesDownload = [
    "عبدالباسط عبدالصمد",
    "المنشاوي",
    "الحصري",
    "الحصري معلم",
    "علي جابر",
    "محمد أيوب",
    "ماهر المعيقلي",
    "ياسر الدوسري",
    "أبو بكر الشاطري",
    "ناصر القطامي",
    "مشاري العفاسي",
    "أحمد العجمي",
    "أحمد الغامدي",
  ];
  static List<String> readersLinks = [
    "Abdul_Basit_Murattal_64kbps",
    "Minshawy_Murattal_128kbps",
    "Husary_128kbps",
    "Husary_Muallim_128kbps",
    "Ali_Jaber_64kbps",
    "Muhammad_Ayyoub_128kbps",
    "MaherAlMuaiqly128kbps",
    "Yasser_Ad-Dussary_128kbps",
    "Abu_Bakr_Ash-Shaatree_64kbps",
    "Nasser_Alqatami_128kbps",
    "Alafasy_128kbps",
    "ahmed_ibn_ali_al_ajamy_128kbps",
        "Ghamadi_40kbps"
  ];

  static List<String> radioNames = [
    S.current.VariousRecitations,
    S.current.MohammedLuhaidanRadio,
  ];
  static List<String> radioLinks = [
    "https://Qurango.net/radio/tarateel",
    "https://backup.qurango.net/radio/mohammed_allohaidan",
  ];

  static List<int> lastPlaceBannerPageIndex = [
    76,
    207,
    331,
    341,
    349,
    366,
    376,
    414,
    417,
    435,
    445,
    452,
    498,
    506,
    525,
    548,
    554,
    555,
    557,
    // 583,
    584
  ];

  static List<Widget> homeSections = [
    SectionWidget(
      title: S.current.quran,
      svgIcon: SvgPicturesMethods.quranBookIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.put(() => GeneralController());
        Get.to(
          () => const QuranView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    // SectionWidget(
    //   title: S.current.bookmarkAyat,
    //   svgIcon: SvgPicturesMethods.bookmarkIcon(
    //     height: 75.h,
    //     width: 75.w,
    //   ),
    //   onTap: () {
    //     // Get.put(() => GeneralController());
    //     Get.to(
    //       () => const BookmarkView(),
    //       transition: Transition.rightToLeftWithFade,
    //       duration: const Duration(milliseconds: 300),
    //     );
    //   },
    // ),
    SectionWidget(
      title: S.current.allahNames,
      svgIcon: SvgPicturesMethods.allahNamesIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.to(
          () => const AllahNamesView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    SectionWidget(
      title: S.current.tasbeh,
      svgIcon: SvgPicturesMethods.tasbeehIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.to(
          () => const TasbehView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    SectionWidget(
      title: S.current.islamicOccasions,
      svgIcon: SvgPicturesMethods.occasionsIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.to(
          () => const YearOccasionView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    SectionWidget(
      title: S.current.radio,
      svgIcon: SvgPicturesMethods.radioIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.to(
          () => const RadioSelectView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
  ];
}
