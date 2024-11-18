import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/allah_names/allah_names_view.dart';
import 'package:islamic_app/views/azkar_categories/azkar_categories_view.dart';
import 'package:islamic_app/views/download_ayas/downlodad_ayas_view.dart';
import 'package:islamic_app/views/more_view/widgets/more_item.dart';
import 'package:islamic_app/views/home/widgets/section_widget.dart';
import 'package:islamic_app/views/quran/widgets/juzes_listview.dart';
import 'package:islamic_app/views/radio/radio_select_view.dart';
import 'package:islamic_app/views/settings/settings_view.dart';
import 'package:islamic_app/views/tasbeh/tasbeh_view.dart';
import 'package:islamic_app/views/year_occasion/year_occasion_view.dart';
import 'package:share_plus/share_plus.dart';

import '../views/quran/widgets/suras_listview.dart';
import 'assets.dart';

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

  static const String bookLottie = "assets/lottie/open_book.json";
  static const String searchLottie = "assets/lottie/search.json";

  static const String appUrl =
      "https://play.google.com/store/apps/details?id=com.NourAlmomen.islamicapp";

  static const String currentReaderKey = "currentReader";

  static const String backgroundImage = "assets/svg/view_background.png";
  static List<Widget> tabsViews = [
    const SurasListView(),
    const JuzesListView(),
  ];

  static const diacriticsMap = {
    'أ': 'ا',
    'إ': 'ا',
    'آ': 'ا',
    'ٱ': 'ا',
    'إٔ':
        'ا', // These mappings already seem comprehensive, but double inclusion for clarity
    'إٕ': 'ا',
    'إٓ': 'ا',
    'أَ': 'ا',
    'إَ': 'ا',
    'آَ': 'ا',
    'إُ': 'ا',
    'إٌ': 'ا',
    'إً': 'ا',
    // 'ة': 'ه',
    'ً': '',
    'ٌ': '',
    'ٍ': '',
    'َ': '',
    'ُ': '',
    'ِ': '',
    'ّ': '',
    'ْ': '',
    'ـ': '',
    // Adding more comprehensive handling for combinations and less common diacritics
    'ٰ': '', // Dagger alif (small alif on top of characters)
    'ٖ': '', // Kharijatayn (small noon)
    'ٗ': '', // Inverted damma
    'ٕ': '', // Small kasra
    'ٓ': '', // Maddah above
    'ۖ': '', // Small high seen
    'ۗ': '', // Small high rounded zero
    'ۘ': '', // Small high upright rectangular zero
    'ۙ': '', // Small high dotless head of khah
    'ۚ': '', // Small high meem isolated form
    'ۛ': '', // Small low seen
    'ۜ': '', // Small waw
    '۝': '', // Small yeh
    '۞': '', // Small high noon
    '۟': '', // Empty centre low stop
    '۠': '', // Empty centre high stop
    'ۡ': '', // Rounded high stop with filled centre
    'ۢ': '', // Small low meem
  };

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

  // static List<Widget> homeNavItems = [
  //   NavItem(
  //     icon: SvgPicturesMethods.navHomeIcon(),
  //     title: S.current.navhome,
  //   ),
  //   NavItem(
  //     icon: SvgPicturesMethods.navQuranIcon(),
  //     title: S.current.navquran,
  //     onTap: () {
  //       Get.put(() => GeneralController());
  //       Get.to(
  //         () => const QuranView(),
  //         transition: Transition.rightToLeftWithFade,
  //         duration: const Duration(milliseconds: 300),
  //       );
  //     },
  //   ),
  //   NavItem(
  //     icon: SvgPicturesMethods.navArchiveIcon(),
  //     title: S.current.navbookmark,
  //     onTap: () {
  //       Get.to(
  //         () => const BookmarkView(),
  //         transition: Transition.rightToLeftWithFade,
  //         duration: const Duration(milliseconds: 300),
  //       );
  //     },
  //   ),
  //   NavItem(
  //     icon: SvgPicturesMethods.navMenuIcon(),
  //     title: S.current.navmore,
  //     onTap: () {
  //       Get.to(
  //         () => const MoreView(),
  //         transition: Transition.rightToLeftWithFade,
  //         duration: const Duration(milliseconds: 300),
  //       );
  //     },
  //   ),
  // ];
  static List<Widget> homeSections = [
    SectionWidget(
      title: S.current.azkar,
      svgIcon: SvgPicturesMethods.azkarIcon(
        height: 50.h,
        width: 50.w,
      ),
      onTap: () {
        Get.to(
          () => const AzkarCategoriesView(),
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

  static List<String> homeNavItemsIconsTitles = [
    Assets.svgHome,
    Assets.svgQuran,
    Assets.svgArchive,
    Assets.svgMenuV2,
  ];
  static List<String> homeNavItemsTitles = [
    S.current.navhome,
    S.current.navquran,
    S.current.navbookmark,
    S.current.navmore,
  ];
  static List<Widget> drawerItems = [
    MoreItem(
      title: S.current.downloadAyat,
      leading: SvgPicturesMethods.playAudioIcon(),
      onTap: () {
        Get.to(
          () => const DownloadAyasView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    MoreItem(
      title: S.current.settings,
      leading: Image.asset(Assets.svgSettingsPng),
      onTap: () {
        Get.to(
          () => const SettingsView(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    ),
    MoreItem(
      title: S.current.shareApp,
      leading: Image.asset(Assets.svgShareApp),
      onTap: () async {
        Share.share(
          "${S.current.shareAppText} ${Constant.appUrl}",
        );
      },
    ),
  ];
}
