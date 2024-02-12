// import 'dart:convert';
// import 'dart:developer';

// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:get/get.dart';

// import 'package:flutter_svg/svg.dart';
// import 'package:islamic_app/models/surah_model.dart';


// class QuranController extends GetxController {
//   var currentPage = 1.obs;
//   List<SurahModel> surahs = [];
//   List<List<AyaOfSurahModel>> pages = [];
//   List<AyaOfSurahModel> allAyahs = [];

//   RxInt selectedVerseIndex = 0.obs;
//   RxBool selectedAyah = false.obs;
//   var selectedAyahIndexes = <int>[].obs;
//   bool isSelected = false;
//   final ScrollController scrollIndicatorController = ScrollController();
//   RxInt selectedIndicatorIndex = 0.obs;
//   // PreferDirection preferDirection = PreferDirection.bottomCenter;
//   RxDouble textWidgetPosition = (-240.0).obs;
//   RxBool isPlayExpanded = false.obs;

//   // final generalCtrl = sl<GeneralController>();
//   // final themeCtrl = sl<ThemeController>();

//   void toggleAyahSelection(int index) {
//     if (selectedAyahIndexes.contains(index)) {
//       selectedAyahIndexes.remove(index);
//     } else {
//       selectedAyahIndexes.add(index);
//     }
//     selectedAyahIndexes.refresh();
//   }

//   void clearSelections() {
//     selectedAyahIndexes.clear();
//     selectedAyahIndexes.refresh();
//   }

//   @override
//   void onInit() async {
//     super.onInit();
//     await loadQuran();
//   }

//   Future<void> loadQuran() async {
//     String jsonString = await rootBundle.loadString('assets/quranV2.json');
//     Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
//     List<dynamic> surahsJson = jsonResponse['data']['surahs'];
//     surahs = surahsJson.map((s) => Surah.fromJson(s)).toList();

//     for (final surah in surahs) {
//       allAyahs.addAll(surah.ayahs);
//       log('Added ${surah.arabicName} ayahs');
//       update();
//     }
//     List.generate(604, (pageIndex) {
//       pages.add(allAyahs.where((ayah) => ayah.page == pageIndex + 1).toList());
//     });
//     log('Pages Length: ${pages.length}', name: 'Quran Controller');
//   }

//   List<List<AyaOfSurahModel>> getCurrentPageAyahsSeparatedForBasmala(int pageIndex) =>
//       pages[pageIndex]
//           .splitBetween((f, s) => f.ayahNumber > s.ayahNumber)
//           .toList();

//   List<Ayah> getCurrentPageAyahs(int pageIndex) => pages[pageIndex];

//   /// will return the surah number of the first ayahs..
//   /// even if the page contains another surah..
//   /// if you wanna get the last's ayah's surah information
//   /// you can use [ayahs.last].
//   int getSurahNumberFromPage(int pageNumber) => surahs
//       .firstWhere(
//           (s) => s.ayahs.contains(getCurrentPageAyahs(pageNumber).first))
//       .surahNumber;

//   int getSurahNumberByAyah(Ayah ayah) =>
//       surahs.firstWhere((s) => s.ayahs.contains(ayah)).surahNumber;

//   // void indicatorOnTap(int pageNumber, int itemWidth, double screenWidth) {
//   //   currentPage.value = pageNumber;
//   //   selectedIndicatorIndex.value = pageNumber;
//   //   final targetOffset =
//   //       itemWidth * pageNumber - (screenWidth * .69 / 2) + itemWidth / 2;
//   //   scrollIndicatorController.animateTo(
//   //     targetOffset,
//   //     duration: const Duration(milliseconds: 500),
//   //     curve: Curves.easeIn,
//   //   );
//   //   generalCtrl.quranPageController.animateToPage(
//   //     pageNumber,
//   //     duration: const Duration(milliseconds: 500),
//   //     curve: Curves.easeIn,
//   //   );
//   // }

//   void indicatorScroll(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     const itemWidth = 80;
//     selectedIndicatorIndex.value = currentPage.value;
//     final targetOffset =
//         itemWidth * currentPage.value - (screenWidth * .69 / 2) + itemWidth / 2;
//     if (scrollIndicatorController.hasClients) {
//       final targetOffset = itemWidth * currentPage.value -
//           (screenWidth * .69 / 2) +
//           itemWidth / 2;
//       scrollIndicatorController.animateTo(
//         targetOffset,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeIn,
//       );
//     } else {
//       // Handle the case where the scroll view is not ready
//     }
//   }

//   Widget bannerWithSurahName(Widget child, String number) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         child,
//         surahNameWidget(number, Get.theme.hintColor),
//       ],
//     );
//   }

//   Widget surahBannerWidget(String number) {
//     return bannerWithSurahName(surahBanner1(), number);
//   }
// }

// Widget surahNameWidget(String num, Color color) {
//   return SizedBox(
//     height: 50,
//     child: SvgPicture.asset(
//       'assets/svg/surah_name/00$num.svg',
//       height: getProportionateScreenWidth(38),
//       colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
//     ),
//   );
// }

// Widget surahBanner1({double? height, double? width}) {
//   return SvgPicture.asset('assets/svg/surah_banner1.svg',
//       width: width, height: height ?? getProportionateScreenWidth(40));
// }

// Widget besmAllah() {
//   return SvgPicture.asset(
//     'assets/svg/besmAllah.svg',
//     width: 220,
//     colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
//   );
// }

// Widget besmAllah2() {
//   return SvgPicture.asset(
//     'assets/svg/besmAllah2.svg',
//     width: 220,
//     colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
//   );
// }
