import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/custom_button.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareModelSheet extends StatelessWidget {
  const ShareModelSheet({super.key, required this.aya, required this.surah});
  final AyaOfSurahModel aya;
  final SurahModel surah;

  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.find();
    ReadersController readersController = Get.find();
    return Obx(() {
      return AbsorbPointer(
        absorbing: readersController.isDownloading.value,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  CustomButton(
                    title: 'شارك الآية كصوت',
                    onTap: () async {
                      audioController.ayaUniqeId.value = aya.uniqueIdOfAya;
                      final file = File(
                        audioController.ayaPath,
                      );
                      final file2 = File(
                        audioController.ayaPath,
                      );
                      if (!await file.exists()) {
                        await readersController.downloadAya(
                          file,
                          aya,
                          surah,
                          audioController.currentReader,
                        );

                        await Share.shareXFiles([
                          XFile(file.path,
                              name:
                                  "${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}"),
                          XFile(file2.path),
                        ],
                            text:
                                "${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}");
                      }
                      await Share.shareXFiles([
                        XFile(file.path,
                            name:
                                "${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}"),
                      ],
                          text:
                              "${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}");
                    },
                  ),
                  Gap(16.h),
                  CustomButton(
                    title: 'شارك الآية كنص',
                    onTap: () {
                      Share.share(
                        '﴿${aya.textOfAya}﴾ [${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}]',
                      );
                    },
                  ),
                ],
              ),
            ),
            readersController.isDownloading.value
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: audioController.downloadingProgress.value,
                      backgroundColor: Colors.grey,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
