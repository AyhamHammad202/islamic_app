import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/menu_extension.dart';
// import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/widgets/audio_widget.dart';
import 'package:islamic_app/views/surah_info/surah_info_view.dart';
import 'package:quran_library/quran.dart';

class AyatView extends StatelessWidget {
  const AyatView({super.key});
  // final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final AudioController audioController = Get.find();
    final BookMarkController bookMarkController = Get.find();
    final LastReadService lastReadService = Get.find();
    // quranController.pageController =
    //     PageController(initialPage: quranController.globalPage.value);
    return BackgroundImage(
      child: PopScope(
        onPopInvokedWithResult: (didPop, results) {
          // QuranLibrary().
          audioController.stopAudioPlayer();
        },
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(() {
              return Stack(
                children: [
                  QuranLibraryScreen(
                    backgroundColor: Colors.transparent,
                    textColor: Get.isDarkMode ? Colors.white : Colors.black,
                    ayahSelectedBackgroundColor: Get.theme.highlightColor,
                    useDefaultAppBar: false,
                    // optimizeScrolling: true,
                    ayahBookmarked: bookMarkController.bookmarkedAyasID,
                    bookmarkList: bookMarkController.ayasWithBookMark,
                    bookmarksColor: const Color(0xffc4975b).withOpacity(0.4),
                    bannerStyle: BannerStyle(
                      bannerSvgHeight: QuranLibrary().currentFontsSelected == 0
                          ? 40.h
                          : 120.h,
                      // bannerSvgWidth: Get.width * .2,
                      bannerSvgPath: "assets/images/design/Sorah_name_ba3.svg",
                    ),
                    basmalaStyle: BasmalaStyle(
                      basmalaHeight: QuranLibrary().currentFontsSelected == 0
                          ? 30.h
                          : 100.h,
                      basmalaColor: Theme.of(context).colorScheme.onSecondary,
                    ),
                    surahNameStyle: SurahNameStyle(
                      surahNameHeight: QuranLibrary().currentFontsSelected == 0
                          ? 25.h
                          : 80.h,
                    ),
                    onPageChanged: (pageNumber) {
                      lastReadService.updateLastRead(
                          quranController.pages[pageNumber].first);
                      if (!audioController.isPlaying.value ||
                          audioController.isLoading.value) {
                        audioController.ayaUniqeId.value = quranController
                            .pages[pageNumber].first.ayahUQNumber;
                      }
                    },
                    onSurahBannerPress: (surah) {
                      Get.to(
                        () => SurahInfoView(
                            surahModel:
                                quranController.surahs[surah.number - 1]),
                        transition: Transition.leftToRight,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    onAyahLongPress: (details, ayah) {
                      context.showAyahMenu(
                        QuranLibrary()
                            .getCurrentSurahDataByAyahUniqueNumber(
                                ayahUniqueNumber: ayah.ayahUQNumber)
                            .surahNumber,
                        ayah.page,
                        ayah.ayahUQNumber,
                        details: details,
                        ayaOfSurahModel: ayah,
                      );
                    },
                    onPagePress: () {
                      if (!audioController.isPlaying.value) {
                        QuranLibrary().quranCtrl.clearSelection();
                      }
                      quranController.isClickedOnPage.value =
                          !quranController.isClickedOnPage.value;
                      log("IS CLICKED ${quranController.isClickedOnPage.value}");
                    },
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    bottom: quranController.isClickedOnPage.value
                        ? 10.h //  start at bottom of screen
                        : -MediaQuery.of(context).size.height /
                            3, //  slide from below
                    left: 5.w,
                    right: 5.w,
                    child: AudioWidget(
                      firstAyaInPage: quranController
                          .pages[QuranLibrary().currentPageNumber].first,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 400),
                    width: Get.width,
                    top: quranController.isClickedOnPage.value
                        ? MediaQuery.of(context).padding.top
                        : -100,
                    child: Container(
                      width: Get.width,
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: Get.back,
                            icon: Icon(
                              Icons.arrow_back_sharp,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.dialog(Dialog(
                                child: QuranLibrary().getFontsDownloadWidget(
                                  context,
                                  isDark: Get.isDarkMode,
                                ),
                              ));
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            })),
      ),
    );
  }
}
