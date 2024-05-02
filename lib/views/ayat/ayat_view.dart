import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/ayat/widgets/audio_widget.dart';
import 'package:islamic_app/views/ayat/widgets/bassmlah.dart';
import 'package:islamic_app/views/ayat/widgets/sura_bannar_with_name.dart';

import 'widgets/ayat_of_page.dart';
import 'widgets/page_info.dart';

class AyatView extends StatelessWidget {
  const AyatView({super.key, required this.surahModel});
  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final AudioController audioController = Get.find();
    final LastReadService lastReadService = Get.find();
    quranController.pageController =
        PageController(initialPage: quranController.globalPage.value);
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) {
          quranController.selectedAyahIndexes.clear();
          audioController.peauseAyaFile();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: GetX<QuranController>(builder: (controller) {
              return Text(
                quranController
                    .surahs[quranController.getSurahNumberByAya(quranController
                            .pages[quranController.globalPage.value].first) -
                        1]
                    .nameOfSurah,
                style: TextThemes.suraNameTextStyle(context),
              );
            }),
          ),
          body: Obx(() {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: quranController.pageController,
                    itemCount: 604,
                    onPageChanged: (page) {
                      lastReadService.setLastRead(
                        page + 1,
                        "${DateTime.now()}",
                        quranController.getSurahNumberByAya(
                            quranController.pages[page].first),
                        quranController.pages[page].first.numberOfAyaInSurah,
                        quranController.pages[page].first.uniqueIdOfAya,
                      );
                      audioController.isPlaying.value ||
                              audioController.isLoading.value
                          ? null
                          : audioController.ayaUniqeId.value =
                              quranController.pages[page].first.uniqueIdOfAya;
                      quranController.globalPage.value = page;
                    },
                    itemBuilder: (context, page) {
                      quranController
                          .getCurrentPageAyahsSeparatedForBasmala(page);
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        radius: 0,
                        onTap: () {
                          audioController.isPlaying.value ||
                                  audioController.isLoading.value
                              ? null
                              : quranController.clearSelection();
                          quranController.isClickedOnPage.value =
                              !quranController.isClickedOnPage.value;
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                // mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                  quranController
                                      .getCurrentPageAyahsSeparatedForBasmala(
                                          page)
                                      .length,
                                  (index) {
                                    final ayas = quranController
                                        .getCurrentPageAyahsSeparatedForBasmala(
                                            page)[index];
                                    return Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // quranController.getCurrentPageAyahsSeparatedForBasmala(pageIndex)[i];
                                        ayas.first.numberOfAyaInSurah == 1 &&
                                                !Constant
                                                    .lastPlaceBannerPageIndex
                                                    .contains(page)
                                            ? SuraBannerWithName(
                                                aya: ayas.first,
                                                quranController:
                                                    quranController,
                                              )
                                            : const SizedBox.shrink(),
                                        ayas.first.numberOfAyaInSurah == 1 &&
                                                quranController
                                                        .getSurahNumberByAya(
                                                            ayas.first) !=
                                                    1 &&
                                                quranController
                                                        .getSurahNumberByAya(
                                                            ayas.first) !=
                                                    9
                                            ? Bassmalah(
                                                aya: ayas.first,
                                                quranController:
                                                    quranController,
                                              )
                                            : const SizedBox.shrink(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: AyatOfPage(
                                              ayas: ayas,
                                              quranController: quranController,
                                              page: page,
                                            ),
                                          ),
                                        ),
                                        LastBannar(
                                            aya: ayas.last,
                                            quranController: quranController),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              PageInfo(
                                page: page,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    bottom: (audioController.isPlaying.value &&
                                quranController.isClickedOnPage.value) ||
                            quranController.isClickedOnPage.value
                        ? 25
                        : -MediaQuery.of(context).size.height / 2.5,
                    left: 30,
                    right: 30,
                    child: AudioWidget(
                      firstAyaInPage: quranController
                          .pages[quranController.globalPage.value].first,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

typedef LongPressStartDetailsFunction = void Function(LongPressStartDetails);
