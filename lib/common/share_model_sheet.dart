import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/custom_button.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/models/surah_model.dart';

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
                    title: S.current.shareAyaAudio,
                   
                    onTap: () async {
                      readersController.shareAudio(
                        audioController,
                        readersController,
                        aya,
                        surah,
                      );
                    },
                  ),
                  Gap(16.h),
                  CustomButton(
                    title: S.current.shareAyaText,
                    onTap: () {
                      readersController.shareText(aya, surah);
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
