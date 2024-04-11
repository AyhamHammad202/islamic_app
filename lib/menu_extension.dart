import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/aya_info/aya_info_view.dart';

import 'models/aya_of_surah_model.dart';

extension ContextMenuExtension on BuildContext {
  void showAyahMenu(
    int surahNum,
    int pageIndex,
    int indexOfAyaInPage, {
    dynamic details,
    required AyaOfSurahModel ayaOfSurahModel,
  }) {
    QuranController quranController = Get.find();
    AudioController audioController = Get.find();
    BookMarkController bookMarkController = Get.find();
    quranController.selectedAyahIndexes.isNotEmpty
        ? BotToast.showAttachedWidget(
            target: details.globalPosition,
            verticalOffset: 20.h,
            horizontalOffset: 10.w,
            preferDirection: quranController.preferDirection,
            animationDuration: const Duration(milliseconds: 100),
            animationReverseDuration: const Duration(milliseconds: 100),
            attachedBuilder: (cancel) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: const BoxDecoration(
                // color: Colors.blueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(
                      color: Colors.black,
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          label: 'Show Tafseer',
                          child:
                              SvgPicturesMethods.showTafserIcon(height: 25.0),
                        ),
                        onTap: () {
                          Get.to(
                            () => AyaInfoView(aya: ayaOfSurahModel),
                            // curve: Curves.bounceOut,
                            transition: Transition.downToUp,
                            duration: const Duration(milliseconds: 300),
                          );
                          // showModalBottomSheet(
                          //   context: this,
                          //   builder: (context) {
                          //     return TafserBottomSheet(
                          //       // tafser: quranController
                          //       //     .tafserOfPage[indexOfAyaInPage],
                          //       tafser: quranController.mapOfTafser[
                          //           ayaOfSurahModel.uniqueIdOfAya]!,
                          //       ayaOfSurahModel: ayaOfSurahModel,
                          //       page: pageIndex,
                          //       numberOfSura: surahNum,
                          //       numberOfAyaInPage: indexOfAyaInPage,
                          //     );
                          //   },
                          // );
                          quranController.clearSelection();
                          cancel();
                        },
                      ),
                      const Gap(6),
                      const SizedBox(height: 18, child: VerticalDivider()),
                      const Gap(6),
                      GestureDetector(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          label: 'Copy Ayah',
                          child: SvgPicturesMethods.copyIcon(height: 25.0),
                        ),
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text:
                                  '﴿${ayaOfSurahModel.textOfAya}﴾ [${quranController.surahs[quranController.getSurahNumberByAya(ayaOfSurahModel) - 1].nameOfSurah}-${ayaOfSurahModel.numberOfAyaInSurah.toArabic()}]',
                            ),
                          );
                          show(context: this, message: "تم النسخ");
                          quranController.clearSelection();
                          cancel();
                        },
                      ),
                      const Gap(6),
                      const SizedBox(height: 18, child: VerticalDivider()),
                      const Gap(6),
                      GetX<AudioController>(
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () async {
                              // await audioController.playAyah(ayaOfSurahModel);
                              if (audioController.isPlaying.value ||
                                  audioController.isLoading.value) {
                                await audioController.peauseAyaFile();
                                return;
                              }
                              await audioController
                                  .playAyah(ayaOfSurahModel.uniqueIdOfAya - 1);
                              quranController.isClickedOnPage.value = true;
                              cancel();
                              // .playRadio();
                            },
                            child: Semantics(
                              button: true,
                              enabled: true,
                              label: 'Play Ayah',
                              child: audioController.isLoading.value
                                  ? const SizedBox(
                                      height: 25,
                                      child: CircularProgressIndicator(),
                                    )
                                  : audioController.isPlaying.value
                                      ? pauseArrow(height: 25.0)
                                      : SvgPicturesMethods.playAudioIcon(
                                          height: 25,
                                        ),
                            ),
                          );
                        },
                      ),
                      const Gap(6),
                      const SizedBox(height: 18, child: VerticalDivider()),
                      const Gap(6),
                      GestureDetector(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          label: 'Share Ayah',
                          child: bookMarkController.bookmarkedAyasID
                                  .contains(ayaOfSurahModel.uniqueIdOfAya)
                              ? SvgPicturesMethods.bookmarkedIcon(height: 25)
                              : SvgPicturesMethods.bookmarkIcon(height: 25.0),
                        ),
                        onTap: () async {
                          await bookMarkController
                              .addAyaBookMark(ayaOfSurahModel.uniqueIdOfAya);
                          // show(context: this, message: تم النسخ");
                          quranController.clearSelection();
                          cancel();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : null;
  }
}
