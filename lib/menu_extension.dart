import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/share_model_sheet.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/aya_info/aya_info_view.dart';
import 'package:lottie/lottie.dart';
import 'package:quran_library/quran.dart';

extension ContextMenuExtension on BuildContext {
  void showAyahMenu(
    int surahNum,
    int pageIndex,
    int indexOfAyaInPage, {
    dynamic details,
    required AyahModel ayaOfSurahModel,
  }) {
    QuranController quranController = Get.find();
    AudioController audioController = Get.find();
    BookMarkController bookMarkController = Get.find();
    // QuranLibrary().quranCtrl.selectedAyahsByUnequeNumber.isNotEmpty?
    BotToast.showAttachedWidget(
      target: details.globalPosition,
      verticalOffset: 20.h,
      horizontalOffset: 10.w,
      preferDirection: quranController.preferDirection,
      animationDuration: const Duration(milliseconds: 100),
      animationReverseDuration: const Duration(milliseconds: 100),
      attachedBuilder: (cancel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Semantics(
                    button: true,
                    enabled: true,
                    label: 'Show Tafseer',
                    child: SvgPicturesMethods.showTafserIcon(height: 25.0),
                  ),
                  onTap: () async {
                    await QuranLibrary()
                        .closeAndInitializeDatabase(pageNumber: pageIndex);
                    Get.to(
                      () => AyaInfoView(
                        aya: ayaOfSurahModel,
                        surahModel: quranController.surahs[surahNum - 1],
                      ),
                      // curve: Curves.bounceOut,
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 300),
                    );
                    QuranLibrary().quranCtrl.clearSelection();
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
                            '﴿${ayaOfSurahModel.ayaTextEmlaey}﴾ [${quranController.surahs[surahNum - 1].arabicName}-${ayaOfSurahModel.ayahUQNumber.toArabic()}]',
                      ),
                    );
                    show(context: this, message: "تم النسخ");
                    QuranLibrary().quranCtrl.clearSelection();
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
                        if ((audioController.isPlaying.value ||
                                audioController.isLoading.value) &&
                            audioController.currentAya.ayahUQNumber ==
                                ayaOfSurahModel.ayahUQNumber) {
                          await audioController.peauseAyaFile();
                          return;
                        }
                        await audioController.playAyah(ayaOfSurahModel);
                        quranController.isClickedOnPage.value = true;
                        cancel();
                        // .playRadio();
                      },
                      child: Semantics(
                        button: true,
                        enabled: true,
                        label: 'Play Ayah',
                        child: audioController.isLoading.value
                            ? SizedBox(
                                height: 25,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Color(0xffd6a663),
                                    BlendMode.srcIn,
                                  ),
                                  child: Lottie.asset(
                                    "assets/lottie/loading.json",
                                  ),
                                ),
                              )
                            : audioController.currentAya.ayahUQNumber ==
                                        ayaOfSurahModel.ayahUQNumber &&
                                    audioController.isPlaying.value
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
                    label: 'BookMark Ayah',
                    child: bookMarkController.bookmarkedAyasID
                            .contains(ayaOfSurahModel.ayahUQNumber)
                        ? SvgPicturesMethods.bookmarkedIcon(height: 25)
                        : SvgPicturesMethods.bookmarkIcon(height: 25.0),
                  ),
                  onTap: () async {
                    await bookMarkController
                        .addAyaBookMark(ayaOfSurahModel.ayahUQNumber);
                    // show(context: this, message: تم النسخ");
                    QuranLibrary().quranCtrl.clearSelection();
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
                    label: 'Share Ayah',
                    child: SvgPicturesMethods.shareIcon(height: 25.0),
                  ),
                  onTap: () async {
                    showModalBottomSheet(
                      context: this,
                      builder: (context) {
                        return ShareModelSheet(
                          aya: ayaOfSurahModel,
                          surah: quranController.surahs[surahNum - 1],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // : null;
  }
}
