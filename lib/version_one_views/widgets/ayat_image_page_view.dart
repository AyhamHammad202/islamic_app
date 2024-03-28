// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:islamic_app/controllers/audio_controller.dart';
// import 'package:islamic_app/controllers/bookmark_controller.dart';
// import 'package:islamic_app/controllers/quran_controller.dart';
// import 'package:islamic_app/helper.dart';
// import 'package:islamic_app/menu_extension.dart';
// import 'package:islamic_app/models/aya_of_surah_model.dart';
// import 'package:islamic_app/models/surah_model.dart';
// import 'package:islamic_app/services/last_read_service.dart';
// import 'package:islamic_app/svg_pictures.dart';

// class AyatImagePageView extends StatelessWidget {
//   const AyatImagePageView({
//     super.key,
//     required this.sorahModel,
//   });
//   final SurahModel sorahModel;
//   // final PageController pageController;

//   @override
//   Widget build(BuildContext context) {
//     QuranController quranController = Get.find();
//     AudioController audioController = Get.find();
//     BookMarkController bookMarkController = Get.find();
//     LastReadService settingsService = Get.find();
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: PageView.builder(
//         controller: quranController.pageController,
//         itemCount: 604,
//         onPageChanged: (page) {
//           settingsService.setLastRead(
//             page + 1,
//             "${DateTime.now().day.toArabic()}/${DateTime.now().month.toArabic()}/${DateTime.now().year.toArabic()}",
//             quranController
//                 .getSurahNumberByAya(quranController.pages[page].first),
//             quranController.pages[page].first.numberOfAyaInSurah,
//           );
//           quranController.globalPage.value = page;
//         },
//         itemBuilder: (context, page) {
//           quranController.getCurrentPageAyahsSeparatedForBasmala(page);
//           // quranController.getAyaTafser(page + 1);
//           return Obx(
//             () => Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: InkWell(
//                     splashColor: Colors.transparent,
//                     focusColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     radius: 0,
//                     onTap: () {
//                       quranController.clearSelection();
//                     },
//                     child: SizedBox(
//                       // height: 700,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                             quranController
//                                 .getCurrentPageAyahsSeparatedForBasmala(page)
//                                 .length, (i) {
//                           final ayas = quranController
//                               .getCurrentPageAyahsSeparatedForBasmala(page)[i];
//                           return Column(
//                             children: [
//                               Sura1BannerWithName(
//                                   ayas: ayas, quranController: quranController),
//                               Obx(
//                                 () => RichText(
//                                   textDirection: TextDirection.rtl,
//                                   textAlign: TextAlign.center,
//                                   text: TextSpan(
//                                     style: TextStyle(
//                                       fontFamily: 'page${page + 1}',
//                                       fontSize: getProportionateScreenWidth(22),
//                                       letterSpacing: .01,
//                                       wordSpacing: .01,
//                                       height: 1.9,
//                                       color: Colors.black,
//                                     ),
//                                     children: List.generate(
//                                       ayas.length,
//                                       (index) {
//                                         quranController.isSelected =
//                                             quranController
//                                                 .selectedAyahIndexes
//                                                 .contains(
//                                                     ayas[index].uniqueIdOfAya);
//                                         return TextSpan(
//                                           text: index == 0
//                                               ? "${ayas[index].text[0]} ${ayas[index].text.substring(1)}"
//                                               : ayas[index].text,
//                                           style: TextStyle(
//                                               backgroundColor: quranController
//                                                       .isSelected
//                                                   ? Colors.lightBlue.shade300
//                                                       .withOpacity(0.3)
//                                                   : bookMarkController
//                                                           .bookmarkedAyasID
//                                                           .contains(ayas[index]
//                                                               .uniqueIdOfAya)
//                                                       ? Colors.red
//                                                       : null),
//                                           recognizer:
//                                               LongPressGestureRecognizer(
//                                                   duration: Durations.long2)
//                                                 ..onLongPressStart =
//                                                     (LongPressStartDetails
//                                                         details) {
//                                                   quranController
//                                                       .toggleAyahSelection(
//                                                           ayas[index]
//                                                               .uniqueIdOfAya);
//                                                   context.showAyahMenu(
//                                                       quranController
//                                                           .getSurahNumberFromPage(
//                                                               page),
//                                                       page,
//                                                       // quranController
//                                                       //     .getSurahNameFromPage(page),
//                                                       index,
//                                                       details: details,
//                                                       ayaOfSurahModel:
//                                                           ayas[index]);
//                                                 },
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 ),
//                 audioController.isPlaying.value
//                     ? Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   audioController.audioPlayer.pause();
//                                   audioController.isPlaying.value = false;
//                                   audioController.isLoading.value = false;
//                                   quranController.selectedAyahIndexes.clear();
//                                 },
//                                 child: pauseArrow(height: 25),
//                               ),
//                               const Text("0"),
//                             ],
//                           ),
//                         ),
//                       )
//                     : const SizedBox.shrink()
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class Sura1BannerWithName extends StatelessWidget {
//   const Sura1BannerWithName({
//     super.key,
//     required this.ayas,
//     required this.quranController,
//   });

//   final List<AyaOfSurahModel> ayas;
//   final QuranController quranController;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ayas[0].numberOfAyaInSurah == 1
//             ? Column(
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SvgPicture.asset(
//                           "assets/images/design/Sorah_name_ba3.svg"),
//                       SvgPicture.asset(
//                           "assets/images/sorahs/00${quranController.getSurahNumberByAya(ayas.first)}.svg"),
//                     ],
//                   ),
//                   quranController.getSurahNumberByAya(ayas.first) == 9 ||
//                           quranController.getSurahNumberByAya(ayas.first) == 1
//                       ? const SizedBox.shrink()
//                       : SvgPicture.asset(
//                           quranController.getSurahNumberByAya(ayas.first) ==
//                                       95 ||
//                                   quranController
//                                           .getSurahNumberByAya(ayas.first) ==
//                                       97
//                               ? "assets/images/design/besmAllah2.svg"
//                               : "assets/images/design/besmAllah.svg",
//                           width: MediaQuery.of(context).size.width / 2,
//                         )
//                 ],
//               )
//             : const SizedBox.shrink(),
//       ],
//     );
//   }
// }
