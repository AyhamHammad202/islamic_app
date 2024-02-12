import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/widgets/tafser_bottomsheet.dart';
import 'package:just_audio/just_audio.dart';

extension ContextMenuExtension on BuildContext {
  void showAyahMenu(
      int surahNum, int pageIndex, String surahName, int indexOfAyaInPage,
      {dynamic details, required AyaOfSurahModel ayaOfSurahModel}) {
    QuranController quranController = Get.find();
    final AudioPlayer player = AudioPlayer();
    quranController.selectedAyahIndexes.isNotEmpty
        ? BotToast.showAttachedWidget(
            target: details.globalPosition,
            verticalOffset: 60.0,
            horizontalOffset: 100.0,
            preferDirection: quranController.preferDirection,
            animationDuration: const Duration(microseconds: 700),
            animationReverseDuration: const Duration(microseconds: 700),
            attachedBuilder: (cancel) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.theme.colorScheme.background.withOpacity(.95),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                        width: 2, color: Colors.blueAccent.withOpacity(.5))),
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
                          child: tafsir_icon(height: 25.0),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: this,
                            builder: (context) {
                              return TafserBottomSheet(
                                tafser: quranController
                                    .tafserOfPage[indexOfAyaInPage],
                                ayaOfSurahModel: ayaOfSurahModel,
                                page: pageIndex,
                                numberOfSura: surahNum,
                              );
                            },
                          );
                          cancel();
                        },
                      ),
                      const Gap(6),
                      SizedBox(height: 18, child: VerticalDivider()),
                      const Gap(6),
                      GestureDetector(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          label: 'Play Ayah',
                          child: play_arrow(height: 25.0),
                        ),
                        onTap: () async {
                          player.pause();
                          await player.setUrl(ayaOfSurahModel.audioUrl);
                          await player.play();
                        },
                      ),
                      const Gap(6),
                      SizedBox(height: 18, child: VerticalDivider()),
                      const Gap(6),
                      GestureDetector(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          label: 'Copy Ayah',
                          child: copy_icon(height: 25.0),
                        ),
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text:
                                  '﴿${ayaOfSurahModel.textOfAya}﴾ [$surahName-${ayaOfSurahModel.numberOfAyaInSurah.toArabic()}]',
                            ),
                          );
                          show(context: this, message: "تم النسخ");
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
